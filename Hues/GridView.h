//
//  GridView.h
//  Hues
//
//  Created by Drew Dunne on 7/21/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileButton.h"
#import "UIColor+Hues.h"
#import "UIControl+SoundForControlEvents.h"

@protocol GridViewDelegate <NSObject>
- (UIColor *)colorForTileWithTag:(NSInteger)tag;
@optional
- (UIImage *)imageForTileWithTag:(NSInteger)tag;
@optional
- (NSString *)soundForTileWithTag:(NSInteger)tag;
@optional
- (void)gridContainerTileWasPressed:(NSInteger)tile;
@optional
- (void)didFinishHighlightAnimation;
@end

@interface GridView : UIView {
    UIImageView *responseImageView;
}

@property (nonatomic, strong) UIImageView *responseImageView;
@property (nonatomic) NSInteger tilesPerRow;

@property (nonatomic) BOOL inGame;

@property (weak) id <GridViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andTilesPerRow:(NSInteger)tiles;

//Updating Grid
- (void)updateTileSounds;
- (void)updateTileColorAnimated:(BOOL)animated;
- (void)updateTileImagesAnimated:(BOOL)animated;
- (void)sizeToWidth:(double)width atPoint:(CGPoint)point animated:(BOOL)animated;

- (void)showResponse:(BOOL)correct onTile:(NSInteger)tile;

- (void)highlightTile:(NSInteger)tile;

- (void)setAllTilesEnabled:(BOOL)enabled;
- (void)setTilesEnabledWithArray:(NSArray *)enabledTiles;
- (void)setSmallerGridContainingTiles:(NSArray *)enabledTiles;
- (void)showAllTiles;

@end
