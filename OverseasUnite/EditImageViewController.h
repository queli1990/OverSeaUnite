//
//  EditImageViewController.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/7.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditImageViewController : UIViewController

@property (nonatomic,copy) NSString *placeId;
@property (nonatomic,copy) NSString *deviceId;
@property (nonatomic,copy) NSString *method;
@property (nonatomic,copy) NSString *editId;

//@property (nonatomic,strong) NSData *data;
@property (nonatomic,strong) UIImage *originalImg;

@end
