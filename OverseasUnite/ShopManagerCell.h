//
//  ShopManagerCell.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopManagerModel.h"
#import "UIButton+WithDic.h"

@interface ShopManagerCell : UITableViewCell

@property (nonatomic,strong) UILabel *deviceLabel;
@property (nonatomic,strong) UILabel *shopLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIButton *managerBtn;

@property (nonatomic,strong) UIView *backgroundShadeView;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) NSDictionary *placeDic;
@property (nonatomic,strong) ShopManagerModel *model;

@end
