//
//  PhotoManagerTableViewCell.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoManagerModel.h"

@interface PhotoManagerTableViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *bottomImageView;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UILabel *titleLabel;


@property (nonatomic,strong) PhotoManagerModel *model;

@end
