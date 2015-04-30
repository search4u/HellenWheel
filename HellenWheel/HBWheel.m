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
    UIImage *bigImageSelect = [UIImage imageNamed:@"LuckyAnimalPressed"];
    for (int i=0; i<12; i++) {
        HBWheelButton *btn = [HBWheelButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.frame.size.width *0.5, self.frame.size.height * 0.5);
        CGFloat angle = i * 30;
        btn.layer.transform = CATransform3DMakeRotation(angle / 180 * M_PI, 0, 0, 1);
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        //设置按钮上的图片
        CGRect smallRect = CGRectMake(i * 40, 0, 40, 47);
        CGImageRef smallImg =  CGImageCreateWithImageInRect(bigImage.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallImg] forState:UIControlStateNormal];
        [self.rotateView addSubview:btn];
    }
    
}

- (void)btnClicked:(HBWheelButton*)btn {
    //NSLog(@"%d",btn.tag);
    self.selectedBtn.selected  = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}
@end
