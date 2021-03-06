//
//  FoodMapModel.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodMapModel : NSObject

@property (nonatomic,strong) NSNumber *start;
@property (nonatomic,strong) NSNumber *fetchsize;
@property (nonatomic,strong) NSNumber *page;
@property (nonatomic,strong) NSNumber *rows;
@property (nonatomic,strong) NSNumber *businessId;
@property (nonatomic,copy) NSString *categories;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *photoUrl;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *avgPrice;
@property (nonatomic,copy) NSString *regions;
@property (nonatomic,copy) NSString *avgRating;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *productScore;
@property (nonatomic,copy) NSString *decorationScore;
@property (nonatomic,copy) NSString *serviceScore;
@property (nonatomic,copy) NSString *telephone;
@property (nonatomic,copy) NSString *businessTime;
@property (nonatomic,copy) NSString *lat;
@property (nonatomic,copy) NSString *lng;
@property (nonatomic,copy) NSString *bigPhotoUrl;
@property (nonatomic,copy) NSString *createtime;

+ (FoodMapModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
