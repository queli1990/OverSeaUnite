//
//  BigShopManagerModel.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/14.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BigShopManagerModel.h"

@implementation BigShopManagerModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (BigShopManagerModel *)modelWithDictionary:(NSDictionary *)dictionary{
    BigShopManagerModel *bigmodel = [[BigShopManagerModel alloc]initWithDictionary:dictionary];
    
    bigmodel.model = [ShopManagerModel modelWithDictionary:bigmodel.place];
    
    
    return bigmodel;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            BigShopManagerModel *model = [BigShopManagerModel modelWithDictionary:usersArray[i]];
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
