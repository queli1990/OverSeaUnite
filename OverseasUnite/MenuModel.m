//
//  MenuModel.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        NSString *newId = [dictionary valueForKey:@"description"];
        NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        [newDic removeObjectForKey:@"description"];
        [newDic setValue:newId forKey:@"Description"];
        
        NSString *new = [dictionary valueForKey:@"id"];
        [newDic removeObjectForKey:@"id"];
        [newDic setValue:new forKey:@"Id"];
        
        [self setValuesForKeysWithDictionary:newDic];
    }
    return self;
}

+ (MenuModel *)modelWithDictionary:(NSDictionary *)dictionary{
    MenuModel *model = [[MenuModel alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            MenuModel *model = [MenuModel modelWithDictionary:usersArray[i]];
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
