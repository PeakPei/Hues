//
//  HuesButton.h
//  Hues
//
//  Created by Drew Dunne on 8/3/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "defines.h"
#import "UIColor+Hues.h"
#import "UIControl+SoundForControlEvents.h"

@interface HuesButton : UIButton
//Sets a thicker outline
@property (strong, nonatomic) UIColor *defaultColor;

//For the lazy...
+ (HuesButton *)buttonWithColor:(UIColor *)color;

- (id)initWithColor:(UIColor *)color;
@end
