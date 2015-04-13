//
//  lustDownloader.m
//  iEileen_TheYoungMarshal
//
//  Created by PointerTan on 15/2/3.
//  Copyright (c) 2015年 PointerTan. All rights reserved.
//

#import "lustDownloader.h"
//#import "SVProgressHUD.h"
#import "ZipArchive.h"

//static NSString *downloadUrl = @"http://media.yueduapi.com/ieileen/Lust.zip";
//static NSString *namePath = @"/Lust.zip";
//static NSString *name = @"Lust.zip";

static NSString *downloadUrl = @"http://media.yueduapi.com/pack/iEileen/android/img_pack/gallery_v1.1.1.zip";
static NSString *namePath = @"/gallery_v1.1.1";
static NSString *name = @"gallery_v1.1.1";

@implementation lustDownloader
+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

- (NSURLSession *)backgroundSession
{
    static NSURLSession *backgroundSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:lustDownloadIdentifer];
        backgroundSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    });
    [backgroundSession getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        if (downloadTasks.count > 0) {
            self.started = YES;
        }
    }];
    return backgroundSession;
}

- (void)startBackground{
    NSString *url = downloadUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.backgroundTask = [self.backgroundSession downloadTaskWithRequest:request];
    // Start the download
    [self.backgroundTask resume];
    self.started = YES;
    self.failed = NO;
    self.successed = NO;
}

- (void)dealDownloaded{
    
}

- (BOOL)lustDownloaded{
    NSString *isDownloaded = [[NSUserDefaults standardUserDefaults] valueForKey:lustDownloadIdentifer];
    if (isDownloaded && [isDownloaded isEqualToString:@"YES"]) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)cancelDownload{
    [self.backgroundTask cancel];
    self.backgroundTask = nil;
    self.started = NO;
    self.successed = NO;
    self.failed = NO;
    self.currentProgress = 0.0;
}

#pragma mark - NSURLSessionDownloadDelegate methods

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    self.currentProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"下载完成");
    // We've successfully finished the download. Let's save the file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = URLs[0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = paths[0];
    NSString* destinationPathString = [documentPath stringByAppendingString:namePath];

    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:name];
    NSError *error;
    
    // Make sure we overwrite anything that's already there
    [fileManager removeItemAtURL:destinationPath error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    
    if (success)
    {
        //处理数据
        ZipArchive* zip = [[ZipArchive alloc] init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = paths[0];
        NSString* unZipTo = documentPath;
        if([zip UnzipOpenFile:destinationPathString]){
            BOOL result = [zip UnzipFileTo:unZipTo overWrite:YES];
            if(result == NO){
                //添加代码
                self.failed = YES;
            }
            else{
                self.successed = YES;
                [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:lustDownloadIdentifer];
                dispatch_async(dispatch_get_main_queue(), ^{
                });
            }
            [zip UnzipCloseFile];
        }
        else{
            self.failed = YES;
        }
        [fileManager removeItemAtURL:destinationPath error:NULL];
    }
    else
    {
        NSLog(@"Couldn't copy the downloaded file");
        self.failed = YES;
    }
    
    if (session == self.backgroundSession) {
        self.backgroundTask = nil;
        // Get hold of the app delegate
        if(self.backgroundURLSessionCompletionHandler) {
            // Need to copy the completion handler
            void (^handler)() = self.backgroundURLSessionCompletionHandler;
            self.backgroundURLSessionCompletionHandler = nil;
            handler();
        }
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        self.failed = YES;
        NSLog(@"完成但是有错误");
    }
    else{
        NSLog(@"完成无错误");
    }
    self.started = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
    });
}
@end
