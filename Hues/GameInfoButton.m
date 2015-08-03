//
//  GameInfoButton.m
//  Hues
//
//  Created by Drew Dunne on 7/25/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "GameInfoButton.h"

@implementation GameInfoButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [UIView beginAnimations:@"scale_tile" context:NULL];
    [UIView setAnimationDuration: 0.1];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    [UIView commitAnimations];
}

@end
