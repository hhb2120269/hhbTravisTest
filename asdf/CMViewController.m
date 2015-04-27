//
//  CMViewController.m
//  asdf
//
//  Created by apple on 15/4/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CMViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface CMViewController ()

@end

@implementation CMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(IBAction)stop:(id)sender{
    
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    //Adding notifier for orientation changes
//    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
    
    NSArray *array = [NSArray arrayWithObjects:
                      @"https://api.douban.com/v2/book/isbn/9787229030933",
                      @"https://api.douban.com/v2/book/isbn/9787108023803",
                      @"https://api.douban.com/v2/book/isbn/9787549529322",
                      @"https://api.douban.com/v2/book/isbn/9787539951058",
                      @"https://api.douban.com/v2/book/isbn/9787508646671",
                      @"https://api.douban.com/v2/book/isbn/9787508646657",
                      @"https://api.douban.com/v2/book/isbn/9787530209479", nil];
    
    int i = 0;
    for (NSString *str  in array) {
        NSURL *url = [NSURL URLWithString:str];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        
        i++;
    }
    

}
- (void)orientationChanged:(NSNotification *)notification{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    
    
    if(UIInterfaceOrientationIsPortrait(orientation)||
       
       UIInterfaceOrientationIsLandscape(orientation)){
        
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
