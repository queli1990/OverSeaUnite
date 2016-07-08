//
//  ShopManagerModel.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopManagerModel : NSObject

//@property (nonatomic,strong) NSNumber *status;
//@property (nonatomic,strong) NSNumber *message;
//@property (nonatomic,strong) NSNumber *currentTime;
//@property (nonatomic,strong) NSNumber *id;
//@property (nonatomic,copy) NSString *cname;
//@property (nonatomic,copy) NSString *ename;
//@property (nonatomic,strong) NSNumber *type;
//@property (nonatomic,copy) NSString *scale;
//@property (nonatomic,copy) NSString *averageDailyFlow;
//@property (nonatomic,copy) NSString *countryCode;
//@property (nonatomic,copy) NSString *areaCode;
//@property (nonatomic,copy) NSString *cityCode;
//@property (nonatomic,copy) NSString *address;
//@property (nonatomic,copy) NSString *zipCode;
//@property (nonatomic,strong) NSNumber *businessId;
//@property (nonatomic,strong) NSNumber *createTime;
//@property (nonatomic,copy) NSString *countryName;
//@property (nonatomic,copy) NSString *areaName;
//@property (nonatomic,copy) NSString *cityName;

@property (nonatomic,strong) NSNumber *status;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,strong) NSNumber *currentTime;
@property (nonatomic,strong) NSNumber *Id;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *brand;
@property (nonatomic,copy) NSString *model;
@property (nonatomic,copy) NSString *mac;
@property (nonatomic,strong) NSNumber *placeId;
@property (nonatomic,strong) NSNumber *businessId;
@property (nonatomic,strong) NSNumber *screenNum;
@property (nonatomic,strong) NSNumber *createTime;
@property (nonatomic,copy) NSString *cityCode;
@property (nonatomic,strong) NSNumber *screenShotInterval;
@property (nonatomic,strong) NSNumber *refreshTime;


+ (ShopManagerModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;

@end
