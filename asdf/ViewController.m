//
//  ViewController.m
//  asdf
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "KYWaterWaveView.h"
#import "AFNetworking.h"
#import "ISBNResult.h"
#import "NSObject+MJKeyValue.h"
#import "SDWebImagePrefetcher.h"

#define GET_URL @"https://api.douban.com/v2/book/isbn/"

@interface ViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//@property (weak, nonatomic) IBOutlet KYWaterWaveView *waterViewXib;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;
@property(strong,nonatomic)UIView *subView;
@property(strong,nonatomic)UIImageView *imageView;
- (IBAction)testBtn:(id)sender;

@property(strong,nonatomic)UIPanGestureRecognizer *panGesture;

@property(strong,nonatomic)UIDynamicAnimator *dynamicAnimator;

@end

@implementation ViewController{
    KYWaterWaveView *waterView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _panGesture = nil;
//    // Do any additional setup after loading the view, typically from a nib.
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"相册_02_标注"]];
    _imageView.frame = CGRectMake(0, 0, 100,250 );
//    imageVIew.transform = CGAffineTransformMakeRotation(5 * M_PI / 180);
    [self imageView:_imageView addShadowWithFrame:_imageView.frame];
    
    _subView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    
    [_subView addSubview:_imageView];
    [self.view addSubview:_subView];
    
    _imageView.transform = CGAffineTransformMakeRotation(5 * M_PI / 180);
//    [view layer] setShadowPath:<#(CGPathRef)#>
    
    
    
    
    
    self.viewA.userInteractionEnabled = YES;
    self.viewB.userInteractionEnabled = YES;
    [self.viewA addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanA:)]];
    
    [self setMyScrollView];
    
    
    //    waterView = [[KYWaterWaveView alloc]initWithFrame:CGRectMake(0, 50, 50, 50)];
    //    [self.view addSubview:waterView];
    //    waterView.layer.cornerRadius  = waterView.frame.size.width / 2;
    //    waterView.waveSpeed = 6.0f;
    //    waterView.waveAmplitude = 3.0f;
    //    [waterView wave];
    
    //    self.waterViewXib.layer.cornerRadius = self.waterViewXib.frame.size.width / 2;
//    self.waterViewXib.waveSpeed = 6.0f;
//    self.waterViewXib.waveAmplitude = 6.0f;
//    [self.waterViewXib wave];
    
}
-(UIDynamicAnimator *)dynamicAnimator{
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}
/**
 *  setScroll:
 */
-(void)setMyScrollView{
    
    
    [_scrollView addSubview:_imageView];
    _scrollView.contentMode = UIViewContentModeBottom;
    _scrollView.scrollsToTop = NO;
    _scrollView.contentSize = _imageView.frame.size;
    UIView *dyn = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollView.frame.origin.y/2, _scrollView.frame.size.width, 3)];
    dyn.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:dyn];
   
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]init];
    [gravity addItem:self.testBtn];
//    [gravity addItem:dyn];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
    [collision addItem:self.testBtn];
    [collision addItem:dyn];
    [collision addBoundaryWithIdentifier:@"Boundary" fromPoint:CGPointMake(0, 140) toPoint:CGPointMake(320, 140)];
    
//    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //
    [self.dynamicAnimator addBehavior:gravity];
    [self.dynamicAnimator addBehavior:collision];
    
    for (UIPanGestureRecognizer *pan in self.scrollView.gestureRecognizers) {
        _panGesture = pan;
    }
}
-(void)testShadowOnView:(UIView *)view{
    
    [[view layer] setShadowOffset:CGSizeMake(0, 8)]; // 阴影的范围
    [[view layer] setShadowRadius:3];                // 阴影扩散的范围控制
    [[view layer] setShadowOpacity:0.2];               // 阴影透明度
    [[view layer] setShadowColor:[UIColor blackColor].CGColor]; // 阴影的颜色
}
#pragma mark UIImgeViewShadow
-(void)imageView:(UIImageView *)imageView addShadowWithFrame:(CGRect)frame
{
    imageView.layer.shadowColor=[UIColor blackColor].CGColor;
    imageView.layer.shadowOpacity=0.2;
    imageView.layer.shadowOffset=CGSizeMake(0, 8);
    imageView.layer.shadowRadius=3;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle=kCGLineJoinRound;
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(frame.size.width, frame.size.height)];
    [path addLineToPoint:CGPointMake(frame.size.width/2, frame.size.height-7)];
    [path addLineToPoint:CGPointMake(0, frame.size.height)];
    [path closePath];
    
    imageView.layer.shadowPath=path.CGPath;
    imageView.layer.shadowOpacity=0.2;
}

-(void)handlePanA:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.viewB];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"UIGestureRecognizerStateBegan");
            [self testA];
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"UIGestureRecognizerStateChanged (%f,%f)",point.x,point.y);
            
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"UIGestureRecognizerStateCancelled");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"UIGestureRecognizerStateEnded");
            [[self.view viewWithTag:110] removeFromSuperview];;
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"UIGestureRecognizerStateFailed");
            break;
            
        default:
            break;
    }
}
-(void)testA{
    UIView *view = [_imageView snapshotViewAfterScreenUpdates:YES];
    view.frame = [self.view convertRect:_imageView.frame fromView:_subView];
    [self imageView:view addShadowWithFrame:view.frame];
    
    view.tag = 110;
    [self.view addSubview:view];
//    view.transform = CGAffineTransformMakeRotation(5 * M_PI / 180);
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_panGesture) {
        NSLog(@"contentOffset(%f,%f) ",self.scrollView.contentOffset.x,self.scrollView.contentOffset.y);
    }
}
- (IBAction)testBtn:(id)sender {

    NSArray *array = [NSArray arrayWithObjects:@"http://dev.yuedu.io:21010/uploadfile/books/1429619514150_1.jpg",
                      @"http://dev.yuedu.io:21010/uploadfile/books/1429613628501_1.jpg",
                      @"http://dev.yuedu.io:21010/uploadfile/books/1429621495419_0.jpg",
                      @"http://dev.yuedu.io:21010/uploadfile/books/1429615321543_3.jpg",
                      @"http://dev.yuedu.io:21010/uploadfile/books/1429621412445_0.jpg",
                      @"http://dev.yuedu.io:21010/uploadfile/books/1429615321543_1.jpg",
                      @"http://dev.yuedu.io:21010/uploadfile/books/1429621412445_0.jpg", nil ];
    NSMutableArray *urls = [NSMutableArray array ];
    for (NSString *str in array) {
        [urls addObject:[NSURL URLWithString:str]];
    }
    
    SDWebImagePrefetcher *prefetcher = [SDWebImagePrefetcher sharedImagePrefetcher];
    [prefetcher prefetchURLs:urls progress:^(NSUInteger noOfFinishedUrls, NSUInteger noOfTotalUrls) {
        //
    } completed:^(NSUInteger noOfFinishedUrls, NSUInteger noOfSkippedUrls) {
        //
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        NSURL *testURL = [NSURL URLWithString:@"http://dev.yuedu.io:21010/uploadfile/books/1429619514150_1.jpg"];
        if ([manager cachedImageExistsForURL:testURL]) {
            NSLog(@"%@",[manager cacheKeyForURL:testURL]);
            UIImage *image = [manager.imageCache imageFromMemoryCacheForKey:@"http://dev.yuedu.io:21010/uploadfile/books/1429619514150_1.jpg"];
        }
    }];
    
}
-(void)testBase64{
    UIImage *image = [UIImage imageNamed:@"book2.jpg"];
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    //    NSString *base64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    NSString *base64 = [data base64Encoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    //    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
    //                                                                                         (CFStringRef)baseStr,
    //                                                                                         NULL,
    //                                                                                         CFSTR(":/?#[]@!$&’()*+,;="),
    //                                                                                         kCFStringEncodingUTF8);
    NSData *data2 = [base64 dataUsingEncoding:NSUTF8StringEncoding];
    
    UIImage *image2 = [UIImage imageWithData: data2];
    
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image2];
    [imageView setFrame:CGRectMake(0, 0, 70, 400)];
    [self.view addSubview:imageView];
}


//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
//    [picker release];
}

////当选择一张图片后进入这里
//-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//
//    //当选择的类型是图片
//
//    if ([type isEqualToString:@"public.image"])
//    {
//        //先把图片转成NSData
//        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        NSData *data;
//        if (UIImagePNGRepresentation(image) == nil)
//        {
//            data = UIImageJPEGRepresentation(image, 1.0);
//        }
//        else
//        {
//            data = UIImagePNGRepresentation(image);
//        }
//        //图片保存的路径
//        //这里将图片放在沙盒的documents文件夹中
//        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        //文件管理器
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
//        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
//        //得到选择后沙盒中图片的完整路径
//        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
//        //关闭相册界面
//        [picker dismissModalViewControllerAnimated:YES];
//        //创建一个选择后图片的小图标放在下方
//        //类似微薄选择图后的效果
//        UIImageView *smallimage = [[[UIImageView alloc] initWithFrame: CGRectMake(50, 120, 40, 40)] autorelease];
//        smallimage.image = image;
//
//        [self.view addSubview:smallimage];
//    }
//}
//
//
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//
//{
//    NSLog(@"您取消了选择图片");
//    [picker dismissModalViewControllerAnimated:YES];
//}
@end
