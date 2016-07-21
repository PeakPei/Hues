//
//  PowerupDescView.m
//  Hues
//
//  Created by Drew Dunne on 4/27/16.
//  Copyright © 2016 Drew Dunne. All rights reserved.
//

#import "PowerupDescView.h"

@implementation PowerupDescView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width/3)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    // Needs to scale to view width
    // Border
    
    // Image is about 1/3
    powerupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(27, 9, (self.frame.size.width - 54)/3, (self.frame.size.width - 54)/3)];
    [powerupImageView setImage:[UIImage imageNamed:@"skip.png"]];
    [self addSubview:powerupImageView];
    
    // Label and Desc are about 2/3
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 54)/3 + 54, 9, 2*(self.frame.size.width - 108)/3, 36)];
    titleLabel.text = @"Skip";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    titleLabel.textColor = [UIColor darkHuesBlueText];
//    titleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:titleLabel];
    
    descLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 54)/3 + 45, 45, 2*(self.frame.size.width - 81)/3, self.frame.size.height - 45)];
    descLabel.text = @"Allows one to skip a set of tiles and move on. No points are awarded.";
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    descLabel.textColor = [UIColor darkGrayColor];
    descLabel.numberOfLines = 0;
//    descLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:descLabel];
}

- (void)setDescription:(NSString *)desc {
    descLabel.text = desc;
}

- (void)setPowerupTitle:(NSString *)title {
    titleLabel.text = title;
}

- (void)setPowerupImage:(UIImage *)image {
    [powerupImageView setImage:image];
}

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
