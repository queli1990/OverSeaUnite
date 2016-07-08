//
//  FoodMapRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "FoodMapRequest.h"
//#define urlSuffix_str @"/place/getByBusinessId"

@implementation FoodMapRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    NSString *urlSuffix_str = [NSString stringWithFormat:@"/get/%@.json",self.fackbookId];
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(MapToCBaseHttpRequest *responseData) {
        self.responsedataDic = [self JsonArrayForContentParsing:responseData._data];
        block(self);
        
    }
              andFailure:^(MapToCBaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}



-(NSDictionary *)JsonArrayForContentParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *data = dic[@"data"];
    return data;
}


@end

