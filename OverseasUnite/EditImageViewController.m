//
//  EditImageViewController.m
//  OverseasUnite
//
//  Created by mobile_007 on 16/6/7.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "EditImageViewController.h"
#import "SetImageInfoViewController.h"
#import "LoginNav.h"
#define ImageMaxHeight ([UIScreen mainScreen].bounds.size.height - 64 - 49 - 60)

@interface EditImageViewController ()<UITextViewDelegate>
@property (nonatomic,strong) LoginNav *navView;
@property (nonatomic,strong) UIImageView *editFrame;//编辑图片的框的大小
@property (nonatomic,strong) UIImageView *bgImageView;//被编辑的图片
@property (nonatomic,strong) UIButton *editTextBtn;//控制文字是否显示的btn
@property (nonatomic,strong) UITextView *textView;//输入的文字

@property (nonatomic,strong) UIPanGestureRecognizer *textViewPan;
@property (nonatomic,strong) UIPanGestureRecognizer *editFramePan;
//@property (nonatomic,strong) UIView *textFieldView;//用于盛放textfield的

@property (nonatomic) CGFloat scale;
@property (nonatomic) BOOL isMove;
@property (nonatomic) CGFloat top;
@end

@implementation EditImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initImageView];
    
    [self initTextEditView];//底部的40高度的view
    
    [self setNav];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void) initTextEditView{
    self.editTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editTextBtn.frame = CGRectMake(0, ScreenHeight-49-60, ScreenWidth, 40);
    [_editTextBtn setTitle:@"编辑" forState:UIControlStateNormal];
    _editTextBtn.backgroundColor = [UIColor cyanColor];
    [_editTextBtn addTarget:self action:@selector(editTextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editTextBtn];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];//原始大小，用户可以自己调整
    _textView.backgroundColor = [UIColor clearColor];
    _textView.hidden = YES;
    _textView.textColor = [UIColor redColor];
    _textView.font = [UIFont systemFontOfSize:16.0];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.delegate = self;
    [self.editFrame addSubview:_textView];
    
    self.textViewPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(editTextView:)];//拖动手势
    [_textView addGestureRecognizer:self.textViewPan];
    
}

#pragma mark 用户输入文字时高度改变
- (void) textChanged:(UITextView *)textView{
    _textView.frame = CGRectMake(_textView.frame.origin.x, _textView.frame.origin.y, _textView.frame.size.width, _textView.contentSize.height);
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    [_editFrame removeGestureRecognizer:_editFramePan];
    [_textView removeGestureRecognizer:_textViewPan];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (ScreenWidth == 320) {
            
            if (ScreenHeight - CGRectGetMaxY(_editFrame.frame) < (253+15)) {
                self.isMove = YES;
                self.top = 253+15 - (ScreenHeight - CGRectGetMaxY(_editFrame.frame));
                
                _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x, _bgImageView.frame.origin.y-_top, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
                _editFrame.frame = CGRectMake(_editFrame.frame.origin.x, _editFrame.frame.origin.y-_top, _editFrame.frame.size.width, _editFrame.frame.size.height);
            }
        }else if (ScreenWidth == 375){
            
            if (ScreenHeight - CGRectGetMaxY(_editFrame.frame) < (258+20)) {
                self.isMove = YES;
                self.top = 258+20 - (ScreenHeight - CGRectGetMaxY(_editFrame.frame));
                
                _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x, _bgImageView.frame.origin.y-_top, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
                _editFrame.frame = CGRectMake(_editFrame.frame.origin.x, _editFrame.frame.origin.y-_top, _editFrame.frame.size.width, _editFrame.frame.size.height);
            }
        }else{
            
            if (ScreenHeight - CGRectGetMaxY(_editFrame.frame) < (271+25)) {
                self.isMove = YES;
                _top = 271+25 - (ScreenHeight - CGRectGetMaxY(_editFrame.frame));
                
                _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x, _bgImageView.frame.origin.y-_top, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
                _editFrame.frame = CGRectMake(_editFrame.frame.origin.x, _editFrame.frame.origin.y-_top, _editFrame.frame.size.width, _editFrame.frame.size.height);
            }
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    [_editFrame addGestureRecognizer:_editFramePan];
    [_textView addGestureRecognizer:_textViewPan];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (ScreenWidth == 320) {
            
            if (self.isMove) {
                
                _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x, _bgImageView.frame.origin.y+_top, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
                _editFrame.frame = CGRectMake(_editFrame.frame.origin.x, _editFrame.frame.origin.y+_top, _editFrame.frame.size.width, _editFrame.frame.size.height);
            }
        }else if (ScreenWidth == 375){
            
            if (self.isMove) {
                
                _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x, _bgImageView.frame.origin.y+_top, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
                _editFrame.frame = CGRectMake(_editFrame.frame.origin.x, _editFrame.frame.origin.y+_top, _editFrame.frame.size.width, _editFrame.frame.size.height);
            }
        }else{
            
            if (self.isMove) {
                
                _bgImageView.frame = CGRectMake(_bgImageView.frame.origin.x, _bgImageView.frame.origin.y+_top, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
                _editFrame.frame = CGRectMake(_editFrame.frame.origin.x, _editFrame.frame.origin.y+_top, _editFrame.frame.size.width, _editFrame.frame.size.height);
            }
        }
    } completion:^(BOOL finished) {
        self.isMove = NO;
    }];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}


- (void) editTextBtnClick:(UIButton *)btn{
    self.textView.hidden = !self.textView.hidden;
}

//初始化图片和裁剪区域
- (void) initImageView{
    UIImage *img = self.originalImg;
    CGFloat with,height;
    
    if (img.size.width>ScreenWidth && img.size.height<ImageMaxHeight) {
        _scale = img.size.width/ScreenWidth;
        with = ScreenWidth;
        height = img.size.height/_scale;
    }
    else if (img.size.width>ScreenWidth && img.size.height>ImageMaxHeight){
        
        _scale = img.size.height/ImageMaxHeight;
        height = ImageMaxHeight;
        with = img.size.width/_scale;
        
        if (with > ScreenWidth) {
            
            CGFloat temp = with/ScreenWidth;
            with = ScreenWidth;
            height = height/temp;
            
            _scale = _scale * temp;
        }
        
        NSLog(@"横宽都很大:with--->:%f,height:%f,",with,height);
    }
    else if (img.size.width < ScreenWidth && img.size.height > ImageMaxHeight){
        _scale = ImageMaxHeight/img.size.height;
        height = ImageMaxHeight;
        with = img.size.width/_scale;
    }
    else{
        with = img.size.width;
        height = img.size.height;
    }
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-with)/2, 64, with, height)];
    _bgImageView.image = img;
    _bgImageView.backgroundColor = [UIColor redColor];
    
    self.editFrame = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-with)/2, 64, with, with*3/4)];//编辑框宽高比4：3
    _editFrame.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:1.0 alpha:0.2];
    _editFrame.userInteractionEnabled = YES;
    self.editFramePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(chooseFrameForImage:)];//拖动手势
    
    
    NSString *str = [NSString stringWithFormat:@"%.6f",self.originalImg.size.width/self.originalImg.size.height];
    
    if ([str isEqualToString:@"1.333333"]) {//说明是横屏拍照
        _editFrame.backgroundColor = [UIColor clearColor];
    }else{
        [_editFrame addGestureRecognizer:self.editFramePan];
    }
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:_editFrame];
}

- (void) editTextView:(UIPanGestureRecognizer *)pan{
    
    CGPoint  currentPoint;
    currentPoint.x = _textView.frame.origin.x;
    currentPoint.y = _textView.frame.origin.y;
    //再获取当前拖拽的偏移量
    CGPoint offsetPoint = [pan translationInView:self.view];
    //计算拖拽过后实际的点坐标
    currentPoint.x += offsetPoint.x;
    currentPoint.y += offsetPoint.y;
    
    if (currentPoint.x < 0 ) {
        currentPoint.x = 0;
    }else if ((currentPoint.x + _textView.frame.size.width) > ScreenWidth){
        currentPoint.x = ScreenWidth-_textView.frame.size.width;
    }
    
    if ((currentPoint.y + _textView.frame.size.height) > _editFrame.frame.size.height) {
        currentPoint.y = _editFrame.frame.size.height - _textView.frame.size.height;
    }else if (currentPoint.y < 0){
        currentPoint.y = 0;
    }
    
    //重新将计算后的点,赋给imageView
    _textView.frame = CGRectMake(currentPoint.x, currentPoint.y, _textView.frame.size.width, _textView.frame.size.height);
    
    //这个也得置0复位
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
}

//改变编辑的图片的区域
- (void) chooseFrameForImage:(UIPanGestureRecognizer *)pan{
    
    CGFloat currentY = _editFrame.frame.origin.y;
    
    CGPoint offset = [pan translationInView:self.view];
    
    currentY += offset.y;
    
    if ((currentY + _editFrame.frame.size.height) > ImageMaxHeight+64) {
        _editFrame.frame = CGRectMake((ScreenWidth-_editFrame.frame.size.width)/2, ScreenHeight-49-60-_editFrame.frame.size.height, _editFrame.frame.size.width, _editFrame.frame.size.height);
//        NSLog(@"第1种");
    }else if (currentY < 64){
        _editFrame.frame = CGRectMake((ScreenWidth-_editFrame.frame.size.width)/2, 64, _editFrame.frame.size.width, _editFrame.frame.size.height);
//        NSLog(@"%f",currentY);
//        NSLog(@"第2种");
    }
    else{
        _editFrame.frame = CGRectMake((ScreenWidth-_editFrame.frame.size.width)/2, currentY, _editFrame.frame.size.width, _editFrame.frame.size.height);
//        NSLog(@"%f",currentY);
//        NSLog(@"第3种");
    }
    
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (void) setNav{
    self.navView = [[LoginNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    _navView.titleLabel.text = @"图片编辑";
    _navView.titleLabel.textColor = [UIColor redColor];
    
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [_navView addSubview:lineView];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(ScreenWidth-30-15, 20+(44-20)/2, 30, 20);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:saveBtn];
    [self.view addSubview:_navView];
}

//保存用户编辑后的图片
- (void) saveBtnClick:(UIButton *)btn{
    
    NSData *data;
    UIImage *imageAndText;
    UIImage *cutImage;
    
    cutImage =[self cutImage:_bgImageView.image withRect:CGRectMake(0, _scale*(_editFrame.frame.origin.y-64), _editFrame.frame.size.width*_scale, _editFrame.frame.size.height*_scale)];//截图
    
    if (_textView.hidden) {//没有文字
        data = UIImagePNGRepresentation(cutImage);
    }else{//有文字
        imageAndText = [self addText:cutImage text:_textView.text withRect:CGRectMake(_textView.frame.origin.x*_scale+5*_scale, _textView.frame.origin.y*_scale+8*_scale, _textView.frame.size.width*_scale, _textView.frame.size.height*_scale) ];//rect是相对于图片内部而言的,给图片加文字
        data = UIImagePNGRepresentation(imageAndText);
    }
    
    SetImageInfoViewController *vc = [[SetImageInfoViewController alloc] init];
    
    //判断是否为新增的
    if ([self.method isEqualToString:@"add"]) {
        vc.imageData = data;
        vc.placeId = self.placeId;
        vc.deviceId = self.deviceId;
        vc.method = @"add";
        
        [self.navigationController pushViewController:vc animated:YES];
        [self removeFromParentViewController];
    }else{
        vc.imageData = data;
        vc.placeId = self.placeId;
        vc.deviceId = self.deviceId;
        vc.method = @"edit";
        vc.editId = self.editId;
        [self.navigationController pushViewController:vc animated:YES];
        [self removeFromParentViewController];
    }
}



//截图图片
- (UIImage *)cutImage:(UIImage *)image withRect:(CGRect )rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage * img = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    return img;
}

//加文字水印
- (UIImage *) addText:(UIImage *)img text:(NSString *)mark withRect:(CGRect)rect
{
    int w = img.size.width;
    int h = img.size.height;
    
    UIGraphicsBeginImageContext(img.size);
    [[UIColor redColor] set];
    [img drawInRect:CGRectMake(0, 0, w, h)];
    
    if([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:_scale*16.0f], NSFontAttributeName,[UIColor redColor] ,NSForegroundColorAttributeName,nil];
        [mark drawInRect:rect withAttributes:dic];
    }
    else
    {
        //该方法在7.0及其以后都废弃了
        [mark drawInRect:rect withFont:[UIFont systemFontOfSize:16]];
    }
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
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
