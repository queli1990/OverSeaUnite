//
//  ShopViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ShopViewController.h"
#import "LoginButton.h"
#import "LoginViewController.h"
#import "ShopManagerViewController.h"
#import "ShopViewCell.h"
#import "ShopViewModel.h"
#import "FoodMapViewController.h"

#define loginButtonOrginalHeight 64+40


@interface ShopViewController ()<ReloadUeserInfoDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) LoginButton *loginButton;
@property (nonatomic,strong) UIButton *managerBtn;
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self setNav];
    
    self.view.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    
    [self initTableView];
}

- (void) setNav{
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [_navView addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-200)/2, 20+(44-20)/2, 200, 20)];
    titleLabel.text = @"我的店铺";
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:titleLabel];
    
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(ScreenWidth-15-40, 20+(44-20)/2, 40, 20);
    quitBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [quitBtn setTitle:@"登出" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:quitBtn];
    
    [self.view addSubview:_navView];
}

//退出登录
- (void) quitLogin:(UIButton *)btn{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [self removeFromParentViewController];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
}

- (void) initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10, ScreenWidth, ScreenHeight-64-49-10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ShopViewCell class] forCellReuseIdentifier:@"ShopViewCell"];
    [self.view addSubview:_tableView];
}

#pragma mark TableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopViewCell"];
    cell.model = self.datas[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell取消点中效果颜色
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ShopManagerViewController *vc = [[ShopManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        FoodMapViewController *VC = [[FoodMapViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        
        ShopViewModel *model1 = [[ShopViewModel alloc] init];
        model1.titleLabelStr = @"我的大屏";
        model1.picImgViewStr = @"myBigScreen";

        ShopViewModel *model2 = [[ShopViewModel alloc] init];
        model2.titleLabelStr = @"我的吃遍全球";
        model2.picImgViewStr = @"myFoodMap";
        
        [_datas addObject:model1];
        [_datas addObject:model2];
    }
    return _datas;
}

//[self.leveyTabBarController hidesTabBar:YES animated:YES];


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
