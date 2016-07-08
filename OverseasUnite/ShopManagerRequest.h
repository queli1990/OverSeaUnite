//
//  ShopManagerRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/27.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "BigShopManagerModel.h"

@interface ShopManagerRequest : BaseHttpRequest

typedef void (^httpResponseBlock)(ShopManagerRequest *responseData);

@property (nonatomic,strong) NSError *responseError;


@property (nonatomic,strong) NSArray *responsedataArray;
@property (nonatomic,strong) NSDictionary *placeDic;


-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;


@end
