//
//  MapToCBaseHttpRequest.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit+AFNetworking.h"

@interface MapToCBaseHttpRequest : NSObject

@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) id _data;
@property (nonatomic,copy) NSString *flag;


typedef void (^basehttpResponseBlock)(MapToCBaseHttpRequest *responseData);
typedef void (^basehttpFlagBlock)(NSString *flag);


-(void)baseGetRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpResponseBlock)block andFailure:(basehttpResponseBlock)failureBlock;

- (void) basePostRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpFlagBlock)block andFailure:(basehttpFlagBlock)failureBlock;

//- (void) baseDeleteRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) uslSuffix andBlock:()


@end
