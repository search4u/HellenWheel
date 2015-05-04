//
//  HBWheelButton.m
//  HellenWheel
//
//  Created by bottle on 15-4-30.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import "HBWheelButton.h"

@implementation HBWheelButton

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
