//
//  HomePageViewController.m
//  DemoTestForYoushi
//
//  Created by l on 2018/5/29.
//  Copyright © 2018年 l. All rights reserved.
//

#import "HomePageViewController.h"
#import "Masonry.h"
#import "HttpRequest.h"
#import "HomePageCell.h"
#import "HomePageModel.h"
#import "MJExtension.h"
#import "A_ViewController.h"
#import "B_ViewController.h"

#define HomeURL @"/mockapi/data"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
static NSString *const identifier = @"HomePageCell";

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.myTableView];
    [self getDatas];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)getDatas{
    __weak typeof(self) weakSelf = self;
    
    [[HttpRequest sharedInstance] GET:HomeURL parameters:nil success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            weakSelf.dataArray = [[HomePageModel class] mj_objectArrayWithKeyValuesArray:responseObject];
            if (weakSelf.dataArray.count>0) {
                [weakSelf.myTableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[HomePageCell class] forCellReuseIdentifier:identifier];
    }
    return _myTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 330;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomePageModel *model = self.dataArray[indexPath.section];
    cell.model = model;
    cell.block = ^(NSInteger btnTag) {
        if (btnTag == 1) {
            //A
            [self.navigationController pushViewController:[A_ViewController new] animated:YES];
        }else{
            //B
            [self.navigationController pushViewController:[B_ViewController new] animated:YES];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot = [UIView new];
    foot.backgroundColor = [UIColor lightGrayColor];
    return foot;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
