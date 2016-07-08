//
//  PostImageRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/30.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PostImageRequest.h"
//#define urlSuffix_str @"/ba_v1/save"
//#define urlSuffix_str @"/ba_v1/update"

@implementation PostImageRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    NSString *urlSuffix_str;
    if (_isAdd) {
        urlSuffix_str = @"/ba_v1/save";
    }else{
        urlSuffix_str = @"/ba_v1/update";
    }
    
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
    
    return issuccess;
}

-(NSDictionary *)JsonArrayParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}


@end
