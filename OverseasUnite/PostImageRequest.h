//
//  PostImageRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/30.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PostBaseHttpRequest.h"

@interface PostImageRequest : PostBaseHttpRequest

typedef void (^httpResponseBlock)(PostImageRequest *responseData);

@property (nonatomic,strong) NSError *responseError;
@property (nonatomic,strong) NSDictionary *responsedataDic;
@property (nonatomic,copy) NSString *isSuccess;

@property (nonatomic) BOOL isAdd;

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;

@end
