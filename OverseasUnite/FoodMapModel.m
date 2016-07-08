//
//  FoodMapModel.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "FoodMapModel.h"

@implementation FoodMapModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (FoodMapModel *)modelWithDictionary:(NSDictionary *)dictionary{
    FoodMapModel *model = [[FoodMapModel alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            FoodMapModel *model = [FoodMapModel modelWithDictionary:usersArray[i]];
            [array addObject:model];
        }
        return (NSArray *)array;
    }else{
        return nil;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"underFinedKey:%@",key);
}


@end
