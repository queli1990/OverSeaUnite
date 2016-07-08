//
//  SetImageInfoViewController.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ViewController.h"

@interface SetImageInfoViewController : ViewController


@property (nonatomic,strong) NSData *imageData;
@property (nonatomic,copy) NSString *deviceId;
@property (nonatomic,copy) NSString *placeId;

@property (nonatomic,copy) NSString *imageUrl;//和imageData不共存，只有一个有值

@property (nonatomic,copy) NSString *editId;//如果是编辑的话，则传一个原有的id过来
@property (nonatomic,copy) NSString *method;

@property (nonatomic,strong) NSDictionary *cameraImageInfo;
@property (nonatomic,strong) NSMutableDictionary *params;


@end
