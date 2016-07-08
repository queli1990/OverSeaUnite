//
//  Map_PostImageViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/17.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "Map_PostImageViewController.h"
#import "LoginNav.h"

@interface Map_PostImageViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) UIImageView *cameraImageView;
@property (nonatomic,strong) NSData *imageData;

@property (nonatomic,strong) UIView *viewForText;
@property (nonatomic,strong) UILabel *cNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UITextField *cTextField;
@property (nonatomic,strong) UITextField *priceTextField;

@property (nonatomic,strong) UIButton *saveBtn;

@end

@implementation Map_PostImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self initCameraImageView];//获取图片
    
    [self initTextFiledView];
    
    [self initSaveBtn];
}

- (void) initTextFiledView{
    
    self.viewForText = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cameraImageView.frame)+10, ScreenWidth, 90)];
    _viewForText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_viewForText];
    
    self.cNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
    _cNameLabel.text = @"菜品名称：";
    _cNameLabel.textColor = [UIColor blackColor];
    _cNameLabel.textAlignment = NSTextAlignmentLeft;
    _cNameLabel.font = [UIFont systemFontOfSize:16.0];
    
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cNameLabel.frame.origin.x, CGRectGetMaxY(_cNameLabel.frame)+5, _cNameLabel.frame.size.width, 30)];
    _priceLabel.text = @"菜品价格：";
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:16.0];
    
    
    _cTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cNameLabel.frame)+5, _cNameLabel.frame.origin.y, ScreenWidth-_cNameLabel.frame.size.width-30, _cNameLabel.frame.size.height-1)];
    _cTextField.delegate = self;
    _cTextField.textAlignment = NSTextAlignmentLeft;
    _cTextField.textColor = [UIColor blackColor];
    _cTextField.placeholder = @"输入菜品中文名";
    _cTextField.font = [UIFont systemFontOfSize:14.0];
    UIView *cNameLine = [[UIView alloc] initWithFrame:CGRectMake(_cTextField.frame.origin.x, CGRectGetMaxY(_cTextField.frame), _cTextField.frame.size.width, 1)];
    [_viewForText addSubview:_cTextField];
    [_viewForText addSubview:cNameLine];
    
    
    _priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame)+5, _priceLabel.frame.origin.y, ScreenWidth-_priceLabel.frame.size.width-30, _priceLabel.frame.size.height-1)];
    _priceTextField.delegate = self;
    _priceTextField.textAlignment = NSTextAlignmentLeft;
    _priceTextField.textColor = [UIColor blackColor];
    _priceTextField.placeholder = @"请注意输入货币单位";
    _priceTextField.font = [UIFont systemFontOfSize:14.0];
    UIView *priceLine = [[UIView alloc] initWithFrame:CGRectMake(_priceTextField.frame.origin.x, CGRectGetMaxY(_priceTextField.frame), _priceTextField.frame.size.width, 1)];
    [_viewForText addSubview:_priceTextField];
    [_viewForText addSubview:priceLine];
    
    [_viewForText addSubview:_cNameLabel];
    [_viewForText addSubview:_priceLabel];
}

- (void) initSaveBtn{
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(25, CGRectGetMaxY(_viewForText.frame)+20, ScreenWidth-50, 40);
    [_saveBtn setTitle:@"上  传" forState:UIControlStateNormal];
    _saveBtn.backgroundColor = [UIColor redColor];
    _saveBtn.clipsToBounds = YES;
    _saveBtn.layer.cornerRadius = 6;
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
}

- (void) saveBtnClick:(UIButton *)btn{
    if (self.imageData.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未添加图片" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [SVProgressHUD show];
    
    _saveBtn.userInteractionEnabled = NO;
    
    //    NSString* encodeResult = [self.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *urlString = @"http://food.gochinatv.com:2048/api/business/share";
    
    
    if (self.imageData.length >1024*1024) {//10M
        UIImage *image = [UIImage imageWithData:self.imageData];
        self.imageData = UIImageJPEGRepresentation(image, 0.5);
    }
    
    NSString *Id = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookId"];
    NSString *imageDataStr = [self.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *dic = @{@"id":Id,@"name":_cTextField.text,@"price":_priceTextField.text,@"photo":imageDataStr};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoManagerViewControllerReloadData" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"上传失败"];
    }];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        if (ScreenWidth == 320) {
            _viewForText.frame = CGRectMake(0, ScreenHeight-90-10-200-20, ScreenWidth, 90);
        }else if (ScreenWidth == 375){
            _viewForText.frame = CGRectMake(0, ScreenHeight-90-10-253-20, ScreenWidth, 90);
        }else{
            _viewForText.frame = CGRectMake(0, ScreenHeight-90-10-271-20, ScreenWidth, 90);
        }
    }];
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        _viewForText.frame = CGRectMake(0, CGRectGetMaxY(_cameraImageView.frame)+10, ScreenWidth, 90);
    }];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_cTextField resignFirstResponder];
    [_priceTextField resignFirstResponder];
}


- (void) initCameraImageView{
    
    self.cameraImageView = [[UIImageView alloc] init];
    _cameraImageView.frame = CGRectMake(0, 64, ScreenWidth, ScreenWidth*3/4);
    _cameraImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _cameraImageView.image = [UIImage imageNamed:@"postImageHolder"];
    
    [self.view addSubview:_cameraImageView];
    
    _cameraImageView.userInteractionEnabled = YES;//此页面暂不支持选取图片
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhoto:)];
    [_cameraImageView addGestureRecognizer:tap];
}

- (void) choosePhoto:(UITapGestureRecognizer *)tap{
    UIActionSheet *sheet;
    
    sheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册中选择", nil];
    sheet.delegate = self;
    [sheet showInView:self.view];
}

//实现ActionSheet delegate事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType=0;
    if(buttonIndex==0)
    {
        return;
    }
    else
    {
        sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    //跳转到相机或者相册页面
    UIImagePickerController*imagePickerController=[[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;//不允许图片进行编辑
    imagePickerController.sourceType=sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

//实现ImagePicker delegate事件
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:^{
        
    }];
    //    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];//编辑后的图片
    UIImage *origanalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [self fixOrientation:origanalImage];
    
    NSData *data = UIImagePNGRepresentation(image);
    self.imageData = data;
    _cameraImageView.image = [UIImage imageWithData:self.imageData];
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


- (void) setNav{
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.titleLabel.text = @"编辑菜单";
    _navView.titleLabel.textColor = [UIColor blackColor];
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
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
