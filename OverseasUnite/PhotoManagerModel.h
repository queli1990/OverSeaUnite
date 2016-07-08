//
//  PhotoManagerModel.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoManagerModel : NSObject

@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *photoUrl;


+ (PhotoManagerModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
