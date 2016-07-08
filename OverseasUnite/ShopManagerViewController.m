//
//  ShopManagerViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ShopManagerViewController.h"
#import "LoginNav.h"
#import "ShopManagerCell.h"
#import "BigShopManagerModel.h"
#import "MenuManagerViewController.h"
#import "ShopManagerRequest.h"


@interface ShopManagerViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableDictionary *placeDic;
@property (nonatomic) NSInteger isHaveData;
@end

@implementation ShopManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self setParams];
    
    [self requesetDataWithDictionary:_params];
}


- (void) setParams{
    self.params = [NSMutableDictionary dictionary];
    NSString *Id = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [self.params setObject:Id forKey:@"businessId"];
}

- (void) requesetDataWithDictionary:(NSDictionary *)dic{
    [SVProgressHUD show];
    
    [[ShopManagerRequest alloc] requestData:dic andBlock:^(ShopManagerRequest *responseData) {
        
        if (responseData.responsedataArray.count) {
            self.datas = (NSMutableArray *)responseData.responsedataArray;
            self.placeDic = (NSMutableDictionary *)responseData.placeDic;
            [self initTableView];
        }else{
            _isHaveData = 1;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无数据" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"取消", nil];
            [alert show];
        }
        
        [SVProgressHUD dismiss];
        
    } andFailureBlock:^(ShopManagerRequest *responseData) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void) initTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ShopManagerCell class] forCellReuseIdentifier:@"ShopManagerCell"];
    [self.view addSubview:_tableView];
}

- (void) editBtnClick:(UIButton *)btn{
    MenuManagerViewController *vc = [[MenuManagerViewController alloc] init];
    vc.deviceId = [NSString stringWithFormat:@"%ld",btn.tag -1000];
    vc.placeId = [NSString stringWithFormat:@"%@",btn.placeDic[@"id"]];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BigShopManagerModel *model = _datas[indexPath.section];
    NSDictionary *dic = model.deviceList[indexPath.row];
    model.model = [ShopManagerModel modelWithDictionary:dic];
    
    ShopManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopManagerCell" forIndexPath:indexPath];
    cell.model = model.model;
    cell.placeDic = model.place;
    cell.managerBtn.placeDic = model.place;
    
    NSNumber *Id = model.model.Id;
    cell.managerBtn.tag = 1000+Id.integerValue;
    
    MenuManagerViewController *vc = [[MenuManagerViewController alloc] init];
    vc.deviceId = [NSString stringWithFormat:@"%ld",Id.integerValue -1000];
    vc.placeId = [NSString stringWithFormat:@"%@",cell.managerBtn.placeDic[@"id"]];
    
    vc.shopName = self.placeDic[@"cname"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopManagerCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell取消点中效果颜色
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.backgroundColor = [UIColor whiteColor];
    
    BigShopManagerModel *model = _datas[indexPath.section];
    NSDictionary *dic = model.deviceList[indexPath.row];
    model.model = [ShopManagerModel modelWithDictionary:dic];
    
    cell.model = model.model;
    cell.placeDic = model.place;
    cell.managerBtn.placeDic = model.place;
    
    NSNumber *Id = model.model.Id;
    cell.managerBtn.tag = 1000+Id.integerValue;
    
    [cell.managerBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BigShopManagerModel *model = self.datas[section];
    return model.deviceList.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


- (void) setNav{
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    _navView.titleLabel.text = @"管理店铺";
    _navView.titleLabel.textColor = [UIColor blackColor];
    
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [_navView addSubview:lineView];
    
    [self.view addSubview:_navView];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [SVProgressHUD dismiss];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.datas.count && _isHaveData != 1) {
        [SVProgressHUD show];
    }
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
