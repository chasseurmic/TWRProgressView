//
//  TWRExampleViewController.m
//  ProgressView
//
//  Created by Natalia Osiecka on 23.3.2015.
//  Copyright (c) 2015 Touchware. All rights reserved.
//

#import "TWRExampleViewController.h"
#import "TWRExampleView.h"

@interface TWRExampleViewController ()

@property (nonatomic, weak, readonly) TWRExampleView *aView;
@property (nonatomic, readonly) NSTimer *timer;
@property (nonatomic) CGFloat progress;

@end

@implementation TWRExampleViewController

#pragma mark - Memory management

- (instancetype)init {
    if (self = [super init]) {
        [self setTitle:@"Code"];
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    TWRExampleView *view = [[TWRExampleView alloc] initWithFrame:rect];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    // local for easier access
    _aView = view;
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.progress = 0.f;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_timer invalidate];
}

#pragma mark - Actions

- (void)timerAction:(NSTimer *)timer {
    [self.aView.progressView setProgress:self.progress];
    
    if (isFloatMore(self.progress, 1.f)) {
        self.progress = 0.f;
    } else {
        self.progress += 0.01;
    }
}

#pragma mark - Others

BOOL isFloatMore(CGFloat x, CGFloat y) {
    return (x > y - FLT_EPSILON);
}

@end
