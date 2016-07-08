//
//  PhotoManagerRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MapToCBaseHttpRequest.h"
#import "PhotoManagerModel.h"

@interface PhotoManagerRequest : MapToCBaseHttpRequest

typedef void (^httpResponseBlock)(PhotoManagerRequest *responseData);

@property (nonatomic,strong) NSError *responseError;

@property (nonatomic,strong) NSString *facebookId;

@property (nonatomic,strong) NSArray *responsedataArray;


-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;


@end
