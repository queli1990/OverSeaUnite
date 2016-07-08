//
//  LoginViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginNav.h"
#import "LoginRequest.h"
#import "ShopManagerViewController.h"
#import "ShopViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) UITextField *nickNameTextField;
@property (nonatomic,strong) UITextField *passWordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self initTextField];
    
}

- (void) setNav{
    
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = [UIColor clearColor];
    
    _navView.titleLabel.text = @"立即登录";
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    _navView.backBtn.hidden = YES;
    
    [self.view addSubview:_navView];
}

- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initTextField{
    UIView *inputView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 64+20, ScreenWidth-20, 40)];
    //    inputView1.layer.masksToBounds = YES;
    //    inputView1.layer.borderWidth = 1.0;
    //    inputView1.layer.borderColor = [UIColor grayColor].CGColor;
    //    inputView1.layer.cornerRadius = 14.0;
    inputView1.backgroundColor = [UIColor clearColor];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 49, ScreenWidth-40, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    [inputView1 addSubview:lineView1];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (40-28)/2, 28, 28)];
    headImageView.image = [UIImage imageNamed:@"personal"];
    [inputView1 addSubview:headImageView];
    
    self.nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, 5, ScreenWidth-60-headImageView.frame.size.width-30-10-5-20, 30)];
    _nickNameTextField.placeholder = @"请输入用户名";
    _nickNameTextField.backgroundColor = [UIColor clearColor];
    //设置placeholder的颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_nickNameTextField.placeholder attributes:dict];
    [_nickNameTextField setAttributedPlaceholder:attribute];
    _nickNameTextField.textColor = [UIColor blackColor];
    _nickNameTextField.font = [UIFont systemFontOfSize:16.0];
    //    _nickNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    
    //    _nickNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nickNameTextField.delegate = self;
    [inputView1 addSubview:_nickNameTextField];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(CGRectGetMaxX(_nickNameTextField.frame)+5, 10, 20, 20);
    [clearBtn setImage:[UIImage imageNamed:@"personal_clearBtnNormal"] forState:UIControlStateNormal];
    [clearBtn setImage:[UIImage imageNamed:@"personal_clearBtnHeighted"] forState:UIControlStateHighlighted];
    [clearBtn addTarget:self action:@selector(clearInput:) forControlEvents:UIControlEventTouchUpInside];
    [inputView1 addSubview:clearBtn];
    
    [self.view addSubview:inputView1];
    
    
    UIView *inputView2 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(inputView1.frame)+30, ScreenWidth-20, 40)];
    //    inputView2.layer.masksToBounds = YES;
    //    inputView2.layer.borderWidth = 1.0;
    //    inputView2.layer.borderColor = [UIColor grayColor].CGColor;
    //    inputView2.layer.cornerRadius = 14.0;
    inputView2.backgroundColor = [UIColor clearColor];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 39, ScreenWidth-40, 1)];
    lineView2.backgroundColor = [UIColor grayColor];
    [inputView2 addSubview:lineView2];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (40-26)/2, 26, 26)];
    passwordImageView.image = [UIImage imageNamed:@"personal_lock"];
    [inputView2 addSubview:passwordImageView];
    
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImageView.frame)+15, 5, _nickNameTextField.frame.size.width, 30)];
    _passWordTextField.textColor = [UIColor blackColor];
    _passWordTextField.placeholder = @"请输入登录密码";
    _passWordTextField.secureTextEntry = YES;
    //设置placeholder的颜色
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    dict2[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSAttributedString *attribute2 = [[NSAttributedString alloc] initWithString:_passWordTextField.placeholder attributes:dict2];
    [_passWordTextField setAttributedPlaceholder:attribute2];
    _passWordTextField.font = [UIFont systemFontOfSize:16.0];
    //    _passWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextField.delegate = self;
    [inputView2 addSubview:_passWordTextField];
    
    [self.view addSubview:inputView2];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat scal = (ScreenWidth-20-20)/630;
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(inputView2.frame)+30, ScreenWidth-20-20, 104*scal);
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = [UIColor redColor];
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = 6.0;
//    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginAndRegistBg"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    NSString *noAccountLabelText = @"还没有账号？快快申请加入我们";
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    CGSize maginSize = [noAccountLabelText sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    
    NSString *noAccountLabelText1 = @"还没有账号？";
    UIFont *font1 = [UIFont fontWithName:@"Arial" size:14];
    CGSize maginSize1 = [noAccountLabelText1 sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font1,NSFontAttributeName, nil]];
    
    UILabel *noAccountLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-maginSize.width)/2, CGRectGetMaxY(loginBtn.frame)+10, maginSize1.width, 30)];
    noAccountLabel.text = @"还没有账号？";
    noAccountLabel.textColor = [UIColor redColor];
    noAccountLabel.textAlignment = NSTextAlignmentRight;
    noAccountLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:noAccountLabel];
    noAccountLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goWeb:)];
    [noAccountLabel addGestureRecognizer:tap];
    
    
    UILabel *joinUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(noAccountLabel.frame), noAccountLabel.frame.origin.y, ScreenWidth-CGRectGetMaxX(noAccountLabel.frame), 30)];
    joinUsLabel.text = @"快快申请加入我们";
    joinUsLabel.textColor = [UIColor blackColor];
    joinUsLabel.textAlignment = NSTextAlignmentLeft;
    joinUsLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:joinUsLabel];
    
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(20, CGRectGetMaxY(loginBtn.frame)+20, ScreenWidth-20-20, 40);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"personalBgNormal"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"personalBgHeighted"] forState:UIControlStateHighlighted];
    //    [self.view addSubview:registBtn];
    
}

- (void) goWeb:(UITapGestureRecognizer *)tap{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://qiaolian.mikecrm.com/VwBP50"]];
}

- (void) clearInput:(UIButton *)btn{
    _nickNameTextField.text = nil;
}

- (void) login:(UIButton *)btn{
    
    if (_nickNameTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [_nickNameTextField resignFirstResponder];
        return;
    }
    if (_passWordTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [_passWordTextField resignFirstResponder];
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%@",_nickNameTextField.text] forKey:@"userName"];
    [dic setObject:[NSString stringWithFormat:@"%@",_passWordTextField.text] forKey:@"password"];
    
    [[LoginRequest alloc] requestData:dic andBlock:^(LoginRequest *responseData) {
        
        if ([responseData.flag isEqualToString:@"1"]) {
            
            NSString *userId = [NSString stringWithFormat:@"%@",responseData.responsedataDic[@"id"]];
            NSString *facebookId = [NSString stringWithFormat:@"%@",responseData.responsedataDic[@"facebook"]];
            
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] setObject:facebookId forKey:@"facebookId"];
            
            NSLog(@"登录成功，此时需要刷新页面数据");
            ShopViewController *vc = [[ShopViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
            [self removeFromParentViewController];//登录成功后，就不用再进入登录页面
            
//            if ([self.delegate respondsToSelector:@selector(reloadUeserInfoDelegate)]) {
//                [self.delegate reloadUeserInfoDelegate];
//            }
            
            
        }else{
            UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"警告" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [success show];
        }
        
        [SVProgressHUD dismiss];
        
    } andFailureBlock:^(LoginRequest *responseData) {
        
        [SVProgressHUD dismiss];
        
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"警告" message:@"登录失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [fail show];
    }];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_passWordTextField resignFirstResponder];
    [_nickNameTextField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
