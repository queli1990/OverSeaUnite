//
//  ShopManagerRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/27.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ShopManagerRequest.h"
#define urlSuffix_str @"/place/getByBusinessId"

@implementation ShopManagerRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(BaseHttpRequest *responseData) {
        self.placeDic = [self jsonPlaceDic:responseData._data];
        self.responsedataArray = [self JsonArrayForContentParsing:responseData._data];
        block(self);
        
    }
              andFailure:^(BaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}

- (NSDictionary *) jsonPlaceDic:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *data = dic[@"data"];
    NSDictionary *dataDic = data[0];
    NSDictionary *dicForPlace = dataDic[@"place"];
    return dicForPlace;
}

-(NSArray *)JsonArrayForContentParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *data = dic[@"data"];
    NSArray *models = [BigShopManagerModel modelsWithArray:data];
    return models;
}


@end
