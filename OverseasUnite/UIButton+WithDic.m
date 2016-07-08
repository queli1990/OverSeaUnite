//
//  UIButton+WithDic.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/14.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "UIButton+WithDic.h"
#import <objc/runtime.h>

@implementation UIButton (WithDic)

char cName;

- (void) setPlaceDic:(NSDictionary *)placeDic{
    objc_setAssociatedObject(self, &cName, placeDic, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)placeDic{
    return objc_getAssociatedObject(self, &cName);
}


@end
