//
//  FoodMapCell.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodMapModel.h"


@interface FoodMapCell : UITableViewCell

@property (nonatomic,strong) FoodMapModel *model;
@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@property (nonatomic,strong) UIButton *updataFoodBtn;
@property (nonatomic,strong) UIButton *shopEditBtn;

@end
