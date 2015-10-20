//
//  ViewController.m
//  CustomActivityIndicatorsUsingAReplicatorLayer
//
//  Created by 李松玉 on 15/10/19.
//  Copyright © 2015年 李松玉. All rights reserved.
//

#import "ViewController.h"

// Default values
#define kDefaultNumberOfSpinnerMarkers 12
#define kDefaultSpread 35.0
#define kDefaultColor ([UIColor whiteColor])
#define kDefaultThickness 8.0
#define kDefaultLength 25.0
#define kDefaultSpeed 1.0

// HUD defaults
#define kDefaultHUDSide 160.0
#define kDefaultHUDColor ([UIColor colorWithWhite:0.0 alpha:0.5])

#define kMarkerAnimationKey @"MarkerAnimationKey"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CALayer * marker = [CALayer layer];
    [marker setBounds:CGRectMake(0, 0, kDefaultThickness, kDefaultLength)];
    [marker setCornerRadius:kDefaultThickness * 0.5];
    [marker setBackgroundColor:[kDefaultColor CGColor]];
    [marker setPosition:CGPointMake(kDefaultHUDSide * 0.5, kDefaultHUDSide * 0.5 + kDefaultSpread)];
    
    CAReplicatorLayer * spinnerReplicator = [CAReplicatorLayer layer];
    [spinnerReplicator setBounds:CGRectMake(0, 0, kDefaultHUDSide, kDefaultHUDSide)];
    [spinnerReplicator setCornerRadius:10.0];
    [spinnerReplicator setBackgroundColor:[kDefaultHUDColor CGColor]];
    [spinnerReplicator setPosition:CGPointMake(CGRectGetMidX(self.view.frame),
                                               CGRectGetMidY(self.view.frame))];
    
    CGFloat angle = (2.0 * M_PI) / (kDefaultNumberOfSpinnerMarkers);
    CATransform3D instanceRotation = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
    [spinnerReplicator setInstanceCount:kDefaultNumberOfSpinnerMarkers];
    [spinnerReplicator setInstanceTransform:instanceRotation];

    [spinnerReplicator addSublayer:marker];
    [self.view.layer addSublayer:spinnerReplicator];
    
    [marker setOpacity:0.0];
    CABasicAnimation * fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [fade setFromValue:[NSNumber numberWithFloat:1.0]];
    [fade setToValue:[NSNumber numberWithFloat:0.0]];
    [fade setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [fade setRepeatCount:HUGE_VALF];
    [fade setDuration:kDefaultSpeed];
    CGFloat markerAnimationDuration = kDefaultSpeed / kDefaultNumberOfSpinnerMarkers;
    [spinnerReplicator setInstanceDelay:markerAnimationDuration];
    [marker addAnimation:fade forKey:kMarkerAnimationKey];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
