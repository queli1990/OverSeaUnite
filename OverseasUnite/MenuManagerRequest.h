//
//  MenuManagerRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/27.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "MenuModel.h"

@interface MenuManagerRequest : BaseHttpRequest

typedef void (^httpResponseBlock)(MenuManagerRequest *responseData);

@property (nonatomic,strong) NSError *responseError;

@property (nonatomic,strong) NSMutableDictionary *placeDic;
@property (nonatomic,strong) NSArray *responsedataArray;


-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;

@end
