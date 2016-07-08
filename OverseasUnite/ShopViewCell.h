//
//  ShopViewCell.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/6.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopViewModel.h"

@interface ShopViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImgView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) ShopViewModel *model;

@end
