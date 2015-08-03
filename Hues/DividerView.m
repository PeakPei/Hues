//
//  DividerView.m
//  Hues
//
//  Created by Drew Dunne on 7/24/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "DividerView.h"

@implementation DividerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    }
    return self;
}

@end
