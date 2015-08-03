//
//  GameOverViewController.h
//  Hues
//
//  Created by Drew Dunne on 7/24/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hues.h"
#import "TileButton.h"
#import "DividerView.h"
#import "NavView.h"
#import "UIControl+SoundForControlEvents.h"

@interface GameOverViewController : UIViewController {
    UILabel *scoreLabel;
    UILabel *highScoreLabel;
    
    UIButton *quitButton;
    
    TileButton *restartButton;
    TileButton *storeButton;
}

@end
