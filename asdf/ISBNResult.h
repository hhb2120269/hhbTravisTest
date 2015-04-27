//
//  ISBNResult.h
//  asdf
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISBNResult : NSObject
@property(strong,nonatomic)NSString *alt;
@property(strong,nonatomic)NSString *alt_title;
@property(strong,nonatomic)NSArray *author;
@property(strong,nonatomic)NSString *author_intro;
@property(strong,nonatomic)NSString *binding;
@property(strong,nonatomic)NSString *catalog;

//@property(assign,nonatomic)
@property(assign,nonatomic)NSInteger id;
@property(strong,nonatomic)NSString *image;
@property(strong,nonatomic)NSDictionary *images;//TODO:....
@property(assign,nonatomic)NSInteger isbn10;
@property(assign,nonatomic)NSInteger isbn13;
@property (strong, nonatomic) NSString *origin_title;
@property (assign , nonatomic)NSInteger pages;
@property (strong, nonatomic) NSString *title;

//@property (strong, nonatomic) NSString *<#objectName#>;
//
//@property (strong, nonatomic) NSString *<#objectName#>;
//
//@property (strong, nonatomic) NSString *<#objectName#>;


@end
