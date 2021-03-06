//
//  MapToCPostBaseHttpRequest.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/16.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MapToCPostBaseHttpRequest.h"
#define baseURL_vego @"http://food.gochinatv.com:2048/api/business"//线上


@implementation MapToCPostBaseHttpRequest

-(void)basePostDataRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(PostBasehttpResponseBlock)block andFailure:(PostBasehttpResponseBlock)failureBlock{
    
    NSString*url = [self buildUrlStr:nil andTransactionSuffix:urlSuffix];
    //    NSLog(@"url:%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self._data = responseObject;
        block(self);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _error = error;
        failureBlock(self);
    }];
    
}

- (void) basePostFlagRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(PostBasehttpFlagBlock)block andFailure:(PostBasehttpFlagBlock)failureBlock{
    
    NSString*url = [self buildUrlStr:nil andTransactionSuffix:urlSuffix];
    //    NSLog(@"url:%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求格式
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.flag = [NSString stringWithFormat:@"%@",dic[@"success"]];
        
        block(self.flag);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.flag = @"failure";
        _error = error;
        failureBlock(self.flag);
    }];
    
}

-(NSString*)buildUrlStr:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix{
    
    NSMutableString *urlString =[NSMutableString string];
    
    [urlString appendString:baseURL_vego];
    
    [urlString appendString:urlSuffix];
    
    //    [urlString appendString:@"?"];
    //
    //    NSArray *array = @[@"cpid",@"plateform_id",@"topic_id",@"page",@"size"];
    //    for (int i = 0; i < array.count; i++) {
    //        NSString *value = [params valueForKey:array[i]];
    //        [urlString appendFormat:@"%@=%@",array[i],value];
    //    }
    //
    //    return urlString;
    NSString *escapedString;
    NSInteger keyIndex = 0;
    
    
    for (id key in params) {
        if(keyIndex == 0){
            
            escapedString =(NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[params valueForKey:key], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
            [urlString appendFormat:@"?%@=%@",key,escapedString];
        }else{
            
            escapedString =(NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[params valueForKey:key], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
            [urlString appendFormat:@"&%@=%@",key,escapedString];
            
        }
        
        keyIndex ++;
    }
    return urlString;
}


@end
