//
//  MenuTableViewCell.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat with = 80*4/3;
        CGFloat heigth = 80;
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, with, heigth)];
        _picImageView.clipsToBounds = YES;
        _picImageView.layer.cornerRadius = 6;
        
        self.shadeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _picImageView.frame.size.height-20, _picImageView.frame.size.width, 20)];
        _shadeImageView.backgroundColor = [UIColor grayColor];
        [_picImageView addSubview:_shadeImageView];
        [self.contentView addSubview:_picImageView];
        
        _shadeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _shadeImageView.frame.size.width, _shadeImageView.frame.size.height)];
        _shadeLabel.textColor = [UIColor whiteColor];
        _shadeLabel.font = [UIFont systemFontOfSize:14.0];
        [_shadeImageView addSubview:_shadeLabel];
        _shadeImageView.hidden = YES;
        
        
        CGFloat magin = 30;
        
        _chinaeseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_picImageView.frame)+20, _picImageView.frame.origin.x, ScreenWidth-20-_picImageView.frame.size.width-10-20-magin-15, 15)];
        _chinaeseNameLabel.font = [UIFont systemFontOfSize:14.0];
        _chinaeseNameLabel.textColor = [UIColor blackColor];
        _chinaeseNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_chinaeseNameLabel];
        
        _englishNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_chinaeseNameLabel.frame.origin.x, CGRectGetMaxY(_chinaeseNameLabel.frame)+10, _chinaeseNameLabel.frame.size.width, 15)];
        _englishNameLabel.font = [UIFont systemFontOfSize:14.0];
        _englishNameLabel.textColor = [UIColor blackColor];
        _englishNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_englishNameLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_englishNameLabel.frame.origin.x, CGRectGetMaxY(_englishNameLabel.frame)+10, _englishNameLabel.frame.size.width, 15)];
        _priceLabel.font = [UIFont systemFontOfSize:14.0];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_priceLabel];
        
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(ScreenWidth-60-15, _chinaeseNameLabel.frame.origin.y, 60, 30);
//        _editBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _editBtn.backgroundColor = [UIColor grayColor];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_editBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        [self.contentView addSubview:_editBtn];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(_editBtn.frame.origin.x, CGRectGetMaxY(_editBtn.frame)+5, 60, 30);
//        _deleteBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _deleteBtn.backgroundColor = [UIColor grayColor];
        [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.contentView addSubview:_deleteBtn];
        
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 99, ScreenWidth, 1)];
        lineview.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:lineview];
    }
    return self;
}



- (void) setModel:(MenuModel *)model{
    
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"placeholder4_3"]];
//    _shadeLabel.text = model.Description;
    _priceLabel.text = [NSString stringWithFormat:@"价 格:%@",model.price];
    _englishNameLabel.text = [NSString stringWithFormat:@"英文名:%@",model.ename];
    _chinaeseNameLabel.text = [NSString stringWithFormat:@"中文名:%@",model.name];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
