//
//  HomePageModel.h
//  DemoTestForYoushi
//
//  Created by l on 2018/5/29.
//  Copyright © 2018年 l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject
/*
 "image": "http://static.youshikoudai.com/mockapi/0074c8b4-f2ff-4b9f-9a2a-9c1fe97b3226.jpg",
 "text": "本次课程开始时间为：3月18日"
 
 */

@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *text;

@end
