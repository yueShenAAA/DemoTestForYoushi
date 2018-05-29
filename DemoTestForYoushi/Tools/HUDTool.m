//
//  HUDTool.m
//  baseProject
//
//  Created by Davis on 16/11/11.
//  Copyright © 2016年 Davis. All rights reserved.
//
//    设置背景黑色方法
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
//    hud.label.textColor = [UIColor whiteColor];
//    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];

#import "HUDTool.h"

@implementation HUDTool
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
//    [hud hideAnimated:YES afterDelay:0.7];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUDTool hideAllHUDsInView:view];
    });
    
    
}

- (void)startAnimation:(UIView *)img {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue =  @(M_PI * 2.0);
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [img.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示信息

+ (void)showLoading:(UIView *)view {
    [self showLoading:nil toView:view];
}

+ (void)showLoading:(NSString *)text toView:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    if (text.length == 0) {
//        text = @"Loading";
        text = @"请稍后...";
    }
    // 快速显示一个提示信息
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the label text.
    hud.label.text = text;
    hud.userInteractionEnabled = NO;
//    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];//[UIColor colorWithRed:0.41f green:0.46f blue:0.50f alpha:0.600f];
    // 背景蒙版
//    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showMessage:(NSString *)message {
    [self showMessage:message toView:nil];
}
#pragma mark 显示一些信息
+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (message.length == 0) return;
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    hud.userInteractionEnabled = NO;
    // 设置hub颜色
//    hud.bezelView.color = [UIColor colorWithRed:0.41f green:0.46f blue:0.50f alpha:0.600f];
    hud.bezelView.layer.cornerRadius = 5.f;
//    hud.cornerRadius = 5.0f;
    // 设置边框颜色
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.3秒之后再消失
//    [hud hideAnimated:YES afterDelay:1.3f];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUDTool hideAllHUDsInView:view];
    });
}

+ (void)showMessage:(NSString *)message detailMessage:(NSString*)detailMessage toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.detailsLabel.text = detailMessage;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
//    [hud hideAnimated:YES afterDelay:1.f];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUDTool hideAllHUDsInView:view];
    });
}

+ (void)hideAllHUDsInView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES];
//    [hud hideAnimated:YES];
//    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
