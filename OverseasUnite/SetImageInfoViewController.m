//
//  SetImageInfoViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/5/26.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "SetImageInfoViewController.h"
#import "LoginNav.h"
#import "PostImageRequest.h"
#import "UploadFile.h"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface SetImageInfoViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) UIImageView *cameraImageView;
@property (nonatomic,strong) UIView *viewForText;

@property (nonatomic,strong) UILabel *cNameLabel;
@property (nonatomic,strong) UILabel *eNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UITextField *cTextField;
@property (nonatomic,strong) UITextField *eTextField;
@property (nonatomic,strong) UITextField *priceTextField;
@property (nonatomic,strong) UIButton *saveBtn;
@end

@implementation SetImageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    self.params = [NSMutableDictionary dictionary];
    
    [self initCameraImageView];//获取图片
    
    [self initTextFiledView];
    
    [self initSaveBtn];
}

- (void) initSaveBtn{
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(25, CGRectGetMaxY(_viewForText.frame)+20, ScreenWidth-50, 40);
    [_saveBtn setTitle:@"保  存" forState:UIControlStateNormal];
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
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    NSString* encodeResult = [self.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [dic setObject:self.imageData forKey:@"file"];
    
    NSString *urlString = @"http://bm.gochinatv.com/accelarator-bm-api/ba_v1/uploadImage";
    
    
    if (self.imageData.length >1024*1024) {//10M
        UIImage *image = [UIImage imageWithData:self.imageData];
        self.imageData = UIImageJPEGRepresentation(image, 0.5);
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:self.imageData name:@"file" fileName:@"my.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *path = dic[@"message"];
        [self postParams:path];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 图片处理
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void) editPostParams{//编辑借口参数
    /*
     http://192.168.3.191:8080/accelarator-bm-api/ba_v1/update?
     deviceId=100&
     businessId=100&
     placeId=100&
     name=测试&
     price=200.0&
     imagePath=http://img8.gochinatv.com/common/20160331/9935c325a7b0b8b070c959300d4d4129_original.jpg&
     sort=1&
     ename=efengzw&
     refreshTime=50&
     id=20      //编辑的时候没有id字段
     */
}

- (void) postParams:(NSString *)url{//新增
//    http://192.168.3.191:8080/accelarator-bm-api/ba_v1/save?
//    deviceId=100&
//    businessId=100&
//    placeId=100&
//    name=fengzw&
//    price=100.0&
//    imagePath=http://img7.gochinatv.com/common/20160401/20b660822b0cf16ca26f0530a3634728_original.jpg&
//    sort=1&
//    ename=efengzw&
//    refreshTime=10&
//    description=description       //添加的借口有此字段值，编辑的时候没有这个字段
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];//bussinessID
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.deviceId forKey:@"deviceId"];
    [dic setObject:userId forKey:@"bussinessId"];
    [dic setObject:self.placeId forKey:@"placeId"];
    [dic setObject:self.cTextField.text forKey:@"name"];
    [dic setObject:url forKey:@"imagePath"];
    [dic setObject:@"1" forKey:@"sort"];
    [dic setObject:_eTextField.text forKey:@"ename"];
    [dic setObject:_priceTextField.text forKey:@"price"];
    [dic setObject:@"10" forKey:@"refreshTime"];
    
    PostImageRequest *request = [[PostImageRequest alloc] init];
    
    if (![self.method isEqualToString:@"edit"]) {//新增
        [dic setObject:@"description" forKey:@"description"];
        request.isAdd = YES;
    }else{//编辑
        [dic setObject:_editId forKey:@"id"];
        request.isAdd = NO;
    }
    
    [request requestData:dic andBlock:^(PostImageRequest *responseData) {
        
        if ([responseData.isSuccess isEqualToString:@"1"]) {
            
            NSDictionary *dic = @{@"deviceIdToReload":self.deviceId};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deviceIdToReload" object:nil userInfo:dic];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self showFailTextField];
        }
        
        [SVProgressHUD dismiss];
        _saveBtn.userInteractionEnabled = YES;
        
    } andFailureBlock:^(PostImageRequest *responseData) {
        _saveBtn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
        [self showFailTextField];
    }];
}

- (void) showFailTextField{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败，请重新提交" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

//上传图片
- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params{
    
    // 文件上传
    NSURL *url = [NSURL URLWithString:@"http://bm.gochinatv.com/accelarator-bm-api/ba_v1/uploadImage"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    /***************文件参数***************/
    // 参数开始的标志
    [body appendData:YYEncode(@"--YY\r\n")];
    
    // name : 指定参数名(必须跟服务器端保持一致)
    // file : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; file=\"%@\"\r\n", name, filename];
    [body appendData:YYEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    [body appendData:YYEncode(type)];
    
    [body appendData:YYEncode(@"\r\n")];
    [body appendData:data];
    [body appendData:YYEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [body appendData:YYEncode(@"--YY\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [body appendData:YYEncode(disposition)];
        
        [body appendData:YYEncode(@"\r\n")];
        [body appendData:YYEncode(obj)];
        [body appendData:YYEncode(@"\r\n")];
        
    }];
    
    /***************参数结束***************/
    // YY--\r\n
    [body appendData:YYEncode(@"--YY--\r\n")];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", dict);
        } else {
            NSLog(@"上传失败");
        }
    }];
}

- (void) initTextFiledView{
    
    self.viewForText = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cameraImageView.frame)+10, ScreenWidth, 90)];
    _viewForText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_viewForText];
    
    self.cNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 20)];
    _cNameLabel.text = @"中文名：";
    _cNameLabel.textColor = [UIColor blackColor];
    _cNameLabel.textAlignment = NSTextAlignmentLeft;
    _cNameLabel.font = [UIFont systemFontOfSize:16.0];
    
    self.eNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cNameLabel.frame.origin.x, CGRectGetMaxY(_cNameLabel.frame)+5, _cNameLabel.frame.size.width, 20)];
    _eNameLabel.textAlignment = NSTextAlignmentLeft;
    _eNameLabel.textColor = [UIColor blackColor];
    _eNameLabel.text = @"英文名：";
    _eNameLabel.font = [UIFont systemFontOfSize:16.0];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cNameLabel.frame.origin.x, CGRectGetMaxY(_eNameLabel.frame)+5, _cNameLabel.frame.size.width, 20)];
    _priceLabel.text = @"价 格：";
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
    cNameLine.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    [_viewForText addSubview:_cTextField];
    [_viewForText addSubview:cNameLine];
    
    
    _eTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_eNameLabel.frame)+5, _eNameLabel.frame.origin.y, ScreenWidth-_eNameLabel.frame.size.width-30, _eNameLabel.frame.size.height-1)];
    _eTextField.delegate = self;
    _eTextField.textAlignment = NSTextAlignmentLeft;
    _eTextField.textColor = [UIColor blackColor];
    _eTextField.placeholder = @"输入菜品英文名";
    _eTextField.font = [UIFont systemFontOfSize:14.0];
    UIView *eNameLine = [[UIView alloc] initWithFrame:CGRectMake(_eTextField.frame.origin.x, CGRectGetMaxY(_eTextField.frame), _eTextField.frame.size.width, 1)];
    eNameLine.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    [_viewForText addSubview:_eTextField];
    [_viewForText addSubview:eNameLine];
    
    
    _priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame)+5, _priceLabel.frame.origin.y, ScreenWidth-_priceLabel.frame.size.width-30, _priceLabel.frame.size.height-1)];
    _priceTextField.delegate = self;
    _priceTextField.textAlignment = NSTextAlignmentLeft;
    _priceTextField.textColor = [UIColor blackColor];
    _priceTextField.placeholder = @"请注意输入货币单位";
    _priceTextField.font = [UIFont systemFontOfSize:14.0];
    UIView *priceLine = [[UIView alloc] initWithFrame:CGRectMake(_priceTextField.frame.origin.x, CGRectGetMaxY(_priceTextField.frame), _priceTextField.frame.size.width, 1)];
    priceLine.backgroundColor = UIColorFromRGB(0xEEEEEE, 1.0);
    [_viewForText addSubview:_priceTextField];
    [_viewForText addSubview:priceLine];
    
    
    [_viewForText addSubview:_cNameLabel];
    [_viewForText addSubview:_eNameLabel];
    [_viewForText addSubview:_priceLabel];
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
    [_eTextField resignFirstResponder];
    [_priceTextField resignFirstResponder];
}

- (void) setNav{
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.titleLabel.text = @"设置图片属性";
    _navView.titleLabel.textColor = [UIColor blackColor];
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
}

- (void) initCameraImageView{
    
    self.cameraImageView = [[UIImageView alloc] init];
    _cameraImageView.frame = CGRectMake(0, 64, ScreenWidth, ScreenWidth*3/4);
    _cameraImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    if ([self.method isEqualToString:@"edit"]) {
        [_cameraImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"postImageHolder"]];
        self.imageData = UIImagePNGRepresentation(_cameraImageView.image);
    }
    else{
        _cameraImageView.image = [UIImage imageNamed:@"postImageHolder"];
    }
    
    [self.view addSubview:_cameraImageView];
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    // 设定动画选项
//    animation.duration = 0.3; // 持续时间
//    animation.repeatCount = 1; // 重复次数
//    animation.removedOnCompletion=NO;
//    animation.fillMode=kCAFillModeForwards;
//    // 设定旋转角度
//    animation.fromValue = [NSNumber numberWithFloat:0.0f];
//    animation.toValue = [NSNumber numberWithFloat: M_PI/2];
//    // 添加动画
//    [self.cameraImageView.layer addAnimation:animation forKey:@"rotate-layer"];
    
    _cameraImageView.userInteractionEnabled = YES;//此页面暂不支持选取图片
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhoto:)];
    [_cameraImageView addGestureRecognizer:tap];
}

- (void) choosePhoto:(UITapGestureRecognizer *)tap{
    UIActionSheet *sheet;
//    //判断是否支持相机
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        sheet=[[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle: @"取消" otherButtonTitles:@"拍照",@"从相册中选择", nil];
//    }
//    else
//    {
//        sheet=[[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册中选择", nil];
//    }
    sheet=[[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册中选择", nil];
    sheet.delegate=self;
    [sheet showInView:self.view];
}

//实现ActionSheet delegate事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType=0;
//    //判断是否支持相机
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        switch (buttonIndex) {
//            case 0:
//                return;//取消
//                break;
//            case 1:
//                //相机
//                sourceType=UIImagePickerControllerSourceTypeCamera;
//                break;
//            case 2:
//                //相册
//                sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//                break;
//                
//        }
//    }
//    else{
//        if(buttonIndex==0)
//        {
//            return;
//        }
//        else
//        {
//            sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        }
//    }
    
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
