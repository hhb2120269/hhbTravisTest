//
//  CollectionViewCell.m
//  asdf
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (id)initWithFrame:(CGRect)frame//cell的frame被初始化时调用
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame:%@",[NSValue valueWithCGRect:frame]);
    }
    return self;
}
-(void)prepareForReuse{
    NSLog(@"prepareForReuse");
}

- (void)awakeFromNib {
    // Initialization code
    NSLog(@"awakeFromNib");
}
@end
