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
//    [self LocalPhoto];
//    [self testBase64];
    /*
    {
        "rating"        :{"max":10,"numRaters":1085,"average":"8.6","min":0},
        "subtitle"      :"理解UI设计准则","author":["Jeff Johnson"],
        "pubdate"       :"2011-9-1",
        "tags"          :[
                                {"count":1293,"name":"交互设计","title":"交互设计"},
                                {"count":895,"name":"设计","title":"设计"},
                                {"count":635,"name":"用户体验","title":"用户体验"},
                                {"count":426,"name":"认知心理","title":"认知心理"},
                                {"count":308,"name":"心理学","title":"心理学"},
                                {"count":194,"name":"UED","title":"UED"},
                                {"count":175,"name":"界面","title":"界面"},
                                {"count":145,"name":"交互","title":"交互"}
                        ],
        "origin_title"  :"Designing with the Mind in Mind: Simple Guide to Understanding User Interface Design Rules",
        "image"         :"http:\/\/img3.douban.com\/mpic\/s28035813.jpg",
        "binding"       :"平装",
        "translator"    :["张一宁"],
        "catalog"       :"第1 章　我们感知自己的期望　　 1\n经验影响感知　　1\n环境影响感知　　 4\n目标影响感知　　 5\n对设计意味着什么　　 7\n第2 章　为观察结构优化我们的视觉　　 9\n格式塔原理：接近性　　9\n格式塔原理：相似性　　11\n格式塔原理：连续性　　13\n格式塔原理：封闭性　　15\n格式塔原理：对称性　　15\n格式塔原理：主体\/ 背景　　17\n格式塔原理：共同命运　　19\n将格式塔原理综合起来　　20\n第3 章　我们寻找和使用视觉结构　　23\n结构提高了用户浏览长数字的能力　　25\n数据专用控件提供了更多的结构　　 27\n视觉层次让人专注于相关的信息　　 27\n第4 章　阅读不是自然的　　29\n我们的大脑是为语言而不是为阅读设计的　　 29\n阅读是特征驱动还是语境驱动　　30\n熟练阅读和不熟练阅读使用大脑的不同部位　　 33\n糟糕的信息设计会影响阅读　　34\n软件里要求的阅读很多都是不必要的　　41\n对真实用户的测试　　44\n第5 章　色觉是有限的　　45\n色觉是如何工作的　　 45\n视觉是为边缘反差而不是为亮度优化的　　47\n区别颜色的能力取决于颜色是如何呈现的　　 47\n色盲　　 49\n影响色彩区分能力的外部因素　　51\n使用色彩的准则　　52\n第6 章　我们的边界视力很糟糕　　55\n中央凹的分辨率与边界视野的分辨率比较　　 55\n边界视觉有什么用　　 58\n电脑用户界面中的例子　　 59\n让信息可见的常用方法　　61\n让用户注意到信息的重武器：请小心使用　　 62\n第7 章　我们的注意力有限，记忆力也不完美　　 67\n短期与长期记忆　　 67\n对记忆的一种现代观点　　 67\n短期记忆的特点　　 69\n短期记忆的特点对用户界面设计的影响　　72\n长期记忆的特点　　 76\n长期记忆的特点对用户界面设计的影响　　 77\n第8 章　对注意力、形状、思考以及行动的限制　　 81\n模式一：我们专注于目标而很少注意使用的工具　　 81\n模式二：我们使用外部帮助来记录正在做的事情　　 82\n模式三：我们跟着信息“气味”靠近目标　　 83\n模式四：我们偏好熟悉的路径　　85\n模式五：我们的思考周期：目标，执行，评估　　86\n模式六：完成任务的主要目标之后，我们经常忘记做收尾工作　　89\n第9 章　识别容易，回忆很难　　91\n认识容　　91\n回忆很难　　 93\n识别与回忆对用户界面设计的影响　　 94\n第10 章　从经验中学习与学后付诸实践容易，解决问题和计算很难　　99\n我们有三个大脑　　 99\n从经验中学习（通常）是容易的　　100\n操作已经学会的动作是容易的　　102\n解决问题和计算是困难的　　104\n在用户界面设计上的影响　　108\n前文中提到的问题的答案　　110\n第11 章　许多因素影响学习　　111\n当操作专注于任务、简单和一致时，我们学得更快　　 111\n当词汇专注于任务、熟悉和一致时，我们学得更快　　 119\n风险低的时候我们学得快　　 126\n小结　　 127\n第12 章　我们有时间要求　　 129\n响应度的定义　　 129\n人类大脑的许多时间常量　　 131\n时间常数的工程近似法：数量级　　 135\n为满足实时交互的设计　　 136\n达到高响应度交互系统的另外一些指导原则　　 139\n实现高响应度是重要的　　 145\n后记　　 147\n附录　著名的用户界面设计准则　　 149\n参考文献　　153",
        "pages"         :"156",
        "images"        :{
                                "small":"http:\/\/img3.douban.com\/spic\/s28035813.jpg",
                                "large":"http:\/\/img3.douban.com\/lpic\/s28035813.jpg",
                                "medium":"http:\/\/img3.douban.com\/mpic\/s28035813.jpg"
                        },
        "alt"           :"http:\/\/book.douban.com\/subject\/6792322\/",
        "id"            :"6792322",
        "publisher"     :"人民邮电出版社",
        "isbn10"        :"7115261415",
        "isbn13"        :"9787115261410",
        "title"         :"认知与设计",
        "url"           :"http:\/\/api.douban.com\/v2\/book\/6792322",
        "alt_title"     :"Designing with the Mind in Mind: Simple Guide to Understanding User Interface Design Rules",
        "author_intro"  :"Jeff Johnson 拥有耶鲁大学及斯坦福大学心理学学位。UI Wizards公司董事长兼首席顾问。，他是GUI设计的先驱，著有畅销书《GUI设计禁忌》。",
        "summary"       :"本书语言清晰明了，将设计准则与其核心的认知学和感知科学高度统一起来，使得设计准则更容易地在具体环境中得到应用。涵盖了交互计算机系统设计的方方面面，为交互系统设计提供了支持工程方法。不仅如此，这也是一本人类行为原理的入门书。",
        "series"        :{
                                "id":"5907",
                                "title":"图灵交互设计丛书"
                        },
        "price"         :"59.00元"
    }
    */
    AFJSONRequestSerializer *request=[[AFJSONRequestSerializer alloc]init];
    //    [request setAuthorizationHeaderFieldWithUsername:@"loser" password:@"england"];
    //3.
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer=request;
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval=15;
    [ manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSInteger i = 9787115261410;//TODO:.......
    
    [manager GET:[NSString stringWithFormat:@"%@%ld",GET_URL,i] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ISBNResult *result = [ISBNResult objectWithKeyValues:responseObject];
        NSLog(@"%@",result.title);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",error);
        
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
