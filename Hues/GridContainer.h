//
//  GridContainer.h
//  Hues
//
//  Created by Drew Dunne on 7/6/15.
//  Copyright (c) 2015 Drew Dunne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hues.h"
#import "TileButton.h"

typedef enum : NSUInteger {
    Center,
    TopLeft,
    TopRight,
    BottomLeft,
    BottomRight,
} HuesShrinkPoint;

@protocol GridContainerViewDelegate <NSObject>
- (UIImage *)imageForTileWithTag:(NSInteger)tag;
- (UIColor *)colorForTileWithTag:(NSInteger)tag;
@optional
- (void)gridContainerTileWasPressed:(NSInteger)tile;
@optional
- (void)didFinishGameOverAnimation;
@end

@interface GridContainer : UIView {
    UIImageView *responseImageView;
}

@property (nonatomic, strong) UIImageView *responseImageView;
@property (nonatomic) NSInteger tilesPerRow;
@property (nonatomic) BOOL tilesAreEnabled;
@property (nonatomic, strong) UIColor *tileColor;
@property (nonatomic) NSInteger discoloredTile;

@property (weak) id <GridContainerViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andTilesPerRow:(NSInteger)tiles;

- (void)updateTilesAnimated:(BOOL)animated;

- (void)sizeToWidth:(double)width atPoint:(CGPoint)point animated:(BOOL)animated;

- (void)showResponse:(BOOL)correct onTile:(NSInteger)tile;

- (void)highlightCorrectTile;

@end

