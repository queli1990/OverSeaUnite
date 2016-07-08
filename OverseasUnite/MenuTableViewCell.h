//
//  MenuTableViewCell.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

@interface MenuTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImageView;//图片
@property (nonatomic,strong) UIImageView *shadeImageView;//遮罩
@property (nonatomic,strong) UILabel *shadeLabel;//遮罩上的label
@property (nonatomic,strong) UILabel *chinaeseNameLabel;//中文名
@property (nonatomic,strong) UILabel *englishNameLabel;//英文名
@property (nonatomic,strong) UILabel *priceLabel;//价格
@property (nonatomic,strong) UIButton *editBtn;//编辑
@property (nonatomic,strong) UIButton *deleteBtn;//删除

@property (nonatomic,strong) MenuModel *model;

@end
