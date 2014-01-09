TWRProgressView
=================

## TWRProgressView

A custom view component that lets the user easily present a progress view masked with an image containing an alpha channel (i.e. PNGs). The view's progress can be animated; foreground and background colors can be customized as well as the duration of the animation.

## Usage

Usage is easy.

Add the dependency to your `Podfile`:

```ruby
platform :ios
pod 'TWRProgressView'
...
```

Run `pod install` to install the dependencies.

Next, import the header file wherever you want to use the picker:

```objc
#import "TWRProgressView.h"
```

The progress view can be set up either via Interface Builder (XIB and Storyboards) by just setting TWRProgressView as the class of any UIView...

```objc
@property (weak, nonatomic) IBOutlet TWRProgressView *progressView;
...
UIImage *someImage = [UIImage imageNamed:@"image.png"];
[_progressView setMaskingImage:someImage];
```

 ...or programmatically with a pretty sweet one-liner:

```objc
CGRect progressViewRect = CGRectMake(0, 0, 100, 100);
UIImage *someImage = [UIImage imageNamed:@"image.png"];
TWRProgressView *progressView = [TWRProgressView progressViewWithFrame:progressViewRect
                                                       andMaskingImage:someImage];
[self.view addSubview:progressView];
```

TWRProgressView exposes the following methods that let the user customize color, progress and animation timing:
```objc
- (void)setProgress:(CGFloat)progress;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

- (void)setBackColor:(UIColor *)backColor;
- (void)setFrontColor:(UIColor *)frontColor;

- (void)setAnimationTime:(CGFloat)time;
```
## Demo

Take a look at this video:
[![TWRProgressView Demo](http://cocoahunter-blog.s3.amazonaws.com/TWRProgressView/TWRProgressView_Screenshot.png)](http://cocoahunter-blog.s3.amazonaws.com/TWRProgressView/TWRProgressView.mp4)

## Requirements

`TWRProgressView` requires iOS 6.x or greater.


## License

Usage is provided under the [MIT License](http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.