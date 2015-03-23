//
//  TWRViewController.m
//  ProgressView
//
//  Created by Michelangelo Chasseur on 08/01/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRViewController.h"
#import "TWRProgressView.h"

@interface TWRViewController () {
    float _progress;
}

@property (weak, nonatomic) IBOutlet TWRProgressView *progressView;
@property (weak, nonatomic) IBOutlet TWRProgressView *progressViewSlider;
@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)increment:(id)sender;
- (IBAction)decrement:(id)sender;

@end

@implementation TWRViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self setTitle:@"Storyboard"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSlider];
    UIImage *documentImage = [UIImage imageNamed:@"document_icon"];
    [_progressView setMaskingImage:documentImage];
    [_progressViewSlider setProgress:0.5];
    
    UIImage *socialImage = [UIImage imageNamed:@"social_icon"];
    [_progressViewSlider setMaskingImage:socialImage];
    [_progressViewSlider setFrontColor:[UIColor greenColor]];
    
    // Sync initial slider and image starting progress...
    CGFloat startingProgress = 0.5f;
    [_progressViewSlider setProgress:startingProgress];
    [_slider setValue:startingProgress];
}

- (void)setupSlider {
    [_slider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    _progress = 0.5;
    [_progressView setProgress:_progress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Update Progress

- (IBAction)increment:(id)sender {
    _progress = MIN(1, _progress + 0.3);
    [_progressView setProgress:_progress animated:YES];
}

- (IBAction)decrement:(id)sender {
    _progress = MAX(0, _progress - 0.3);
    [_progressView setProgress:_progress animated:YES];
}

- (void)updateProgress:(UISlider *)sender {
    CGFloat progress = sender.value;
    progress = MIN(MAX(0, progress), 1);
    [_progressViewSlider setProgress:progress];
}
@end
