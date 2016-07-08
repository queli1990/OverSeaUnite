//
//  MenuManagerViewController.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ViewController.h"

@interface MenuManagerViewController : ViewController

@property (nonatomic,copy) NSString *deviceId;
@property (nonatomic,copy) NSString *placeId;

@property (nonatomic,copy) NSString *shopName;

@property (nonatomic,strong) NSMutableDictionary *params;

@end
