//
//  FoodMapViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/15.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "FoodMapViewController.h"
#import "LoginNav.h"
#import "FoodMapRequest.h"
#import "FoodMapModel.h"
#import "FoodMapCell.h"
#import "PhotoManagerViewController.h"

@interface FoodMapViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) FoodMapModel *model;
@end

@implementation FoodMapViewController

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestDataWithDic:nil];
}

- (void) initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FoodMapCell class] forCellReuseIdentifier:@"FoodMapCell"];
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodMapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodMapCell"];
    cell.model = _datas[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边的箭头
    
    cell.updataFoodBtn.hidden = YES;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoManagerViewController *vc = [[PhotoManagerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void) requestDataWithDic:(NSMutableDictionary *)dic{
    
    [SVProgressHUD show];
    
    FoodMapRequest *request = [[FoodMapRequest alloc] init];
    request.fackbookId = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookId"];
    [request requestData:nil andBlock:^(FoodMapRequest *responseData) {
        
        self.model = [FoodMapModel modelWithDictionary:responseData.responsedataDic];
        [self.datas addObject:_model];
        [self initTableView];
        [SVProgressHUD dismiss];
        
    } andFailureBlock:^(FoodMapRequest *responseData) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}


- (void) setNav{
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    _navView.titleLabel.text = @"吃遍全球商户站";
    _navView.titleLabel.textColor = [UIColor blackColor];
    
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [_navView addSubview:lineView];
    
    [self.view addSubview:_navView];
}

- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
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
