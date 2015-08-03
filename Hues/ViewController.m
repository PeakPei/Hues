//
//  ViewController.m
//  Hues
//
//  Created by Drew Dunne on 7/6/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "ViewController.h"

#define GameInfoViewHeight 76.0
#define IS_WIDESCREEN ((double)[[UIScreen mainScreen] bounds].size.height >= (double)568)

static NSString *leaderboardID = @"threebythree.hues";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Create the Title Label
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width, 61)];
    titleLabel.text = @"Hues";
    titleLabel.textColor = [UIColor colorWithRed:86/255.00 green:150/255.00 blue:199/255.00 alpha:1];
    titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:60];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0f;
    [self.view addSubview:titleLabel];
    
    //Create the Subtitle Label
    subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y+titleLabel.frame.size.height+8, self.view.frame.size.width, 22)];
    subtitleLabel.text = @"test your eyesight";
    subtitleLabel.textColor = [UIColor colorWithRed:86/255.00 green:150/255.00 blue:199/255.00 alpha:1];
    subtitleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:20];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.alpha = 1.0f;
    [self.view addSubview:subtitleLabel];
    
    double sideLength = self.view.frame.size.width*0.85;
    double yPos = (self.view.frame.size.height - subtitleLabel.frame.size.height - subtitleLabel.frame.origin.y - sideLength)/2 + subtitleLabel.frame.size.height + subtitleLabel.frame.origin.y;
    gridContainer = [[GridContainer alloc] initWithFrame:CGRectMake((self.view.frame.size.width-sideLength)/2, yPos, sideLength, sideLength) andTilesPerRow:3];
    gridContainer.delegate = self;
    [self.view addSubview:gridContainer];
    gridContainer.tilesAreEnabled = true;
    [gridContainer updateTilesAnimated:false];
    
    gameInfo = [[GameInfoView alloc] initWithFrame:CGRectMake(0, 0-GameInfoViewHeight-1, self.view.frame.size.width, GameInfoViewHeight)];
    [self.view addSubview:gameInfo];
    
    gameActive = false;
    gameOver = false;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.gameCenterEnabled) {
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        
        localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
            if (viewController != nil) {
                [self presentViewController:viewController animated:YES completion:nil];
            } else {
                if ([GKLocalPlayer localPlayer].authenticated) {
                    appDelegate.gameCenterEnabled = YES;
                    
                    /*// Get the default leaderboard identifier.
                     [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                     
                     if (error != nil) {
                     NSLog(@"%@", [error localizedDescription]);
                     }
                     else{
                     //_leaderboardIdentifier = leaderboardIdentifier;
                     }
                     }];*/
                } else {
                    appDelegate.gameCenterEnabled = NO;
                }
            }
        };
    }
}

- (CGPoint)originPointForSize:(double)size {
    double yPos = (self.view.frame.size.height - subtitleLabel.frame.size.height - subtitleLabel.frame.origin.y - size)/2 + subtitleLabel.frame.size.height + subtitleLabel.frame.origin.y;
    return CGPointMake((self.view.frame.size.width-size)/2, yPos);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageForTileWithTag:(NSInteger)tag {
    if (gameActive) {
        return nil;
    }
    if (gameOver) {
        if (tag == 4) {
            return [UIImage imageNamed:@"restart.png"];
        }
        if (tag == 5) {
            return [UIImage imageNamed:@"leaderboard.png"];
        }
        if (tag == 6) {
            return [UIImage imageNamed:@"quitToHome.png"];
        } else {
            return nil;
        }
    }
    if (tag == 4) {
        return [UIImage imageNamed:@"startGame.png"];
    }
    if (tag == 5) {
        return [UIImage imageNamed:@"leaderboard.png"];
    }
    if (tag == 6) {
        return [UIImage imageNamed:@"howtoplay.png"];
    }
    return nil;
}

- (UIColor *)colorForTileWithTag:(NSInteger)tag {
    if (gameActive) {
        if (tag == discoloredTile) {
            return discoloredColor;
        }
        return selectedColor;
    }
    if (gameOver) {
        return selectedColor;
    }
    if (tag%3 == 0) {
        return [UIColor huesPink];
    }
    if ((tag+1)%3 == 0) {
        return [UIColor huesGreen];
    }
    return [UIColor huesBlue];
}

- (void)gridContainerTileWasPressed:(NSInteger)tile {
    NSLog(@"Tile %ld was pressed",(long)tile);
    if (gameActive) {
        [gridContainer showResponse:(tile == discoloredTile) onTile:tile];
        [gameTimer invalidate];
        if (tile == discoloredTile) {
            [self addToScore];
            [self reset];
        } else {
            [self reportScore];
            [gridContainer highlightCorrectTile];
        }
    } else if (gameOver) {
        switch (tile) {
            case 4:
                [self showGameTitle:false animated:true];
                [self newGame];
                break;
            case 5:
                [self showLeaderboardAndAchievements:true];
                break;
            case 6:
                [self showGameInfo:false animated:true];
                [self showGameTitle:true animated:true];
                gameOver = false;
                gameActive = false;
                [gridContainer updateTilesAnimated:true];
                break;
                
            default:
                break;
        }
    } else {
        switch (tile) {
            case 4:
                [self showGameTitle:false animated:true];
                [self newGame];
                break;
            case 5:
                [self showLeaderboardAndAchievements:true];
                break;
            case 6:
                NSLog(@"Show How to Play");
                [self performSegueWithIdentifier:@"showHowTo" sender:nil];
                break;
                
                
            default:
                break;
        }
    }
}

- (void)newGame {
    NSLog(@"Starting Game...");
    double sideLength = self.view.frame.size.width;
    [gridContainer sizeToWidth:sideLength atPoint:[self originPointForSize:sideLength] animated:true];
    gameActive = true;
    gameOver = false;
    selectedColor = [UIColor getRandomHue];
    [self showGameInfo:true animated:true];
    [self resetScore];
    [self reset];
    
}

- (void)addToScore {
    float distanceFromZero = sqrt(pow(ABS(varyR), 2)+pow(ABS(varyG), 2)+pow(ABS(varyB), 2));
    float newScore = 18 / (distanceFromZero + 1) *46.00;
    NSInteger scoreWithTime = floorf(newScore - (float)time * 0.15);
    score = score + scoreWithTime;
    [gameInfo setScore:score];
}

-(void)gameUpdate:(NSTimer *)timer
{
    time++;
    if (time==600) {
        [gameTimer invalidate];
        [gridContainer highlightCorrectTile];
    }
    gameInfo.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)(60.00-time/10)];
    [gameInfo setTime:(long)(60.00-time/10)];
    /*if (time==floorf(breakEvenTime)) {
        gameInfo.timeLabel.textColor = [UIColor redColor];
    }*/
}

- (void)resetScore {
    score = 0;
    [gameInfo setScore:score];
}

- (void)reset {
    time = 0;
    //gameInfo.timeLabel.textColor = [UIColor colorWithRed:86/255.00 green:150/255.00 blue:199/255.00 alpha:1];
    discoloredTile = (arc4random()%9)+1;
    gridContainer.discoloredTile = discoloredTile;
    
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
    [gridContainer updateTilesAnimated:true];
}

- (void)didFinishGameOverAnimation {
    gameActive = false;
    gameOver = true;
    double sideLength = self.view.frame.size.width*0.85;
    
    //[gridContainer updateTilesAnimated:true];
    [gridContainer sizeToWidth:sideLength atPoint:[self originPointForSize:sideLength] animated:true];
}

- (void)reportScore {
    GKScore *gkScore = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardID];
    gkScore.value = score;
    
    [GKScore reportScores:@[gkScore] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (void)showGameTitle:(BOOL)shouldShow animated:(BOOL)animated {
    if (shouldShow) {
        if (animated) {
            [UIView beginAnimations:@"show label new game" context:nil];
            [UIView setAnimationDuration:0.6];
            titleLabel.alpha = 1.0;
            subtitleLabel.alpha = 1.0;
            [UIView commitAnimations];
        } else {
            titleLabel.alpha = 1.0;
            subtitleLabel.alpha = 1.0;
        }
    } else {
        if (animated) {
            [UIView beginAnimations:@"hide label new game" context:nil];
            [UIView setAnimationDuration:0.6];
            titleLabel.alpha = 0.0;
            subtitleLabel.alpha = 0.0;
            [UIView commitAnimations];
        } else {
            titleLabel.alpha = 0.0;
            subtitleLabel.alpha = 0.0;
        }
    }
}

- (void)showGameInfo:(BOOL)shouldShow animated:(BOOL)animated {
    if (shouldShow) {
        if (animated) {
            [UIView beginAnimations:@"show gird and label new game" context:nil];
            [UIView setAnimationDuration:0.6];
            gameInfo.frame = CGRectMake(0, 0, self.view.frame.size.width, GameInfoViewHeight);
            [UIView commitAnimations];
        } else {
            gameInfo.frame = CGRectMake(0, 0, self.view.frame.size.width, GameInfoViewHeight);
        }
    } else {
        if (animated) {
            [UIView beginAnimations:@"hide grid and label new game" context:nil];
            [UIView setAnimationDuration:0.6];
            gameInfo.frame = CGRectMake(0, 0-GameInfoViewHeight-1, self.view.frame.size.width, GameInfoViewHeight);
            [UIView commitAnimations];
        } else {
            gameInfo.frame = CGRectMake(0, 0-GameInfoViewHeight-1, self.view.frame.size.width, GameInfoViewHeight);
        }
    }
}



- (void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard {
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = leaderboardID;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    NSLog(@"Did finish showing leaderboard");
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
