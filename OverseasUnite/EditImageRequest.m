//
//  EditImageRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/31.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "EditImageRequest.h"
#define urlSuffix_str @"/ba_v1/update"

@implementation EditImageRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
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
    NSString *issuccess = [NSString stringWithFormat:@"%@",dic[@"status"]];
    NSLog(@"%@",dic[@"mes"]);
    
    return issuccess;
}

-(NSDictionary *)JsonArrayParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}

@end
