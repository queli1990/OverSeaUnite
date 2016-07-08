//
//  MenuManagerRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/27.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MenuManagerRequest.h"
#define urlSuffix_str @"/ba_v1/queryList"


@implementation MenuManagerRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(BaseHttpRequest *responseData) {
        self.responsedataArray = [self JsonArrayForContentParsing:responseData._data];
        
        block(self);
        
    }
              andFailure:^(BaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}



-(NSArray *)JsonArrayForContentParsing:(id) responseObject{
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *models = [MenuModel modelsWithArray:dic];
    return models;
}

@end
