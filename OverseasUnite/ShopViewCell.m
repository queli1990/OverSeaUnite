//
//  ShopViewCell.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/6.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ShopViewCell.h"

@implementation ShopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.picImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (60-40*0.5)/2, 48*0.5, 40*0.5)];//cell高40，上下间距5
        [self.contentView addSubview:self.picImgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_picImgView.frame)+10, 10, 180, 40)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 59, ScreenWidth, 1)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void) setModel:(ShopViewModel *)model{
    _model = model;
    _picImgView.image = [UIImage imageNamed:model.picImgViewStr];
    _titleLabel.text = model.titleLabelStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
