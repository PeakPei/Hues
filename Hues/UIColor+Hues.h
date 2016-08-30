//
//  UIColor+Hues.h
//  Hues
//
//  Created by Drew Dunne on 6/5/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HuesBlue,
    HuesGreen,
    HuesPink,
} HuesColor;

@interface UIColor (Hues)

//Colors specific to Hues
+ (UIColor *)huesBlue;
+ (UIColor *)huesGreen;
+ (UIColor *)huesPink;
+ (UIColor *)huesPurple;
+ (UIColor *)darkHuesBlueText;

//Select a random color of the colors above
+ (UIColor *)getRandomHue;

+ (UIColor *)lighterColorForColor:(UIColor *)c;
+ (UIColor *)darkerColorForColor:(UIColor *)c;

- (HuesColor)getHuesColor;

@end
