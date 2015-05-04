//
//  ViewController.m
//  HellenWheel
//
//  Created by bottle on 15-4-30.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import "ViewController.h"
#import "HBWheel.h"
@interface ViewController ()
- (IBAction)start;
- (IBAction)end;

@property (nonatomic,weak) HBWheel *wheel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HBWheel *wheel = [HBWheel wheel];
    wheel.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    [self.view addSubview:wheel];
    self.wheel = wheel;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (IBAction)start {
    [self.wheel startRotate];
}

- (IBAction)end {
    [self.wheel stopRotate];
}
@end
