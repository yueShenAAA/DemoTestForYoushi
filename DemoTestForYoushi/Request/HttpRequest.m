//
//  HttpRequest.m
//  DemoTestForYoushi
//
//  Created by l on 2018/5/29.
//  Copyright © 2018年 l. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "HUDTool.h"

#define BaseURL @"http://static.youshikoudai.com"
@implementation HttpRequest

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static HttpRequest *httpRequest = nil;
    dispatch_once(&onceToken, ^{
        httpRequest = [[HttpRequest alloc]init];
    });
    return httpRequest;
}

-(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)( id responseObject))success
    failure:(void (^)( NSError *error))failure{
    [HUDTool showLoading:nil];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BaseURL]];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    session.requestSerializer.timeoutInterval = 15;
    NSMutableDictionary *params = [parameters mj_keyValues];
    
    [session POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [HUDTool hideAllHUDsInView:nil];
        
        if ([responseObject isKindOfClass:[NSNull class]]) {
            [HUDTool showError:@"服务器异常" toView:nil];
        }else{
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HUDTool hideAllHUDsInView:nil];
        NSLog(@"%@",error);
        if (failure) {
            failure(error);
        }
        [HUDTool showError:[self errorWithString:error] toView:nil];
    }];
}


-(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)( id responseObject))success
   failure:(void (^)( NSError *error))failure{
    
    [HUDTool showLoading:nil];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BaseURL]];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    session.requestSerializer.timeoutInterval = 15;
    NSMutableDictionary *params = [parameters mj_keyValues];
    
    [session GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HUDTool hideAllHUDsInView:nil];
        
        if ([responseObject isKindOfClass:[NSNull class]]) {
            [HUDTool showError:@"服务器异常" toView:nil];
        }else{
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [HUDTool hideAllHUDsInView:nil];
        NSLog(@"%@",error);
        if (failure) {
            failure(error);
        }
        [HUDTool showError:[self errorWithString:error] toView:nil];
    }];
}

- (NSString *)errorWithString:(NSError *)error{
    //如果请求超时的话
    if (error.code == -1001) {
        return @"网速不给力哦!";
    }
    //如果断网的话
    if (error.code == -1009) {
        return @"木有联网哦!";
    }
    //如果服务器挂了的话
    if (error.code == -1004) {
        return @"服务器异常";
    }
    return @"尝试刷新一下哦";
}


@end
