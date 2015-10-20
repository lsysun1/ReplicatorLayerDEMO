//
//  ViewController.m
//  CALayer Animation - Replicator Animation
//
//  Created by 李松玉 on 15/10/19.
//  Copyright © 2015年 李松玉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *replicatorAnimationView;

@property (strong, nonatomic) IBOutlet UIView *activityIndicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    [self firstReplicatorAnimation];
    [self activityIndicatorAnimation];
    
    
}



- (void)firstReplicatorAnimation
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(self.replicatorAnimationView.frame.origin.x,
                                        self.replicatorAnimationView.frame.origin.y,
                                        self.replicatorAnimationView.frame.size.width,
                                        self.replicatorAnimationView.frame.size.height);
    
    replicatorLayer.anchorPoint = CGPointMake(0, 0);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);
    replicatorLayer.instanceDelay = 0.3;
    replicatorLayer.masksToBounds = true;
    
    [self.replicatorAnimationView.layer addSublayer:replicatorLayer];
    
    
    CALayer *rectangle = [CALayer layer];
    rectangle.bounds = CGRectMake(0, 0, 30, 110);
    rectangle.anchorPoint = CGPointMake(0, 0);
    rectangle.position = CGPointMake(self.replicatorAnimationView.frame.origin.x + 10,
                                     self.replicatorAnimationView.frame.origin.y + 110);
    rectangle.cornerRadius = 2;
    rectangle.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:rectangle];
    
    CABasicAnimation *moveRectangle = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveRectangle.fromValue = [NSNumber numberWithFloat:self.replicatorAnimationView.frame.origin.y + 110];
    moveRectangle.toValue = [NSNumber numberWithFloat:self.replicatorAnimationView.frame.origin.y + 110 - 50];
    moveRectangle.duration = 0.7;
    
    //这个属性为Bool类型，设置为true时，开启自动反向执行动画，比如示例中的白色长方形的移动动画为向上移动50个像素，
    //如果autoreverses设置为false，那么动画结束后，会根据重复次数，白色长方形重新回到初始位置，继续向上移动
    //如果autoreverses设置为true，则当动画结束后，白色长方形会继续向下移动至初始位置，然后再开始第二次的向上移动动画。
    moveRectangle.autoreverses = true;
    moveRectangle.repeatCount = HUGE;
    [rectangle addAnimation:moveRectangle forKey:nil];
    
    
}




- (void)activityIndicatorAnimation
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    replicatorLayer.bounds = CGRectMake(0,
                                        0,
                                        self.activityIndicatorView.frame.size.width,
                                        self.activityIndicatorView.frame.size.height);
    
    replicatorLayer.position = CGPointMake(self.activityIndicatorView.frame.size.width/2,
                                           self.activityIndicatorView.frame.size.height/2);

    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    CGFloat angle = 2 * M_PI / 15;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replicatorLayer.instanceCount = 15;
    replicatorLayer.instanceDelay = 1.0/15.0;
    [self.activityIndicatorView.layer addSublayer:replicatorLayer];
    
    
    
    CALayer *circle = [CALayer layer];
    circle.bounds = CGRectMake(0, 0, 15, 15);
    circle.position = CGPointMake(self.activityIndicatorView.frame.size.width/2,
                                  self.activityIndicatorView.frame.size.height/2 -55);
    circle.cornerRadius = 7.5;
    circle.backgroundColor = [UIColor whiteColor].CGColor;
    circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    [replicatorLayer addSublayer:circle];
    
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSNumber numberWithFloat:1.0];
    scale.toValue = [NSNumber numberWithFloat:0.1];
    scale.duration = 1;
    scale.repeatCount = HUGE;
    [circle addAnimation:scale forKey:nil];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
