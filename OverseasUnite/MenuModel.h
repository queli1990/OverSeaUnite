//
//  MenuModel.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (nonatomic,strong) NSNumber *Id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,strong) NSNumber *sort;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *imagePath;
@property (nonatomic,strong) NSNumber *createTime;
@property (nonatomic,copy) NSString *ename;
@property (nonatomic,strong) NSNumber *deviceId;
@property (nonatomic,strong) NSNumber *businessId;
@property (nonatomic,strong) NSNumber *placeId;



+ (MenuModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
