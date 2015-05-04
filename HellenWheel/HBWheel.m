//
//  HBWheel.m
//  HellenWheel
//
//  Created by bottle on 15-4-30.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import "HBWheel.h"
#import "HBWheelButton.h"
@interface HBWheel()
@property (weak, nonatomic) IBOutlet UIImageView *rotateView;
@property (nonatomic,weak) HBWheelButton *selectedBtn;
@property (nonatomic,strong) CADisplayLink *link;

- (IBAction)startChoose;

@end


@implementation HBWheel

+ (instancetype)wheel {
    HBWheel *wheel = [[[NSBundle mainBundle] loadNibNamed:@"HBWheel" owner:nil options:nil] lastObject];
    return wheel;
}

- (void)awakeFromNib {
    CGFloat btnW = 68;
    CGFloat btnH = 143;
//    CGFloat btnX = (self.frame.size.width - btnW)*0.5;
//    CGFloat btnY = 10;
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *bigImageSelect = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    for (int i=0; i<12; i++) {
        HBWheelButton *btn = [HBWheelButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.frame.size.width *0.5, self.frame.size.height * 0.5);
        CGFloat angle = i * 30;
        btn.layer.transform = CATransform3DMakeRotation(angle / 180 * M_PI, 0, 0, 1);
        //设置按钮上的图片
        CGFloat smallW = bigImage.size.width /12 * [UIScreen mainScreen].scale;
        CGFloat smallH = bigImage.size.height * [UIScreen mainScreen].scale;
        CGRect smallRect = CGRectMake(i * smallW, 0, smallW, smallH);
        CGImageRef smallImg =  CGImageCreateWithImageInRect(bigImage.CGImage, smallRect);
        CGImageRef smallimgSelected = CGImageCreateWithImageInRect(bigImageSelect.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallImg] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithCGImage:smallimgSelected] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        [self.rotateView addSubview:btn];
    }
}

- (void)btnClicked:(HBWheelButton*)btn {
    //NSLog(@"%d",btn.tag);
    self.selectedBtn.selected  = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

- (void)startRotate {
    if (self.link) {
        return;
    }
    //1秒钟刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

- (void)stopRotate {
    [self.link invalidate];
    self.link = nil;
}

- (void)rotate {
    self.rotateView.transform = CGAffineTransformRotate(self.rotateView.transform,1 * M_PI_4 / 180);
}

- (IBAction)startChoose {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim.toValue = @(2 * M_PI * 3);
    anim.duration = 1.5;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [self.rotateView.layer addAnimation:anim forKey:nil];
    self.userInteractionEnabled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.userInteractionEnabled = YES;
}
@end
