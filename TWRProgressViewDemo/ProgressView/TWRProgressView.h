//
//  TWRProgressView.h
//  ProgressView
//
//  Created by Michelangelo Chasseur on 08/01/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TWRProgressView : UIView {
    CGFloat _progress;
    CGFloat _animationTime;
}

/**
 * Gradient layer applied to view.
 */
@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

/**
 * An Array of UIColors for the gradient.
 */
@property (nonatomic) NSArray *colors UI_APPEARANCE_SELECTOR;

/**
 * Color of 'empty' part of the progress.
 */
@property (nonatomic) UIColor *backColor UI_APPEARANCE_SELECTOR;

/**
 * Color of 'filled' part of the progress.
 */
@property (nonatomic) UIColor *frontColor UI_APPEARANCE_SELECTOR;

/**
 * Specifies that the gradient should be drawn horizontally.
 */
@property (nonatomic) BOOL horizontal;

/**
 * The mask image, where progress is applied.
 */
@property (nonatomic) UIImage *maskingImage UI_APPEARANCE_SELECTOR;

/**
 * Percentage of which the view is filled from the bottom (0%) to top (100%).
 */
@property (nonatomic) CGFloat progress;

+ (instancetype)progressViewWithFrame:(CGRect)frame andMaskingImage:(UIImage *)maskingImage;
- (instancetype)initWithFrame:(CGRect)frame andMaskingImage:(UIImage *)maskingImage;

- (void)setAnimationTime:(CGFloat)time;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
