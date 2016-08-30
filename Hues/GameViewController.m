//
//  GameViewController.m
//  Hues
//
//  Created by Drew Dunne on 7/22/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "GameViewController.h"
#import "NSString+MD5.h"
#include <stdlib.h>

#define GameInfoViewHeight 112.0
#define IS_WIDESCREEN ((double)[[UIScreen mainScreen] bounds].size.height >= (double)568)

void GVControlSoundManagerAudioServicesSystemSoundCompletionProc (SystemSoundID soundID, void *clientData) {
    AudioServicesDisposeSystemSoundID(soundID);
}

@interface GameViewController () {
    BOOL isNewHighScore;
}

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    selectedColor = [UIColor getRandomHue];
    selectedColorName = selectedColor.getHuesColor;
    [[ScoreModel sharedScoreModel] newGame];
    
    gameInfoView = [[GameInfoView alloc] initWithFrame:CGRectMake(0, /*0-GameInfoViewHeight-1*/0, self.view.frame.size.width, GameInfoViewHeight)];
    [gameInfoView.pause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [gameInfoView.pu2x2 addTarget:self action:@selector(use2x2) forControlEvents:UIControlEventTouchUpInside];
    [gameInfoView.puSkip addTarget:self action:@selector(useSkip) forControlEvents:UIControlEventTouchUpInside];
    [gameInfoView.puAddTime addTarget:self action:@selector(useAddTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gameInfoView];
    
    double sideLength = self.view.frame.size.width;
    double yPos = (self.view.frame.size.height - gameInfoView.frame.size.height - sideLength)/2 + gameInfoView.frame.size.height;
    gridView = [[GridView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-sideLength)/2, yPos, sideLength, sideLength) andTilesPerRow:3];
    gridView.delegate = self;
    [self resetScore];
    [self reset];
    [gridView updateTileImagesAnimated:false];
    [gridView updateTileColorAnimated:false];
    [gridView setAllTilesEnabled:true];
    [self.view addSubview:gridView];
    
    pauseView = [[PauseCover alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    pauseView.delegate = self;
    [self.view addSubview:pauseView];
    
    newHighAlert = [[HuesAlert alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    newHighAlert.delegate = self;
    [newHighAlert setTitle:@"New High Score!"];
    [newHighAlert setDismissButtonText:@"Awesome"];
    [self.view addSubview:newHighAlert];
    
    shouldRestartGame = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartGameReceived) name:@"com.drewsdunne.hues.restartGame" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (shouldRestartGame) {
        selectedColor = [UIColor getRandomHue];
        selectedColorName = selectedColor.getHuesColor;
        [[ScoreModel sharedScoreModel] newGame];
        [self resetScore];
        [self reset];
        [gridView updateTileImagesAnimated:false];
        [gridView updateTileColorAnimated:false];
        [gridView setAllTilesEnabled:true];
        shouldRestartGame = NO;
    }
}

- (void)restartGameReceived {
    shouldRestartGame = YES;
}

- (void)use2x2 {
    if ([[ScoreModel sharedScoreModel] use2x2Powerup]) {
        [gameInfoView update2x2Title];
        [gameInfoView enablePowerups:false];
        
//        NSArray *remainingGrid = @[[NSNumber numberWithInteger:discoloredTile]];
        NSArray *remainingGrid;
        // Need algorithm
        int rand = arc4random_uniform(2);
        int rand2 = arc4random_uniform(2);
        switch (discoloredTile) {
            case 1:
                remainingGrid = @[[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2], [NSNumber numberWithInteger:4], [NSNumber numberWithInteger:5]];
                break;
            case 2:
                remainingGrid = (rand == 1) ? @[[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2], [NSNumber numberWithInteger:4], [NSNumber numberWithInteger:5]] : @[[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3], [NSNumber numberWithInteger:5], [NSNumber numberWithInteger:6]];
                break;
            case 3:
                remainingGrid = @[[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3], [NSNumber numberWithInteger:5], [NSNumber numberWithInteger:6]];
                break;
            case 4:
                remainingGrid = (rand == 1) ? @[[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2], [NSNumber numberWithInteger:4], [NSNumber numberWithInteger:5]] : @[[NSNumber numberWithInteger:4],[NSNumber numberWithInteger:5], [NSNumber numberWithInteger:7], [NSNumber numberWithInteger:8]];
                break;
            case 5:
                remainingGrid = (rand == 1) ? @[@[[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2], [NSNumber numberWithInteger:4], [NSNumber numberWithInteger:5]], @[[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3], [NSNumber numberWithInteger:5], [NSNumber numberWithInteger:6]]] : @[ @[[NSNumber numberWithInteger:4],[NSNumber numberWithInteger:5], [NSNumber numberWithInteger:7], [NSNumber numberWithInteger:8]], @[[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6], [NSNumber numberWithInteger:8], [NSNumber numberWithInteger:9]]];
                remainingGrid = remainingGrid[rand2];
                break;
            case 6:
                remainingGrid = (rand == 1) ? @[[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3], [NSNumber numberWithInteger:5], [NSNumber numberWithInteger:6]] : @[[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6], [NSNumber numberWithInteger:8], [NSNumber numberWithInteger:9]];
                break;
            case 7:
                remainingGrid = @[[NSNumber numberWithInteger:4],[NSNumber numberWithInteger:5], [NSNumber numberWithInteger:7], [NSNumber numberWithInteger:8]];
                break;
            case 8:
                remainingGrid = (rand == 1) ? @[[NSNumber numberWithInteger:4],[NSNumber numberWithInteger:5], [NSNumber numberWithInteger:7], [NSNumber numberWithInteger:8]] : @[[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6], [NSNumber numberWithInteger:8], [NSNumber numberWithInteger:9]];
                break;
            case 9:
                remainingGrid = @[[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6], [NSNumber numberWithInteger:8], [NSNumber numberWithInteger:9]];
                break;
                
            default:
                remainingGrid = @[];
                break;
        }
        [gridView setSmallerGridContainingTiles:remainingGrid];
        
    } else {
        [self noPUAlert];
    }
}

- (void)useSkip {
    if ([[ScoreModel sharedScoreModel] useSkipPowerup]) {
        [gameInfoView updateSkipTitle];
        [gameInfoView enablePowerups:false];
        [gameTimer invalidate];
        // Animate
        double sideLength = self.view.frame.size.width;
        double yPos = (self.view.frame.size.height - gameInfoView.frame.size.height - sideLength)/2 + gameInfoView.frame.size.height;
        int pushAmount = self.view.frame.size.width;
        [UIView beginAnimations:@"skip" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(skipFinish)];
        [UIView setAnimationDuration:0.15];
        gridView.frame = CGRectMake((self.view.frame.size.width-sideLength)/2 - pushAmount, yPos, sideLength, sideLength);
        [UIView commitAnimations];
        
        [self reset];
    } else {
        [self noPUAlert];
    }
}

- (void)skipFinish {
    double sideLength = self.view.frame.size.width;
    double yPos = (self.view.frame.size.height - gameInfoView.frame.size.height - sideLength)/2 + gameInfoView.frame.size.height;
    int pushAmount = self.view.frame.size.width;
    gridView.frame = CGRectMake((self.view.frame.size.width-sideLength)/2 + pushAmount, yPos, sideLength, sideLength);
    [UIView beginAnimations:@"skip2" context:nil];
    [UIView setAnimationDuration:0.3];
    gridView.frame = CGRectMake((self.view.frame.size.width-sideLength)/2, yPos, sideLength, sideLength);
    [UIView commitAnimations];
}

- (void)useAddTime {
    if ([[ScoreModel sharedScoreModel] useAddTimePowerup]) {
        [gameInfoView updateAddTimeTitle];
        [gameInfoView enablePowerups:false];
        // Animate
        [gameInfoView flashTime];
        time += 100;
    } else {
        [self noPUAlert];
    }
}

- (void)noPUAlert {
    
}

- (NSString *)soundForTileWithTag:(NSInteger)tag {
    return [[NSBundle mainBundle] pathForResource:@"touch" ofType:@"wav"];
}

- (UIColor *)colorForTileWithTag:(NSInteger)tag {
    if (tag == discoloredTile) {
        return discoloredColor;
    }
    return selectedColor;
}

- (void)gridContainerTileWasPressed:(NSInteger)tile {
    
    // For testing:
//    tile = discoloredTile;
    
    [gridView showResponse:(tile == discoloredTile) onTile:tile];
    [gameTimer invalidate];
    if (tile == discoloredTile) {
        
        NSURL *filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"correct" ofType:@"wav"]];
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &sound);
        CFStringRef currentRunLoopMode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
        AudioServicesAddSystemSoundCompletion(sound, NULL, currentRunLoopMode, &GVControlSoundManagerAudioServicesSystemSoundCompletionProc, NULL);
        CFRelease(currentRunLoopMode);
        AudioServicesPlaySystemSound(sound);
        
        [self addToScore];
        [self reset];
    } else {
        [gameInfoView enableButtonBar:false];
        
        NSURL *filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"incorrect" ofType:@"wav"]];
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &sound);
        CFStringRef currentRunLoopMode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
        AudioServicesAddSystemSoundCompletion(sound, NULL, currentRunLoopMode, &GVControlSoundManagerAudioServicesSystemSoundCompletionProc, NULL);
        CFRelease(currentRunLoopMode);
        AudioServicesPlaySystemSound(sound);
        
        [self reportScore];
        [gridView highlightTile:discoloredTile];
    }
}

//- (void)addToScore {
//    /*float distanceFromZero = sqrt(pow(ABS(varyR), 2)+pow(ABS(varyG), 2)+pow(ABS(varyB), 2));
//    float newScore = 18 / (distanceFromZero + 1) *46.00;
//    NSInteger scoreWithTime = floorf(newScore - (float)time * 0.15);
//    score = score + scoreWithTime;*/
//    
//    double distanceFromZero = sqrt(pow(ABS(varyR), 2)+pow(ABS(varyG), 2)+pow(ABS(varyB), 2));
//    if (distanceFromZero <= 5.77 && time < 33) {
//        score += 15;
//    } else if (distanceFromZero <= 11.55 && time < 66) {
//        score += 10;
//    } else {
//        score += 5;
//    }
//    
//    [gameInfoView setScore:score];
//}

- (void)addToScore {
    NSInteger add = (NSInteger)(((time)/10) + (fabs(15*log(fabs(varyH)))-56));
    NSLog(@"%ld",(long)add);
    score += add;
    
    [gameInfoView setScore:score];
}

-(void)gameUpdate:(NSTimer *)timer
{
    time--;
    if (time<=0) {
        [gameTimer invalidate];
        [self reportScore];
        [gridView highlightTile:discoloredTile];
    }
    gameInfoView.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)(time/10)];
    [gameInfoView setTime:(long)(time/10)];
    /*if (time==floorf(breakEvenTime)) {
     gameInfo.timeLabel.textColor = [UIColor redColor];
     }*/
}

- (void)resetScore {
    score = 0;
    round = 0;
    [gameInfoView setScore:score];
    [gameInfoView enableButtonBar:YES];
}

//- (void)reset {
//    time = 0;
//    //gameInfo.timeLabel.textColor = [UIColor colorWithRed:86/255.00 green:150/255.00 blue:199/255.00 alpha:1];
//    discoloredTile = (arc4random()%9)+1;
//    //gridView.discoloredTile = discoloredTile;
//    
//    /*varyR = arc4random()%20;
//    varyR = varyR-10;
//    varyG = arc4random()%20;
//    varyG = varyG-10;
//    varyB = arc4random()%20;
//    varyB = varyB-10;*/
//    
//    varyR = (arc4random()%8) + 3;
//    varyR = varyR * pow(-1, arc4random()%2);
//    varyG = (arc4random()%8) + 3;
//    varyG = varyG * pow(-1, arc4random()%2);
//    varyB = (arc4random()%8) + 3;
//    varyB = varyB * pow(-1, arc4random()%2);
//    
//    NSLog(@"Red: %ld",(long)varyR);
//    NSLog(@"Green: %ld",(long)varyG);
//    NSLog(@"Blue: %ld",(long)varyB);
//    
//    //float distanceFromZero = sqrt(pow(ABS(varyR), 2)+pow(ABS(varyG), 2)+pow(ABS(varyB), 2));
//    //float newScore = 18 / (distanceFromZero + 1) *46.00;
//    //breakEvenTime = newScore/0.15;
//    //NSLog(@"%.2f",breakEvenTime);
//    
//    const CGFloat *colors = CGColorGetComponents(selectedColor.CGColor);
//    discoloredColor = [UIColor colorWithRed:(colors[0]*255.00 + varyR)/255.00 green:(colors[1]*255.00 + varyG)/255.00 blue:(colors[2]*255.00 + varyB)/255.00 alpha:1];
//    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameUpdate:) userInfo:nil repeats:YES];
//    gridView.inGame = true;
//    [gridView updateTileSounds];
//    [gridView updateTileColorAnimated:true];
//}

// New reset method for HSB values
- (void)reset {
    [gridView setAllTilesEnabled:true];
    [gridView showAllTiles];
    [gameInfoView enableButtonBar:true];
    time = 100;
    round++;
    discoloredTile = (arc4random()%9)+1;
    
    CGFloat hue;
    CGFloat sat;
    CGFloat bri;
    CGFloat alpha;
    BOOL success = [selectedColor getHue:&hue saturation:&sat brightness:&bri alpha:&alpha];
    if (!success) {
        [self reportScore];
        [self performSegueWithIdentifier:@"gameOver" sender:nil];
    }
    
    double mult = -0.035;
    double coef = 0.020;
    switch (selectedColorName) {
        case HuesBlue:
            coef = 0.016;
            break;
        case HuesGreen:
            coef = 0.022;
            break;
        case HuesPink:
            coef = 0.020;
            break;
            
        default:
            break;
    }
    varyH = (CGFloat)((coef*pow(M_E, mult*round) + 0.005) * pow((double)(-1), (double)(arc4random()%2)));
    
    NSLog(@"%f",varyH);
    
    discoloredColor = [UIColor colorWithHue:hue+varyH saturation:sat brightness:bri alpha:alpha];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameUpdate:) userInfo:nil repeats:YES];
    gridView.inGame = true;
    [gridView updateTileSounds];
    [gridView updateTileColorAnimated:true];
}

- (void)pause {
    [gameTimer invalidate];
    [pauseView animateIntoView];
}

- (void)didExitWithButtonIndex:(PauseCoverIndex)index {
    if (index == PauseCoverIndexResume) {
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameUpdate:) userInfo:nil repeats:YES];
    } else if (index == PauseCoverIndexQuit) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)didFinishHighlightAnimation {
    /*gameActive = false;
    gameOver = true;
    double sideLength = self.view.frame.size.width*0.85;
    
    //[gridContainer updateTilesAnimated:true];
    [gridContainer sizeToWidth:sideLength atPoint:[self originPointForSize:sideLength] animated:true];*/
    if (!isNewHighScore) {
        [self performSegueWithIdentifier:@"gameOver" sender:nil];
    } else {
        [newHighAlert show];
    }
}

- (void)reportScore {
    //Create game hash
    NSString *scoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)(score+round+selectedColorName)];
    NSMutableString *hash = [scoreString MD5String].mutableCopy;
    isNewHighScore = [[ScoreModel sharedScoreModel] reportScore:score andAmount:round ofColor:selectedColorName withHash:hash];
}

- (void)alert:(UIView *)view didExitWithButtonIndex:(HuesAlertIndex)index {
    [self performSegueWithIdentifier:@"gameOver" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
