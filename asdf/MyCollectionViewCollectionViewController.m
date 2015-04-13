//
//  MyCollectionViewCollectionViewController.m
//  asdf
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyCollectionViewCollectionViewController.h"
#import "CollectionViewCell.h"
#import "CollectionViewLayout.h"
#import "CollectionViewFlowLayout.h"
#import "AFNetworking.h"

@interface MyCollectionViewCollectionViewController ()

@end

@implementation MyCollectionViewCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //方法一：通过代码实现
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[] forSupplementaryViewOfKind:<#(NSString *)#> withReuseIdentifier:@"SupplementaryView"]
    //方法二：通过Xib实现
//    UINib *cellNib = [UINib nibWithNibName:@"collectionViewCell" bundle:nil];
//    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
    
    CollectionViewLayout *layout = [[CollectionViewLayout alloc]init];
    CollectionViewFlowLayout *flowLayout = [[CollectionViewFlowLayout alloc]init];
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    [self.collectionView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected section:%ld, row:%ld,item:%ld",(long)indexPath.section,(long)indexPath.row,(long)indexPath.item);
//    [self test1];
}
//-(void)test1{
//    __weak TYMAPPController *wself = self;
//    // 2.发送请求
//    NSDictionary *getDic=@{
//                           @"uid":@"iEileen",
//                           @"action":@"get_user_config",
//                           @"data":@{
//                                   @"type":@"iElieen:general-config",
//                                   @"tag":@"moreApp"
//                                   }
//                           };
//    AFJSONRequestSerializer *request=[[AFJSONRequestSerializer alloc]init];
//    [request setAuthorizationHeaderFieldWithUsername:@"loser" password:@"england"];
//    //3.
//    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.requestSerializer=request;
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval=15;
//    [manager POST:@"http://www.yueduapi.com:2000/actions" parameters:getDic success:^(AFHTTPRequestOperation *operation, id responseObject){
//        //responseObject是个字典
//        wself.apps = nil;
//        wself.apps = responseObject[@"config"][@"apps"];
//        
//        HBLog(@"self.apps:%@",self.apps);
//        
//        // 刷新表格
////        [self.tableView reloadData];
//        
//        //本地化数据
////        [self resetUserDefault];
//        
//        // 让刷新控件停止显示刷新状态
////        [self.header endRefreshing];
//        
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
////        [self.header endRefreshing];
////        [SVProgressHUD showErrorWithStatus:@"网络不可用"];
//    }];
//}
//#pragma HB_Mark - load data mode!!
//-(void)loadMoreData{
//    __weak TYMAPPController *wself = self;
//    // 2.发送请求
//    NSDictionary *getDic=@{
//                           @"uid":@"iEileen",
//                           @"action":@"get_user_config",
//                           @"data":@{
//                                   @"type":@"iElieen:general-config",
//                                   @"tag":@"moreApp"
//                                   }
//                           };
//    AFJSONRequestSerializer *request=[[AFJSONRequestSerializer alloc]init];
//    [request setAuthorizationHeaderFieldWithUsername:@"loser" password:@"england"];
//    //3.
//    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.requestSerializer=request;
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval=15;
//    [manager POST:@"http://www.yueduapi.com:2000/actions" parameters:getDic success:^(AFHTTPRequestOperation *operation, id responseObject){
//        //responseObject是个字典
//        wself.apps = nil;
//        wself.apps = responseObject[@"config"][@"apps"];
//        
//        HBLog(@"self.apps:%@",self.apps);
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        //本地化数据
//        [self resetUserDefault];
//        
//        // 让刷新控件停止显示刷新状态
//        [self.header endRefreshing];
//        
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        [self.header endRefreshing];
//        [SVProgressHUD showErrorWithStatus:@"网络不可用"];
//    }];
//    
//    
//    
//}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
