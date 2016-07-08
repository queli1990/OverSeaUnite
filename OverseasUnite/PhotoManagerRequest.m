//
//  PhotoManagerRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PhotoManagerRequest.h"

@implementation PhotoManagerRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    NSString *urlSuffix_str = [NSString stringWithFormat:@"/photos/%@.json",self.facebookId];
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(MapToCBaseHttpRequest *responseData) {
        
        self.responsedataArray = [self JsonArrayForContentParsing:responseData._data];
        block(self);
        
    }
              andFailure:^(MapToCBaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}


-(NSArray *)JsonArrayForContentParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *dic_array = dic[@"data"];
    NSArray *models = [PhotoManagerModel modelsWithArray:dic_array];
    return models;
}

@end
