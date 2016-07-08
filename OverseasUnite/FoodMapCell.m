//
//  FoodMapCell.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "FoodMapCell.h"

@implementation FoodMapCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        grayView.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
        [self.contentView addSubview:grayView];
        
        self.shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(grayView.frame)+5, ScreenWidth-30, 30)];
        _shopNameLabel.font = [UIFont systemFontOfSize:16.0];
        _shopNameLabel.textColor = [UIColor redColor];
        _shopNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_shopNameLabel];
        
        UILabel *addressTextLabel = [[UILabel alloc] init];
        addressTextLabel.text = @"地址：";
        addressTextLabel.font = [UIFont systemFontOfSize:14.0];
        
        CGSize lableSize = [addressTextLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:addressTextLabel.font,NSFontAttributeName, nil]];
        addressTextLabel.frame = CGRectMake(15, CGRectGetMaxY(_shopNameLabel.frame)+5, lableSize.width, 40);
        
        addressTextLabel.textAlignment = NSTextAlignmentLeft;
        addressTextLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:addressTextLabel];
        
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addressTextLabel.frame)+5, CGRectGetMaxY(_shopNameLabel.frame)+5, ScreenWidth-50-addressTextLabel.frame.size.width, 40)];
        _addressLabel.numberOfLines = 0;
        _addressLabel.font = [UIFont systemFontOfSize:14.0];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_addressLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_addressLabel.frame)+4, ScreenWidth, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:lineView];
        
        
        self.updataFoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _updataFoodBtn.frame = CGRectMake(ScreenWidth-60-15, CGRectGetMaxY(_addressLabel.frame)+5, 60, 30);
        [_updataFoodBtn setTitle:@"上传菜品" forState:UIControlStateNormal];
        _updataFoodBtn.titleLabel.textColor = [UIColor grayColor];
        _updataFoodBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_updataFoodBtn];
    }
    
    return self;
}

- (void) setModel:(FoodMapModel *)model{
    _model = model;
    _shopNameLabel.text = [NSString stringWithFormat:@"店铺：%@",model.name];
    _addressLabel.text = [NSString stringWithFormat:@"地址：%@",model.address];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
