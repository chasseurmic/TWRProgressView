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

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

// An Array of UIColors for the gradient
@property (nonatomic, readwrite) NSArray *colors;

// Specifies that the gradient should be drawn horizontally
@property (nonatomic, getter = isHorizontal) BOOL horizontal;

@property (strong, nonatomic) UIImage *maskingImage;

+ (instancetype)progressViewWithFrame:(CGRect)frame andMaskingImage:(UIImage *)maskingImage;
- (instancetype)initWithFrame:(CGRect)frame andMaskingImage:(UIImage *)maskingImage;

- (void)setAnimationTime:(CGFloat)time;
- (void)setProgress:(CGFloat)progress;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

- (void)setBackColor:(UIColor *)backColor;
- (void)setFrontColor:(UIColor *)frontColor;

@end
