//
//  TileButton.m
//  Hues
//
//  Created by Drew Dunne on 7/20/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "TileButton.h"

@implementation TileButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [UIView beginAnimations:@"scale_tile" context:NULL];
    [UIView setAnimationDuration: 0.2];
    if (highlighted) {
       self.transform = CGAffineTransformMakeScale(0.93,0.93);
    } else {
        self.transform = CGAffineTransformMakeScale(1.0,1.0);
    }
    [UIView commitAnimations];
}


@end
