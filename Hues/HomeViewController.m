//
//  HomeViewController.m
//  Hues
//
//  Created by Drew Dunne on 7/21/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width, 61)];
    titleLabel.text = @"Hues";
    titleLabel.textColor = [UIColor colorWithRed:86/255.00 green:150/255.00 blue:199/255.00 alpha:1];
    titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:60];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0f;
    [self.view addSubview:titleLabel];
    
    //Create the Subtitle Label
    subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y+titleLabel.frame.size.height+8, self.view.frame.size.width, 22)];
    subtitleLabel.text = @"touch the square";
    subtitleLabel.textColor = [UIColor colorWithRed:86/255.00 green:150/255.00 blue:199/255.00 alpha:1];
    subtitleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:20];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.alpha = 1.0f;
    [self.view addSubview:subtitleLabel];
    
    double sideLength = self.view.frame.size.width*0.85;
    double yPos = (self.view.frame.size.height - subtitleLabel.frame.size.height - subtitleLabel.frame.origin.y - sideLength)/2 + subtitleLabel.frame.size.height + subtitleLabel.frame.origin.y;
    gridView = [[GridView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-sideLength)/2, yPos, sideLength, sideLength) andTilesPerRow:3];
    gridView.delegate = self;
    [gridView updateTileImagesAnimated:false];
    [gridView updateTileColorAnimated:false];
    [gridView updateTileSounds];
    [gridView setTilesEnabledWithArray:@[[NSNumber numberWithInteger:4], [NSNumber numberWithInteger:5], [NSNumber numberWithInteger:6]]];
    [self.view addSubview:gridView];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.gameCenterEnabled) {
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        
        localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
            if (viewController != nil) {
                [self presentViewController:viewController animated:YES completion:nil];
            } else {
                if ([GKLocalPlayer localPlayer].authenticated) {
                    appDelegate.gameCenterEnabled = YES;
                } else {
                    appDelegate.gameCenterEnabled = NO;
                }
            }
        };
    }
}

- (UIImage *)imageForTileWithTag:(NSInteger)tag {
    if (tag == 4) {
        return [UIImage imageNamed:@"startGame.png"];
    }
    if (tag == 5) {
        return [UIImage imageNamed:@"scores.png"];
    }
    if (tag == 6) {
        return [UIImage imageNamed:@"powerups_2.png"];
    }
    return nil;
}

- (NSString *)soundForTileWithTag:(NSInteger)tag {
    return [[NSBundle mainBundle] pathForResource:@"touch" ofType:@"wav"];
}

- (UIColor *)colorForTileWithTag:(NSInteger)tag {
    if (tag%3 == 0) {
        return [UIColor huesPink];
    }
    if ((tag+1)%3 == 0) {
        return [UIColor huesGreen];
    }
    return [UIColor huesBlue];
}

- (void)gridContainerTileWasPressed:(NSInteger)tile {
    switch (tile) {
        case 4:
            //Fade out
            [self performSegueWithIdentifier:@"playGame" sender:nil];
            break;
        case 5:
            //Fade out
            //Leaderboard/Achievements View load
            [self performSegueWithIdentifier:@"scores_view" sender:nil];
            break;
        case 6:
            //Fade Out
            [self performSegueWithIdentifier:@"powerups_from_home" sender:nil];
            break;
            
            
        default:
            break;
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    NSLog(@"Did finish showing leaderboard");
    [self dismissViewControllerAnimated:true completion:nil];
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
