//
//  testViewController_1.m
//  asdf
//
//  Created by apple on 15/4/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "testViewController_1.h"
#include <sys/param.h>
#include <sys/mount.h>

@interface testViewController_1 ()
- (IBAction)testBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

@implementation testViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)testBtn:(id)sender {
//    NSLog(@"%@",[self freeDiskSpaceInBytes]);
    self.lable.text = [self freeDiskSpaceInBytes];
}

/**
 *  #include <sys/param.h>
 *  #include <sys/mount.h>
 */
-(NSString *) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return [NSString stringWithFormat:@"手机剩余存储空间为：%qi MB" ,freespace/1024/1024];
}
@end
