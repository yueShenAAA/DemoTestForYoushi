//
//  HttpRequest.h
//  DemoTestForYoushi
//
//  Created by l on 2018/5/29.
//  Copyright © 2018年 l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

+(instancetype)sharedInstance;
/**
 *发送get请求
 * urlstring 请求的基本的url
 *parameters 请求的参数字典
 * success 请求成功的回调
 *failure 请求失败的回调
 */
-(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)( id responseObject))success
   failure:(void (^)( NSError *error))failure;

/**
 *发送post请求
 * urlstring 请求的基本的url
 *parameters 请求的参数字典
 * success 请求成功的回调
 *failure 请求失败的回调
 */
-(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)( id responseObject))success
    failure:(void (^)( NSError *error))failure;


@end
