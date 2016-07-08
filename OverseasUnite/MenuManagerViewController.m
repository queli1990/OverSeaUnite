//
//  MenuManagerViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MenuManagerViewController.h"
#import "LoginNav.h"
#import "MenuModel.h"
#import "MenuTableViewCell.h"
#import "SetImageInfoViewController.h"
#import "MenuManagerRequest.h"
#import "DeleteFoodRequest.h"
#import "SDWebImageManager.h"


@interface MenuManagerViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableDictionary *placeDic;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic) NSInteger isHaveData;
//@property (nonatomic,strong) UIAlertView *nodataAlert;
@end

@implementation MenuManagerViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceIdToReload:) name:@"deviceIdToReload" object:nil];
    if (!self.datas.count && _isHaveData != 1) {
        [SVProgressHUD show];
    }
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [SVProgressHUD dismiss];
}

- (void) deviceIdToReload:(NSNotification *)noti{
    NSDictionary *dic = [noti userInfo];
    self.deviceId = dic[@"deviceIdToReload"];
    [self setParams];
    [self requestDataWithDic:_params];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self setParams];
    
    [self requestDataWithDic:_params];
}

- (void) setParams
{
    self.params = [NSMutableDictionary dictionary];
    [self.params setObject:self.deviceId forKey:@"deviceId"];
}

- (void) requestDataWithDic:(NSDictionary *)dic
{
    [SVProgressHUD show];
    [[MenuManagerRequest alloc] requestData:dic andBlock:^(MenuManagerRequest *responseData) {
        
        if (responseData.responsedataArray.count) {
            self.datas = (NSMutableArray *)responseData.responsedataArray;
            
            [self initTableView];
            
            [self.tableView reloadData];
        }else{
            _isHaveData = 1;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无数据" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [SVProgressHUD dismiss];
    } andFailureBlock:^(MenuManagerRequest *responseData) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}


- (void) initTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-49-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"MenuTableViewCell"];
    [self.view addSubview:_tableView];
}

- (void) showDeleteFailTextField{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"删除失败，请重新操作" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark TableViewDelegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    cell.model = _datas[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell取消点中效果颜色
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *shopInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 60)];
    shopInfoView.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    UILabel *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (60-40)/2, ScreenWidth, 40)];
    shopLabel.textColor = [UIColor redColor];
    shopLabel.textAlignment = NSTextAlignmentLeft;
    shopLabel.font = [UIFont systemFontOfSize:16.0];
    shopLabel.backgroundColor = [UIColor whiteColor];
    shopLabel.text = [NSString stringWithFormat:@"    店铺名称：%@",self.shopName];
    [shopInfoView addSubview:shopLabel];
    return shopInfoView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

//进入编辑页面
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    
    SetImageInfoViewController *editImgVC = [[SetImageInfoViewController alloc] init];
    MenuModel *model = _datas[index];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imagePath]];
    
//    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.imagePath] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        editImgVC.imageData = UIImagePNGRepresentation(image);
//    }];
    
//    editImgVC.imageData = data;//编辑时传入的网址,不传data，由下个页面去下载图片
    editImgVC.imageUrl = model.imagePath;
    
    editImgVC.placeId = self.placeId;
    editImgVC.deviceId = self.deviceId;
    editImgVC.method = @"edit";
    editImgVC.editId = [NSString stringWithFormat:@"%@",model.Id];
    [self.navigationController pushViewController:editImgVC animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

// 当删除按钮被按下
// 这个方法一旦实现，它就具有了手指从右往左滑动cell的时候出现的“删除”按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView setEditing:NO];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    
    NSInteger index = indexPath.row;
    NSString *Id = [NSString stringWithFormat:@"%@",[_datas[index] Id]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:Id forKey:@"businessAdId"];
    
    [[DeleteFoodRequest alloc] requestData:dic andBlock:^(DeleteFoodRequest *responseData) {
        
        if ([responseData.isSuccess isEqualToString:@"1"]) {
            [_datas removeObjectAtIndex:index];
            [_tableView reloadData];
        }else{
            [self showDeleteFailTextField];
        }
        [SVProgressHUD dismiss];
    } andFailureBlock:^(DeleteFoodRequest *responseData) {
        [self showDeleteFailTextField];
        [SVProgressHUD dismiss];
    }];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    // 让tableView进入编辑/非编辑状态
    [self.tableView setEditing:editing animated:animated];
}

// 定制“删除”这些字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


- (void) setNav{
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    _navView.titleLabel.text = @"菜单管理";
    _navView.titleLabel.textColor = [UIColor blackColor];
    
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[[UIImage imageNamed:@"addBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(ScreenWidth-15-15, 20+(44-15)/2, 15, 15);
    [addBtn addTarget:self action:@selector(addNewFood:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:addBtn];
    
    [self.view addSubview:_navView];
}

//添加新的菜品
- (void) addNewFood:(UIButton *)btn{
    SetImageInfoViewController *editImgVC = [[SetImageInfoViewController alloc] init];
    
    editImgVC.placeId = self.placeId;
    editImgVC.deviceId = self.deviceId;
    editImgVC.method = @"add";
    [self.navigationController pushViewController:editImgVC animated:YES];
}



//让图片的方向始终为正
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
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
