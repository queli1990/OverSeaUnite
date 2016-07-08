//
//  DeleteFoodRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/30.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PostBaseHttpRequest.h"

@interface DeleteFoodRequest : PostBaseHttpRequest

typedef void (^DeleteFoodBlock)(DeleteFoodRequest *responseData);

@property (nonatomic,strong) NSError *responseError;
@property (nonatomic,strong) NSDictionary *responsedataDic;

@property (nonatomic,copy) NSString *isSuccess;


-(id)requestData:(NSDictionary *)params andBlock:(DeleteFoodBlock)block andFailureBlock:(DeleteFoodBlock)failureBlock;


@end
