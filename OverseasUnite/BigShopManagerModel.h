//
//  BigShopManagerModel.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/14.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopManagerModel.h"

@interface BigShopManagerModel : NSObject

@property (nonatomic,strong) NSNumber *status;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,strong) NSNumber *currentTime;
@property (nonatomic,strong) NSDictionary *place;
@property (nonatomic,strong) NSArray *deviceList;

@property (nonatomic,strong) ShopManagerModel *model;


+ (BigShopManagerModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
