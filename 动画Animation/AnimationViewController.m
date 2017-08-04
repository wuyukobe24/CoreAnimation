//
//  AnimationViewController.m
//  动画Animation
//
//  Created by WangXueqi on 17/8/2.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "AnimationViewController.h"

#define K_ScreenWidth   CGRectGetWidth([[UIScreen mainScreen] bounds])// 当前屏幕宽
#define K_ScreenHeight  CGRectGetHeight([[UIScreen mainScreen] bounds])// 当前屏幕高
@interface AnimationViewController ()
@property(nonatomic,strong)CALayer *layer;
@property(nonatomic,strong)CALayer *layer1;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UIView * upView;
@end

@implementation AnimationViewController
{    
    UIView * view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadAnimation];
    });
    
}

- (void)loadAnimation {
    
    switch ([_index intValue]) {
            
        case 0:
            [self firstAnimation];
            break;
            
        case 1:
            [self secondAnimation];
            break;
            
        case 2:
            [self thirdAnimation];
            break;
            
        case 3:
            [self fourthAnimation];
            break;
            
        case 4:
            [self fifthAnimation];
            break;
            
        case 5:
            [self sixthAnimation];
            break;
            
        case 6:
            [self seventhAnimation];
            break;
        default:
            break;
    }
    
}

- (CALayer *)layer {

    if (!_layer) {
        _layer = [CALayer layer];
        _layer.frame = CGRectMake(0, 0, 80, 80);
        _layer.position = CGPointMake(K_ScreenWidth/2, K_ScreenHeight/4);
        _layer.contents = (__bridge id _Nullable)([UIImage imageNamed: @"nev_picture.png"].CGImage);
    }
    return _layer;
}

- (CALayer *)layer1 {
    
    if (!_layer1) {
        _layer1 = [CALayer layer];
        _layer1.frame = CGRectMake(0, 0, 80, 80);
        _layer1.position = CGPointMake(K_ScreenWidth/2, K_ScreenHeight/4+100);
        _layer1.contents = (__bridge id _Nullable)([UIImage imageNamed: @"nev_audio.png"].CGImage);
    }
    return _layer1;
}

- (UIView *)backView {

    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 100, 100)];
        _backView.backgroundColor = [UIColor orangeColor];
        _backView.center = self.view.center;
    }
    return _backView;
}

- (UIView *)upView {

    if (!_upView) {
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _upView.backgroundColor = [UIColor blueColor];
        _upView.center = CGPointMake(K_ScreenWidth/2, K_ScreenHeight/4);
    }
    return _upView;
}

- (void)firstAnimation {
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.view.center;
    label.text = @"移动";
    [self.view addSubview:label];
    
    //移动
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.fromValue = @(label.center.y);
    positionAnima.byValue = @(label.center.y-50);
    positionAnima.toValue = @(label.center.y-230);
    positionAnima.timingFunction = [CAMediaTimingFunction   functionWithName:kCAMediaTimingFunctionEaseIn];
    /*单独一个动画的用法*/
    //[view.layer addAnimation:positionAnima forKey:@"AnimationMoveY"];
    
    //翻转
    CABasicAnimation *transformAnima = [CABasicAnimation    animationWithKeyPath:@"transform.rotation.y"];
    transformAnima.fromValue = @(0);
    transformAnima.toValue = @(M_PI*2);//翻转角度
    transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    /*一组动画的用法*/
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 2.0f;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.animations = @[positionAnima,transformAnima];
    
    [label.layer addAnimation:animaGroup forKey:@"Animation"];
}

- (void)secondAnimation {
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:view.center];
    [path addCurveToPoint:CGPointMake(K_ScreenWidth, K_ScreenHeight) controlPoint1:CGPointMake(K_ScreenWidth/2, K_ScreenHeight) controlPoint2:CGPointMake(K_ScreenWidth, K_ScreenHeight/2)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = 3.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)thirdAnimation {
    
    [self.view.layer addSublayer:self.layer];
    [self.view.layer addSublayer:self.layer1];
    _layer.position = CGPointMake(K_ScreenWidth/2, K_ScreenHeight/4);
    _layer1.position = CGPointMake(K_ScreenWidth/2, K_ScreenHeight/4);
    _layer.anchorPoint = CGPointMake(1, 0);
    _layer1.anchorPoint = CGPointMake(0, 0);
    
    //应用角度变换
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m43 = -1.0/500.0;
//    perspective.m11 = -1.0/50.0;
    _layer.sublayerTransform = perspective;
    _layer1.sublayerTransform = perspective;
    
    //应用摇摆动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI);//－表示旋转方向
    animation.duration = 1.0;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;//是否自动重复摇摆
    [_layer addAnimation:animation forKey:nil];
    [_layer1 addAnimation:animation forKey:nil];
}

- (void)fourthAnimation {
    
    [self.view.layer addSublayer:self.layer];
    [self.view.layer addSublayer:self.layer1];
    _layer.position = CGPointMake(K_ScreenWidth/2-100, K_ScreenHeight/4);
    _layer1.position = CGPointMake(K_ScreenWidth/2+100, K_ScreenHeight/4);
    
    //翻转
    CABasicAnimation *transformAnima = [CABasicAnimation    animationWithKeyPath:@"transform.rotation.y"];
    transformAnima.fromValue = @(0);
    transformAnima.toValue = @(M_PI*4);//翻转角度
    transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    /*一组动画的用法*/
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 2.0f;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.animations = @[transformAnima];
    [_layer addAnimation:animaGroup forKey:@"Animation"];
    [_layer1 addAnimation:animaGroup forKey:@"Animation"];
}

//混合动画
- (void)fifthAnimation {

    [self.view addSubview:self.backView];
    [self.view.layer addSublayer:self.layer];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // Animate the first half of the view rotation.
                         CGAffineTransform xform = CGAffineTransformMakeRotation(-180);
                         self.backView.transform = xform;//（－）顺时针旋转
                         // Rotate the embedded CALayer in the opposite direction.
                         CABasicAnimation * layerAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
                         layerAnimation.duration = 1.0;//完成一次时间
                         layerAnimation.repeatCount = 2;//完成次数
                         layerAnimation.beginTime = 0; //CACurrentMediaTime() + 1;
                         layerAnimation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
                         layerAnimation.timingFunction = [CAMediaTimingFunction
                                                          functionWithName:kCAMediaTimingFunctionLinear];
                         layerAnimation.fromValue = [NSNumber numberWithFloat:0.0];
                         layerAnimation.toValue = [NSNumber numberWithFloat:360.0];
                         layerAnimation.byValue = [NSNumber numberWithFloat:180.0];
                         [self.layer addAnimation:layerAnimation forKey:@"layerAnimation"];
                         
                     }
                     completion:^(BOOL finished){
                         
                         // Now do the second half of the view rotation.
                         [UIView animateWithDuration:1.0
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              CGAffineTransform  xform = CGAffineTransformMakeRotation(180);//（＋）逆时针旋转
                                              self.backView.transform = xform;
                                          }
                                          completion:^(BOOL finished){
                                              self.backView.transform = CGAffineTransformIdentity;
                                          }];
                         
                     }];
    

}

//嵌套动画
- (void)sixthAnimation {

    [self.view addSubview:self.backView];
    [self.view addSubview:self.upView];
    
    
    [UIView animateWithDuration:1.0
                          delay: 1.0//延迟
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.backView.alpha = 0.0;
                         
                         // Create a nested animation that has a different
                         // duration, timing curve, and configuration.
                         [UIView animateWithDuration:2.0
                                               delay:0.0
                                             options: UIViewAnimationOptionOverrideInheritedCurve |
                          UIViewAnimationOptionCurveLinear |
                          UIViewAnimationOptionOverrideInheritedDuration |
                          UIViewAnimationOptionRepeat |
                          UIViewAnimationOptionAutoreverse
                                          animations:^{
                                              [UIView setAnimationRepeatCount:2.5];//重复次数，不设置永久重复
                                              self.upView.alpha = 0.0;
                                          }
                                          completion:nil];
                         
                     }
                     completion:nil];

}

//视图切换的转场动画
- (void)seventhAnimation {

    [self.view addSubview:self.backView];
//    [self.view addSubview:self.upView];
    
    [UIView transitionWithView:self.view
                      duration:2.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.upView removeFromSuperview];
                        [self.view addSubview:self.backView]; }
                    completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
