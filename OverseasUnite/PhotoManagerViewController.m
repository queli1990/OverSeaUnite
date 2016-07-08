//
//  PhotoManagerViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PhotoManagerViewController.h"
#import "LoginNav.h"
#import "PhotoManagerTableViewCell.h"
#import "PhotoManagerRequest.h"
#import "Map_PostImageViewController.h"

@interface PhotoManagerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *datas;
@end

@implementation PhotoManagerViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PhotoManagerViewControllerReloadData) name:@"PhotoManagerViewControllerReloadData" object:nil];
}

- (void) PhotoManagerViewControllerReloadData{
    [self requestDataWithDic:nil];
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self requestDataWithDic:nil];
}

- (void) requestDataWithDic:(NSMutableDictionary *)dic{
    
    [SVProgressHUD show];
    
    PhotoManagerRequest *request = [[PhotoManagerRequest alloc] init];
    request.facebookId = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookId"];
    [request requestData:dic andBlock:^(PhotoManagerRequest *responseData) {
        
        self.datas = (NSMutableArray *)responseData.responsedataArray;
        
        if (_datas.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无数据" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else{
//            PhotoManagerModel *model = [[PhotoManagerModel alloc] init];
//            [self.datas addObject:model];//为了多一个item，是用来push到下一个页面的
            
            [self initCollectionView];
        }
        [SVProgressHUD dismiss];
        
    } andFailureBlock:^(PhotoManagerRequest *responseData) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void) initAddView{
    
    CGFloat padding = 10;
    CGFloat itemWith = (ScreenWidth - 3*padding)/2;
    CGFloat itemHeight = itemWith*3/4;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, itemWith, itemHeight)];
    imageView.image = [UIImage imageNamed:@"ArrowLeft"];
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goPostPage:)];
    [imageView addGestureRecognizer:tap];
    [self.view addSubview:imageView];
}

- (void) goPostPage:(UITapGestureRecognizer *)tap{
    Map_PostImageViewController *vc = [[Map_PostImageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoManagerTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoManagerTableViewCell" forIndexPath:indexPath];
    cell.model = _datas[indexPath.row];
    
//    if (![cell.model.photoUrl hasPrefix:@"http"]) {
//        cell.bottomImageView.image = [UIImage imageNamed:@"ArrowLeft"];
//        cell.shadowView.hidden = YES;
//        return cell;
//    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

//- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == _datas.count-1) {
//        Map_PostImageViewController *vc = [[Map_PostImageViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (void) initCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat padding = 10;
    CGFloat itemWith = (ScreenWidth - 3*padding)/2;
    CGFloat itemHeight = itemWith*3/4;
    layout.itemSize = CGSizeMake(itemWith, itemHeight);//设置cell的宽高
    
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) collectionViewLayout:layout];
    [_collectionView registerClass:[PhotoManagerTableViewCell class] forCellWithReuseIdentifier:@"PhotoManagerTableViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    [self.view addSubview:_collectionView];
}


- (void) setNav{
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    _navView.titleLabel.text = @"菜单管理";
    _navView.titleLabel.textColor = [UIColor blackColor];
    
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[[UIImage imageNamed:@"addBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(ScreenWidth-15-15, 20+(44-15)/2, 15, 15);
    [addBtn addTarget:self action:@selector(addNewPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:addBtn];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [_navView addSubview:lineView];
    
    [self.view addSubview:_navView];
}

- (void) addNewPhoto:(UIButton *)btn{
    Map_PostImageViewController *vc = [[Map_PostImageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
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
