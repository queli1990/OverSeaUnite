//
//  ShopManagerCell.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ShopManagerCell.h"

@implementation ShopManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundShadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
        _backgroundShadeView.backgroundColor = [UIColor whiteColor];
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        grayView.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
        [_backgroundShadeView addSubview:grayView];
        
        self.deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
        _deviceLabel.textColor = [UIColor blackColor];
        _deviceLabel.font = [UIFont systemFontOfSize:18.0];
        _deviceLabel.textAlignment = NSTextAlignmentLeft;
        [self.backgroundShadeView addSubview:_deviceLabel];
        
        self.shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(_deviceLabel.frame.origin.x, CGRectGetMaxY(_deviceLabel.frame)+5, 20, 20)];
        _shopLabel.textAlignment = NSTextAlignmentLeft;
        _shopLabel.textColor = [UIColor redColor];
        _shopLabel.font = [UIFont systemFontOfSize:16.0];
        [self.backgroundShadeView addSubview:_shopLabel];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_deviceLabel.frame.origin.x, CGRectGetMaxY(_shopLabel.frame)+5, ScreenWidth-5-30-20-10, 40)];
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.font = [UIFont systemFontOfSize:12.0];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [self.backgroundShadeView addSubview:_addressLabel];
        
        _managerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _managerBtn.frame = CGRectMake(ScreenWidth-80-5-30, 0, 80, 40);
        _managerBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_managerBtn setTitle:@"菜单管理" forState:UIControlStateNormal];
        [_managerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self.backgroundShadeView addSubview:_managerBtn];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119, ScreenWidth, 1)];
        _lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineView];
        
        [self.contentView addSubview:self.backgroundShadeView];
    }
    return self;
}

- (void) setPlaceDic:(NSDictionary *)placeDic{
    _shopLabel.text = [NSString stringWithFormat:@"%@",placeDic[@"cname"]];
    UIFont *font1 = [UIFont fontWithName:@"Arial" size:16];
    _deviceLabel.font = font1;
    CGSize shopLabelSize = [_shopLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font1,NSFontAttributeName, nil]];
    _shopLabel.frame = CGRectMake(_deviceLabel.frame.origin.x, CGRectGetMaxY(_deviceLabel.frame)+5, shopLabelSize.width+20, 20);
    
    _addressLabel.text = placeDic[@"address"];
}


- (void) setModel:(ShopManagerModel *)model{
    
    _deviceLabel.text = [NSString stringWithFormat:@"设备编号：%@",model.code];
    UIFont *font = [UIFont fontWithName:@"Arial" size:18];
    _deviceLabel.font = font;
    
    CGSize labelSize = [_deviceLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    if (labelSize.width > ScreenWidth-80-5-30-20-10) {
        _deviceLabel.frame = CGRectMake(15, 20, ScreenWidth-80-5-30-20-10, 20);
    }else{
        _deviceLabel.frame = CGRectMake(15, 20, labelSize.width, 20);
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
