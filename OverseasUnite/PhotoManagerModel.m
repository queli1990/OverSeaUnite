//
//  PhotoManagerModel.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PhotoManagerModel.h"

@implementation PhotoManagerModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (PhotoManagerModel *)modelWithDictionary:(NSDictionary *)dictionary{
    PhotoManagerModel *model = [[PhotoManagerModel alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            PhotoManagerModel *model = [PhotoManagerModel modelWithDictionary:usersArray[i]];
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
