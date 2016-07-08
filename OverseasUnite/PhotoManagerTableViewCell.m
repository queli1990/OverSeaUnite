//
//  PhotoManagerTableViewCell.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PhotoManagerTableViewCell.h"

@implementation PhotoManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
        _shadowView.backgroundColor = UIColorFromRGB(0x000000, 0.6);
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _shadowView.frame.size.width, 25)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        [_shadowView addSubview:_titleLabel];
        [_bottomImageView addSubview:_shadowView];
        [self.contentView addSubview:_bottomImageView];
    }
    
    return self;
}

- (void) setModel:(PhotoManagerModel *)model{
    _model = model;
    _titleLabel.text = model.name;
    [_bottomImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"placeholder4_3"]];
}


@end
