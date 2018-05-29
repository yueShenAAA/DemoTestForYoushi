//
//  HomePageCell.m
//  DemoTestForYoushi
//
//  Created by l on 2018/5/29.
//  Copyright © 2018年 l. All rights reserved.
//

#import "HomePageCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface HomePageCell()
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIButton *btn_A;
@property (nonatomic,strong) UIButton *btn_B;
@property (nonatomic,strong) UILabel *detailLab;
@end

@implementation HomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _headImageView = [UIImageView new];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(self.headImageView.mas_width).multipliedBy(0.5);
    }];
    
    _btn_A  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_A setTitle:@"A" forState:UIControlStateNormal];
    [_btn_A setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn_A.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn_A.tag = 1;
    _btn_A.backgroundColor = [UIColor blueColor];
    [_btn_A addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btn_A];
    [_btn_A mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView);
        make.height.mas_equalTo(@44);
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(([UIScreen mainScreen].bounds.size.width - 30)/2);
    }];
    
    
    
    
    _btn_B  = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_B.tag = 2;
    _btn_B.backgroundColor = [UIColor blueColor];
    [_btn_B setTitle:@"B" forState:UIControlStateNormal];
    [_btn_B setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn_B.titleLabel.font = [UIFont systemFontOfSize:16];
    [_btn_B addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btn_B];
    
    [_btn_B mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headImageView);
        make.height.mas_equalTo(@44);
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(([UIScreen mainScreen].bounds.size.width - 30)/2);
    }];
    
    _detailLab = [UILabel new];
    _detailLab.font = [UIFont systemFontOfSize:13];
    _detailLab.numberOfLines = 0;
    [self.contentView addSubview:self.detailLab];
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headImageView);
        make.top.equalTo(self.btn_A.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
}

- (void)btnClick:(UIButton *)sender{
    
    if (self.block) {
        self.block(sender.tag);
    }
    
}

- (void)setModel:(HomePageModel *)model{
    if (model) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
        self.detailLab.text = model.text;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
