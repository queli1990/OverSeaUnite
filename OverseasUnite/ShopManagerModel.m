//
//  ShopManagerModel.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ShopManagerModel.h"

@implementation ShopManagerModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        NSString *newId = [dictionary valueForKey:@"id"];
        NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        [newDic removeObjectForKey:@"id"];
        [newDic setValue:newId forKey:@"Id"];
        [self setValuesForKeysWithDictionary:newDic];
    }
    return self;
}

+ (ShopManagerModel *)modelWithDictionary:(NSDictionary *)dictionary{
    ShopManagerModel *model = [[ShopManagerModel alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            ShopManagerModel *model = [ShopManagerModel modelWithDictionary:usersArray[i]];
            [array addObject:model];
        }
        return (NSArray *)array;
    }else{
        return nil;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    NSLog(@"underFinedKey:%@",key);
}


@end
