//
//  lustDownloader.h
//  iEileen_TheYoungMarshal
//
//  Created by PointerTan on 15/2/3.
//  Copyright (c) 2015年 PointerTan. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *lustDownloadIdentifer = @"io.yuedu.iEileen.AlbumDownload";

@interface lustDownloader : NSObject<NSURLSessionDownloadDelegate>
@property (strong, nonatomic) NSURLSessionDownloadTask *backgroundTask;
@property (strong, nonatomic, readonly) NSURLSession *backgroundSession;
@property double currentProgress;
@property (copy) void (^backgroundURLSessionCompletionHandler)();
@property BOOL started;
@property BOOL successed;
@property BOOL failed;

+ (id)sharedInstance;
- (void)dealDownloaded;
- (void)cancelDownload;
- (void)startBackground;
- (BOOL)lustDownloaded;
@end
