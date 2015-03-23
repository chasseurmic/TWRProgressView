//
//  TWRExampleView.m
//  ProgressView
//
//  Created by Natalia Osiecka on 23.3.2015.
//  Copyright (c) 2015 Touchware. All rights reserved.
//

#import "TWRExampleView.h"

@implementation TWRExampleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _progressView = [[TWRProgressView alloc] initWithFrame:frame andMaskingImage:[UIImage imageNamed:@"social_icon"]];
        [_progressView setBackColor:[UIColor greenColor]];
        [_progressView setFrontColor:[UIColor blueColor]];
        [_progressView setProgress:0.f];
        [self addSubview:_progressView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    CGSize progressViewSize = CGSizeMake(100.f, 100.f);
    [self.progressView setFrame:CGRectIntegral(CGRectMake(CGRectGetMidX(frame) - progressViewSize.width / 2,
                                                          CGRectGetMidY(frame) - progressViewSize.height / 2,
                                                          progressViewSize.width,
                                                          progressViewSize.height))];
}

@end
