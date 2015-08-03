//
//  GameViewController.m
//  Hues
//
//  Created by Drew Dunne on 7/22/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "GameViewController.h"
#import "NSString+MD5.h"

#define GameInfoViewHeight 112.0
#define IS_WIDESCREEN ((double)[[UIScreen mainScreen] bounds].size.height >= (double)568)

void GVControlSoundManagerAudioServicesSystemSoundCompletionProc (SystemSoundID soundID, void *clientData) {
    AudioServicesDisposeSystemSoundID(soundID);
}

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    selectedColor = [UIColor getRandomHue];
    
    
    gameInfoView = [[GameInfoView alloc] initWithFrame:CGRectMake(0, /*0-GameInfoViewHeight-1*/0, self.view.frame.size.width, GameInfoViewHeight)];
    [gameInfoView.pause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
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
    
    pauseView = [[PauseAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    pauseView.delegate = self;
    [self.view addSubview:pauseView];
    
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

- (void)addToScore {
    /*float distanceFromZero = sqrt(pow(ABS(varyR), 2)+pow(ABS(varyG), 2)+pow(ABS(varyB), 2));
    float newScore = 18 / (distanceFromZero + 1) *46.00;
    NSInteger scoreWithTime = floorf(newScore - (float)time * 0.15);
    score = score + scoreWithTime;*/
    
    double distanceFromZero = sqrt(pow(ABS(varyR), 2)+pow(ABS(varyG), 2)+pow(ABS(varyB), 2));
    if (distanceFromZero <= 5.77 && time < 33) {
        score += 15;
    } else if (distanceFromZero <= 11.55 && time < 66) {
        score += 10;
    } else {
        score += 5;
    }
    
    [gameInfoView setScore:score];
}

-(void)gameUpdate:(NSTimer *)timer
{
    time++;
    if (time==100) {
        [gameTimer invalidate];
        [self reportScore];
        [gridView highlightTile:discoloredTile];
    }
    gameInfoView.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)(10.00-time/10)];
    [gameInfoView setTime:(long)(10.00-time/10)];
    /*if (time==floorf(breakEvenTime)) {
     gameInfo.timeLabel.textColor = [UIColor redColor];
     }*/
}

- (void)resetScore {
    score = 0;
    [gameInfoView setScore:score];
}

- (void)reset {
    time = 0;
    //gameInfo.timeLabel.textColor = [UIColor colorWithRed:86/255.00 green:150/255.00 blue:199/255.00 alpha:1];
    discoloredTile = (arc4random()%9)+1;
    //gridView.discoloredTile = discoloredTile;
    
    varyR = arc4random()%20;
    varyR = varyR-10;
    varyG = arc4random()%20;
    varyG = varyG-10;
    varyB = arc4random()%20;
    varyB = varyB-10;
    
    //float distanceFromZero = sqrt(pow(ABS(varyR), 2)+pow(ABS(varyG), 2)+pow(ABS(varyB), 2));
    //float newScore = 18 / (distanceFromZero + 1) *46.00;
    //breakEvenTime = newScore/0.15;
    //NSLog(@"%.2f",breakEvenTime);
    
    const CGFloat *colors = CGColorGetComponents(selectedColor.CGColor);
    discoloredColor = [UIColor colorWithRed:(colors[0]*255.00 + varyR)/255.00 green:(colors[1]*255.00 + varyG)/255.00 blue:(colors[2]*255.00 + varyB)/255.00 alpha:1];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameUpdate:) userInfo:nil repeats:YES];
    gridView.inGame = true;
    [gridView updateTileSounds];
    [gridView updateTileColorAnimated:true];
}

- (void)pause {
    [gameTimer invalidate];
    [pauseView animateIntoView];
}

- (void)didExitWithButtonIndex:(PauseAlertViewIndex)index {
    if (index == PauseAlertViewIndexResume) {
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameUpdate:) userInfo:nil repeats:YES];
    } else if (index == PauseAlertViewIndexQuit) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)didFinishHighlightAnimation {
    /*gameActive = false;
    gameOver = true;
    double sideLength = self.view.frame.size.width*0.85;
    
    //[gridContainer updateTilesAnimated:true];
    [gridContainer sizeToWidth:sideLength atPoint:[self originPointForSize:sideLength] animated:true];*/
    [self performSegueWithIdentifier:@"gameOver" sender:nil];
}

- (void)reportScore {
    //Create game hash
    NSString *scoreString = [NSString stringWithFormat:@"F3A7%ld1G9E",(long)score];
    NSMutableString *hash = [scoreString MD5String].mutableCopy;
    BOOL isNewHighScore = [[ScoreModel sharedScoreModel] reportScore:score withHash:hash];
    if (isNewHighScore) {
        
    }
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
