//
//  FoodMapRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MapToCBaseHttpRequest.h"
#import "FoodMapModel.h"

@interface FoodMapRequest : MapToCBaseHttpRequest

typedef void (^httpResponseBlock)(FoodMapRequest *responseData);

@property (nonatomic,strong) NSError *responseError;

@property (nonatomic,copy) NSString *fackbookId;

@property (nonatomic,strong) NSDictionary *responsedataDic;

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;


@end
