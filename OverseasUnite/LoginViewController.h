//
//  LoginViewController.h
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReloadUeserInfoDelegate <NSObject>

- (void) reloadUeserInfoDelegate;

@end

@interface LoginViewController : UIViewController

@property (nonatomic,weak) id<ReloadUeserInfoDelegate> delegate;

@end
