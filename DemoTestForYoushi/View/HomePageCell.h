//
//  HomePageCell.h
//  DemoTestForYoushi
//
//  Created by l on 2018/5/29.
//  Copyright © 2018年 l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
typedef void (^btnClickBlock)(NSInteger btnTag);

@interface HomePageCell : UITableViewCell
@property (nonatomic,copy)btnClickBlock block;
@property (nonatomic,strong)HomePageModel *model;
@end
