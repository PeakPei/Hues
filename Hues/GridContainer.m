//
//  GridContainer.m
//  Hues
//
//  Created by Drew Dunne on 7/6/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "GridContainer.h"

@implementation GridContainer

@synthesize tilesAreEnabled,tilesPerRow,tileColor, responseImageView;

- (id)init {
    self = [super init];
    if (self) {
        self.tilesPerRow = 3;
        self.tilesAreEnabled = false;
        self.tileColor = [UIColor huesBlue];
        self.clipsToBounds = false;
        self.responseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self addSubview:responseImageView];
        [self createTiles];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tilesPerRow = 3;
        self.tilesAreEnabled = false;
        self.tileColor = [UIColor huesBlue];
        self.clipsToBounds = false;
        self.responseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self addSubview:responseImageView];
        [self createTiles];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTilesPerRow:(NSInteger)tiles {
    self = [super initWithFrame:frame];
    if (self) {
        self.tilesPerRow = tiles;
        self.tilesAreEnabled = false;
        self.tileColor = [UIColor huesBlue];
        self.clipsToBounds = false;
        self.responseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self addSubview:responseImageView];
        [self createTiles];
    }
    return self;
}

- (void)createTiles {
    //Create the tile grid
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            //UIButton *tileButton = [UIButton buttonWithType:UIButtonTypeCustom];
            TileButton *tileButton = [TileButton buttonWithType:UIButtonTypeCustom];
            tileButton.adjustsImageWhenHighlighted = false;
            tileButton.frame = [self getTileFrameWithColumn:column row:row];
            
            tileButton.tag = i+1;
            
            if (self.delegate) {
                UIImage *tileImage = [self.delegate imageForTileWithTag:i+1];
                if (tileImage) {
                    [tileButton setImage:tileImage forState:UIControlStateNormal];
                }
                UIColor *delegateTileColor = [self.delegate colorForTileWithTag:i+1];
                if (delegateTileColor) {
                    tileButton.backgroundColor = delegateTileColor;
                }
            } else {
                tileButton.backgroundColor = self.tileColor;
            }
            
            [tileButton addTarget:self action:@selector(tilePressed:) forControlEvents:UIControlEventTouchUpInside];
            tileButton.enabled = false;
            tileButton.opaque = true;
            
            tileButton.layer.borderWidth = 0;
            tileButton.layer.cornerRadius = 5.0;
            [self addSubview:tileButton];
            i++;
        }
        
    }
    
}

- (CGRect)getTileFrameWithColumn:(NSInteger)column row:(NSInteger)row {
    double width = self.frame.size.width;
    NSInteger spacing = width/60;
    double tileWidth = (width-(self.tilesPerRow+1)*spacing)/self.tilesPerRow;
    return CGRectMake(tileWidth*column + spacing*(column+1), tileWidth*row + spacing*(row+1), tileWidth, tileWidth);
}

- (void)updateTiles {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            UIButton *tileButton = (UIButton *)[self viewWithTag:i+1];
            
            tileButton.frame = [self getTileFrameWithColumn:column row:row];
            
            if (self.delegate) {
                UIImage *tileImage = [self.delegate imageForTileWithTag:i+1];
                [tileButton setImage:tileImage forState:UIControlStateNormal];
                UIColor *delegateTileColor = [self.delegate colorForTileWithTag:i+1];
                if (delegateTileColor) {
                    tileButton.backgroundColor = delegateTileColor;
                }
            } else {
                tileButton.backgroundColor = self.tileColor;
            }
            
            tileButton.enabled = self.tilesAreEnabled;
            i++;
        }
        
    }
}

- (void)updateTilesAnimated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:@"updateTiles" context:nil];
        [UIView setAnimationDuration:0.5];
        NSLog(@"Updating");
        [self updateTiles];
        [UIView commitAnimations];
    } else {
        [self updateTiles];
    }
}

- (void)sizeToWidth:(double)width atPoint:(CGPoint)point animated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:@"updateTiles" context:nil];
        [UIView setAnimationDuration:0.5];
        self.frame = CGRectMake(point.x, point.y, width, width);
        [self updateTiles];
        [UIView commitAnimations];
    } else {
        self.frame = CGRectMake(point.x, point.y, width, width);
        [self updateTiles];
    }
    
}

- (void)tilePressed:(UIButton *)tile {
    if ([self.delegate respondsToSelector:@selector(gridContainerTileWasPressed:)]) {
        [self.delegate gridContainerTileWasPressed:tile.tag];
    }
}

- (void)showResponse:(BOOL)correct onTile:(NSInteger)tile {
    UIButton *tappedTile = (UIButton *)[self viewWithTag:tile];
    [responseImageView setFrame:CGRectMake(tappedTile.frame.origin.x, tappedTile.frame.origin.y, tappedTile.frame.size.width, tappedTile.frame.size.height)];
    [self bringSubviewToFront:responseImageView];
    if (correct && tile == self.discoloredTile) {
        [responseImageView setImage:[UIImage imageNamed:@"correct.png"]];
    } else {
        [responseImageView setImage:[UIImage imageNamed:@"incorrect.png"]];
    }
    responseImageView.alpha = 0.0;
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.5];
    responseImageView.alpha = 1.0;
    [UIView commitAnimations];
    [UIView beginAnimations:@"fade out" context:nil];
    [UIView setAnimationDuration:1.0];
    responseImageView.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)enableTiles:(BOOL)enabled {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            UIButton *tileButton = (UIButton *)[self viewWithTag:i+1];
            tileButton.enabled = enabled;
            i++;
        }
    }
}

- (void)highlightCorrectTile {
    [self enableTiles:false];
    [UIView beginAnimations:@"highlight" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(unhighlightCorrectTile)];
    [UIView setAnimationDuration:1.2];
    for (int i = 1; i < 10; i++) {
        if (i != self.discoloredTile) {
            UIButton *tile = (UIButton *)[self viewWithTag:i];
            tile.alpha = 0.5;
        }
    }
    [UIView commitAnimations];
}

- (void)unhighlightCorrectTile {
    [UIView beginAnimations:@"unhighlight" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didEndGameOverAnimation)];
    [UIView setAnimationDuration:1.2];
    for (int i = 1; i < 10; i++) {
        if (i != self.discoloredTile) {
            UIButton *tile = (UIButton *)[self viewWithTag:i];
            tile.alpha = 1.0;
        }
    }
    [UIView commitAnimations];
    [self enableTiles:false];
}

- (void)didEndGameOverAnimation {
    if ([self.delegate respondsToSelector:@selector(didFinishGameOverAnimation)]) {
        [self.delegate didFinishGameOverAnimation];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
