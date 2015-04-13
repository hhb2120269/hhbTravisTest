//
//  ViewController_.m
//  asdf
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController_.h"
#import "lustDownloader.h"
#import "UIImageView+WebCache.h"
#import "SortArray.h"

@interface ViewController_ ()
- (IBAction)pause:(id)sender;
- (IBAction)button:(id)sender;
- (IBAction)testFile:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *testFile;

@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property(strong,nonatomic)NSTimer *downloadTimer;

@end

@implementation ViewController_

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array  =@[@"pic-mini-37",
                       @"pic-mini-39",
                       @"pic-mini-38",
                       @"pic-mini-40"];
//    SortArray *sort = [[SortArray alloc]init];
//    array = [sort sortArrayWithArray:array];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    array = [array sortedArrayUsingDescriptors:descriptors];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  检查文件的存在
 */
- (void)Check{
    lustDownloader *ldl = [lustDownloader sharedInstance];
    if ([ldl lustDownloaded]) {
//        self.button.enabled = YES;
    }
    else{
//        self.button.enabled=NO;
        if (ldl.started) {
            if (!ldl.successed) {
                self.progressView.hidden = NO;
                self.cancleBtn.hidden = NO;
                self.progressView.progress = ldl.currentProgress;
                if (self.downloadTimer) {
                    [self.downloadTimer invalidate];
                    self.downloadTimer = nil;
                }
                else{
                    self.downloadTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downloadFresh) userInfo:nil repeats:YES];
                }
            }
        }
        else{
            self.start.hidden = NO;
        }
    }
}

- (IBAction)button:(id)sender {
    [[lustDownloader sharedInstance] startBackground];
    if (self.downloadTimer) {
        [self.downloadTimer invalidate];
        self.downloadTimer = nil;
    }
    else{
        self.downloadTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downloadFresh) userInfo:nil repeats:YES];
    }
    self.progressView.progress = 0.0;
//    self.lustDownloadBt.hidden = YES;
    self.progressView.hidden = NO;
//    self.cancleBtn.hidden = NO;
}

- (IBAction)testFile:(id)sender {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    for (id file in array) {
        NSLog(@"%@\n",file);
    }
    NSString *documentPath = array[0];
    NSString* destinationPathString = [documentPath stringByAppendingString:@"/gallery/photo"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:destinationPathString]) {
        NSLog(@"yes file exist");
    }
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/1.png",destinationPathString] ofType:@".png"];
//    NSData *image = [NSData dataWithContentsOfFile:filePath];
//    
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:image]];
    
    
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/1.png",destinationPathString]];
    UIImageView *imageView = [[UIImageView alloc]init];
    UIImage *placehoder = [UIImage imageNamed:@"07_推荐应用副本"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://a1.qpic.cn/psb?/V114jH9k2CyoSP/Hse0Ojzyg3eAIczk3m8a3taD7nL6dZh835Sy80qfIdY!/b/dK1js3DqHgAA&bo=cASAAgAAAAAFANU!&rf=viewer_4"] placeholderImage:placehoder];
    [imageView setFrame:CGRectMake(0, 0, 200, 100)];
    [self.view addSubview:imageView];
    
    NSLog(@"---%02d",1);
    NSLog(@"%x",~0x1);
}


- (IBAction)pause:(id)sender {
    [[lustDownloader sharedInstance] cancelDownload];
//    self.lustDownloadBt.hidden = NO;
//    self.cancleBtn.hidden = YES;
    self.progressView.hidden = YES;
//    self.lust.enabled = NO;
    if (self.downloadTimer) {
        [self.downloadTimer invalidate];
        self.downloadTimer = nil;
    }
}


#pragma mark NSURLSession

//- (IBAction)lustDownloadAction:(id)sender {
//    [[lustDownloader sharedInstance] startBackground];
//    if (self.downloadTimer) {
//        [self.downloadTimer invalidate];
//        self.downloadTimer = nil;
//    }
//    else{
//        self.downloadTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lustDownloadFresh) userInfo:nil repeats:YES];
//    }
//    self.progressView.progress = 0.0;
//    self.lustDownloadBt.hidden = YES;
//    self.progressView.hidden = NO;
//    self.cancleBtn.hidden = NO;
//}

- (void)downloadFresh{
    lustDownloader * downloader = [lustDownloader sharedInstance];
    self.progressView.progress = downloader.currentProgress;
    if (downloader.successed) {
//        self.cancleBtn.hidden = YES;
        self.progressView.hidden = YES;
//        self.lust.enabled = YES;
        [self.downloadTimer invalidate];
        self.downloadTimer = nil;
    }
    else if (downloader.failed){
//        [SVProgressHUD showErrorWithStatus:@"下载失败，请重试"];
        self.progressView.progress = 0.0;
//        self.lustDownloadBt.hidden = NO;
        self.progressView.hidden = YES;
//        self.cancleBtn.hidden = YES;
        [self.downloadTimer invalidate];
        self.downloadTimer = nil;
    }
}

//- (IBAction)lustDownloadCancelAction:(id)sender {
//    [[lustDownloader sharedInstance] cancelDownload];
//    self.lustDownloadBt.hidden = NO;
//    self.cancleBtn.hidden = YES;
//    self.progressView.hidden = YES;
//    self.lust.enabled = NO;
//    if (self.lustDownloadTimer) {
//        [self.lustDownloadTimer invalidate];
//        self.lustDownloadTimer = nil;
//    }
//}

@end
