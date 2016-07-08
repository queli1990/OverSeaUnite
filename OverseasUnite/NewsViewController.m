//
//  NewsViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "NewsViewController.h"
#import "LoginNav.h"

@interface NewsViewController ()<UIWebViewDelegate>
@property (nonatomic) UIWebView *webView;
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation NewsViewController

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD show];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self setNav];
    
    [self loadWebView];
}

- (void) setNav{
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-200)/2, 20+(44-20)/2, 200, 20)];
    titleLabel.text = @"侨联之声";
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [_navView addSubview:lineView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(15, 20+(44-49*0.5)/2, 50, 49*0.5);
    [_backBtn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateNormal];
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, (50-28*0.5));
    [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backBtn];
    
    _backBtn.hidden = YES;
    
    [self.view addSubview:_navView];
}

- (void) backBtnClick:(UIButton *)btn{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//- (UIWebView *)webView{
//    if (_webView == nil) {
//        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49)];
//        [self.view addSubview:_webView];
//    }
//    return _webView;
//}

- (void) loadWebView{
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49)];
    
    self.webView.delegate = self;
    
    // webView.scrollView.scrollEnabled = NO; // webView不能滚动
    NSURL *url = [NSURL URLWithString:@"http://cms.gochinatv.com:8080/jeecms/"];
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //    NSURL *url = [NSURL URLWithString:@"http://ibaby.ipadown.com/api/food/food.show.detail.php?id=7"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
    
    __unsafe_unretained UIScrollView *scrollView = self.webView.scrollView;
    // 添加下拉刷新控件
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_webView reload];
    }];
}



- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    [_webView.scrollView.mj_header endRefreshing];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    [_webView.scrollView.mj_header endRefreshing];
    
    if ([_webView canGoBack]) {
        _backBtn.hidden = NO;
    }else{
        _backBtn.hidden = YES;
    }
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
