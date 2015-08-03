//
//  UIColor+Hues.m
//  Hues
//
//  Created by Drew Dunne on 6/5/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "UIColor+Hues.h"

@implementation UIColor (Hues)

+ (UIColor *)huesBlue {
    //
    return [UIColor colorWithRed:0.337 green:0.588 blue:0.78 alpha:1];
}

+ (UIColor *)huesGreen {
    // 57E6AC
    return [UIColor colorWithRed:0.341 green:0.902 blue:0.675 alpha:1];
}

+ (UIColor *)huesPink {
    // E08DAC
    return [UIColor colorWithRed:0.878 green:0.553 blue:0.675 alpha:1];
}

+ (UIColor *)huesPurple {
    return [UIColor colorWithRed:0.478 green:0.435 blue:0.847 alpha:1];
}

+ (UIColor *)darkHuesBlueText {
    return [UIColor colorWithRed:0.55 green:0.55 blue:0.65 alpha:1];
}

+ (UIColor *)getRandomHue {
    NSArray *colorHues = @[[UIColor huesBlue],[UIColor huesGreen],[UIColor huesPink]];
    NSUInteger random = arc4random() % [colorHues count];
    return [colorHues objectAtIndex:random];
}

+ (UIColor *)lighterColorForColor:(UIColor *)c {
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

+ (UIColor *)darkerColorForColor:(UIColor *)c {
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

@end
