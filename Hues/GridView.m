//
//  GridView.m
//  Hues
//
//  Created by Drew Dunne on 7/21/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import "GridView.h"

@implementation GridView

@synthesize tilesPerRow, responseImageView;

- (id)init {
    self = [super init];
    if (self) {
        self.tilesPerRow = 3;
        self.clipsToBounds = false;
        self.inGame = false;
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
        self.clipsToBounds = false;
        self.inGame = false;
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
        self.clipsToBounds = false;
        self.inGame = false;
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
                if ([self.delegate respondsToSelector:@selector(imageForTileWithTag:)]) {
                    UIImage *tileImage = [self.delegate imageForTileWithTag:i+1];
                    if (tileImage) {
                        [tileButton setImage:tileImage forState:UIControlStateNormal];
                    }
                }
                UIColor *delegateTileColor = [self.delegate colorForTileWithTag:i+1];
                if (delegateTileColor) {
                    tileButton.backgroundColor = delegateTileColor;
                }
            } else {
                tileButton.backgroundColor = [UIColor huesBlue];
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

- (void)tilePressed:(UIButton *)tile {
    if ([self.delegate respondsToSelector:@selector(gridContainerTileWasPressed:)]) {
        [self.delegate gridContainerTileWasPressed:tile.tag];
    }
}

- (void)updateTileColor {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            TileButton *tileButton = (TileButton *)[self viewWithTag:i+1];
            if (self.delegate) {
                UIColor *delegateTileColor = [self.delegate colorForTileWithTag:i+1];
                if (delegateTileColor) {
                    tileButton.backgroundColor = delegateTileColor;
                }
            } else {
                tileButton.backgroundColor = [UIColor huesBlue];
            }
            i++;
        }
    }
}

- (void)updateTileColorAnimated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:@"updateTiles" context:nil];
        [UIView setAnimationDuration:0.4];
        [self updateTileColor];
        [UIView commitAnimations];
    } else {
        [self updateTileColor];
    }
}

- (void)updateTileImages {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            TileButton *tileButton = (TileButton *)[self viewWithTag:i+1];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(imageForTileWithTag:)]) {
                    UIImage *tileImage = [self.delegate imageForTileWithTag:i+1];
                    if (tileImage) {
                        [tileButton setImage:tileImage forState:UIControlStateNormal];
                    }
                }
            }
            i++;
        }
    }
}

- (void)updateTileImagesAnimated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:@"updateTiles" context:nil];
        [UIView setAnimationDuration:0.5];
        [self updateTileImages];
        [UIView commitAnimations];
    } else {
        [self updateTileImages];
    }
}

- (void)updateTileFrames {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            TileButton *tileButton = (TileButton *)[self viewWithTag:i+1];
            tileButton.frame = [self getTileFrameWithColumn:column row:row];
            i++;
        }
        
    }
}

- (void)sizeToWidth:(double)width atPoint:(CGPoint)point animated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:@"updateTiles" context:nil];
        [UIView setAnimationDuration:0.5];
        self.frame = CGRectMake(point.x, point.y, width, width);
        [self updateTileFrames];
        [UIView commitAnimations];
    } else {
        self.frame = CGRectMake(point.x, point.y, width, width);
        [self updateTileFrames];
    }
    
}

- (void)setAllTilesEnabled:(BOOL)enabled {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            TileButton *tileButton = (TileButton *)[self viewWithTag:i+1];
            tileButton.enabled = enabled;
            i++;
        }
    }
}

- (void)setTilesEnabledWithArray:(NSArray *)enabledTiles {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            TileButton *tileButton = (TileButton *)[self viewWithTag:i+1];
            if ([enabledTiles containsObject:[NSNumber numberWithInteger:i+1]]) {
                tileButton.enabled = true;
            } else {
                tileButton.enabled = false;
            }
            i++;
        }
    }
}

- (void)setButtonSoundWithPath:(NSString *)pathForSound forControlEvents:(UIControlEvents)events {
    NSInteger i = 0;
    for (NSInteger row = 0; row < self.tilesPerRow; row++) {
        for (NSInteger column = 0; column < self.tilesPerRow; column++) {
            TileButton *tileButton = (TileButton *)[self viewWithTag:i+1];
            [tileButton removeSoundsForControlEvents:events];
            [tileButton addSoundWithContentsOfFile:pathForSound forControlEvents:events];
            i++;
        }
    }
    
    //[[TileButton appearance] addSoundWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"touch" ofType:@"wav"] forControlEvents:UIControlEventTouchDown];
}

- (void)updateTileSounds {
    if ([self.delegate respondsToSelector:@selector(soundForTileWithTag:)]) {
        NSInteger i = 0;
        for (NSInteger row = 0; row < self.tilesPerRow; row++) {
            for (NSInteger column = 0; column < self.tilesPerRow; column++) {
                TileButton *tileButton = (TileButton *)[self viewWithTag:i+1];
                [tileButton removeSoundsForControlEvents:UIControlEventTouchDown];
                NSString *soundPath = [self.delegate soundForTileWithTag:i+1];
                if (soundPath) {
                    [tileButton addSoundWithContentsOfFile:soundPath forControlEvents:UIControlEventTouchDown];
                }
                
                i++;
            }
        }
    }
}

- (void)showResponse:(BOOL)correct onTile:(NSInteger)tile {
    TileButton *tappedTile = (TileButton *)[self viewWithTag:tile];
    [responseImageView setFrame:CGRectMake(tappedTile.frame.origin.x, tappedTile.frame.origin.y, tappedTile.frame.size.width, tappedTile.frame.size.height)];
    [self bringSubviewToFront:responseImageView];
    if (correct) {
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

- (void)highlightTile:(NSInteger)tile {
    [self setAllTilesEnabled:false];
    [UIView beginAnimations:@"highlight" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(unhighlightTiles)];
    [UIView setAnimationDuration:1.2];
    for (int i = 1; i < 10; i++) {
        if (i != tile) {
            TileButton *tile = (TileButton *)[self viewWithTag:i];
            tile.alpha = 0.5;
        }
    }
    [UIView commitAnimations];
}

- (void)unhighlightTiles {
    [UIView beginAnimations:@"unhighlight" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didEndHighlightAnimation)];
    [UIView setAnimationDuration:1.2];
    for (int i = 1; i < 10; i++) {
        TileButton *tile = (TileButton *)[self viewWithTag:i];
        tile.alpha = 1.0;
    }
    [UIView commitAnimations];
    //[self enableAllTiles:false];  // Reload previous enabling here
}

- (void)didEndHighlightAnimation {
    if ([self.delegate respondsToSelector:@selector(didFinishHighlightAnimation)]) {
        [self.delegate didFinishHighlightAnimation];
    }
}

@end
