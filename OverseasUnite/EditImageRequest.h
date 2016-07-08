//
//  EditImageRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/31.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PostBaseHttpRequest.h"

@interface EditImageRequest : PostBaseHttpRequest

typedef void (^httpResponseBlock)(EditImageRequest *responseData);

@property (nonatomic,strong) NSError *responseError;
@property (nonatomic,strong) NSDictionary *responsedataDic;
@property (nonatomic,copy) NSString *isSuccess;


-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;

@end
