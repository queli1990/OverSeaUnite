//
//  DeleteFoodRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/30.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DeleteFoodRequest.h"
#define urlSuffix_str @"/ba_v1/delete"

@implementation DeleteFoodRequest


-(id)requestData:(NSDictionary *)params andBlock:(DeleteFoodBlock)block andFailureBlock:(DeleteFoodBlock)failureBlock{
    
    [self basePostDataRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(PostBaseHttpRequest *responseData) {
        self.isSuccess = [self jsonFlag:responseData._data];
        self.responsedataDic = [self JsonArrayParsing:responseData._data];
        block(self);
    } andFailure:^(PostBaseHttpRequest *responseData) {
        self.responseError = responseData.error;
        failureBlock(self);
    }];
    
    return self;
}

- (NSString *)jsonFlag:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
    return str;
}

-(NSDictionary *)JsonArrayParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}

@end
