//
//  TWRProgressView.m
//  ProgressView
//
//  Created by Michelangelo Chasseur on 08/01/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//
#define HORIZONTAL_START_POINT  CGPointMake(1, 0.5)
#define HORIZONTAL_END_POINT    CGPointMake(0, 0.5)
#define VERTICAL_START_POINT    CGPointMake(0.5, 0)
#define VERTICAL_END_POINT      CGPointMake(0.5, 1)

#import "TWRProgressView.h"

@implementation TWRProgressView

+ (instancetype)progressViewWithFrame:(CGRect)frame andMaskingImage:(UIImage *)maskingImage {
    return [[self alloc] initWithFrame:frame andMaskingImage:maskingImage];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andMaskingImage:(UIImage *)maskingImage {
    self = [self initWithFrame:frame];
    if (self) {
        [self setMaskingImage:maskingImage];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _animationTime = 0.5;
    [self setProgress:0.0f];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setColors:@[[UIColor grayColor], [UIColor redColor]]];
}

#pragma mark - Layer

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)maskView:(UIView *)viewToBeMasked {
    // Won't work with jpg
    UIImage* imageWithAlphaChannel = _maskingImage; //[UIImage imageNamed:@"document_icon"];
    CGImageRef cgImageWithAlpha = [imageWithAlphaChannel CGImage];
    CALayer* maskingLayer = [CALayer layer];
    maskingLayer.contents = (__bridge id)cgImageWithAlpha;
    
    //Assume viewToBeMasked is the view, who's layer needs to be masked
    CALayer* layerToBeMasked = viewToBeMasked.layer;
    layerToBeMasked.mask = maskingLayer;
    maskingLayer.frame = layerToBeMasked.bounds;
    //Alternativly use: viewToBeMasked.layer.mask = maskingLayer;
}

#pragma mark - Properties settings

- (void)setMaskingImage:(UIImage *)maskingImage {
    _maskingImage = maskingImage;
    [self maskView:self];
}

- (void)setColors:(NSArray *)colors
{
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    
    self.gradientLayer.colors = cgColors;
}

- (NSArray *)colors
{
    NSMutableArray *uiColors = [NSMutableArray arrayWithCapacity:self.gradientLayer.colors.count];
    for (id color in self.gradientLayer.colors)
    {
        [uiColors addObject:[UIColor colorWithCGColor:(CGColorRef)color]];
    }
    
    return uiColors;
}

- (void)setBackColor:(UIColor *)backColor {
    NSMutableArray *currentColors = [self colors].mutableCopy;
    if (currentColors.count > 0) {
        [currentColors replaceObjectAtIndex:0 withObject:backColor];
        [self setColors:currentColors];
    }
    [self setNeedsDisplay];
}

- (void)setFrontColor:(UIColor *)frontColor {
    NSMutableArray *currentColors = [self colors].mutableCopy;
    if (currentColors.count > 0) {
        [currentColors replaceObjectAtIndex:1 withObject:frontColor];
        [self setColors:currentColors];
    }
    [self setNeedsDisplay];
}

- (void)setHorizontal:(BOOL)horizontal
{
    self.gradientLayer.startPoint = horizontal ? HORIZONTAL_START_POINT : VERTICAL_START_POINT;
    self.gradientLayer.endPoint   = horizontal ? HORIZONTAL_END_POINT : VERTICAL_END_POINT;
}

- (BOOL)isHorizontal
{
    return (CGPointEqualToPoint(self.gradientLayer.startPoint, HORIZONTAL_START_POINT)) && (CGPointEqualToPoint(self.gradientLayer.endPoint, HORIZONTAL_END_POINT));
}

- (void)setAnimationTime:(CGFloat)time {
    _animationTime = time;
}

#pragma mark - Progress

- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    CGFloat normalizedProgress = 1 - MIN(MAX(progress, 0.f), 1.f);
    NSArray* newLocations = @[@(normalizedProgress), @(normalizedProgress)];
    
    if (animated) {
        NSTimeInterval duration = _animationTime;
        [UIView animateWithDuration:duration animations:^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = duration;
            animation.delegate = self;
            animation.fromValue = self.gradientLayer.locations;
            animation.toValue = newLocations;
            [self.gradientLayer addAnimation:animation forKey:@"animateLocations"];
        }];
    } else {
        [self.gradientLayer setNeedsDisplay];
    }
    
    self.gradientLayer.locations = newLocations;
    _progress = normalizedProgress;
}

@end

