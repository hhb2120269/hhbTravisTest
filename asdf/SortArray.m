//
//  SortArray.m
//  asdf
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SortArray.h"

@implementation SortArray
/**
 *  sortArray
 */
-(NSArray *)sortArrayWithArray:(NSArray*)array{
    array = [array sortedArrayUsingFunction:intSort context:nil];
    return array;
}
/**
 *  intSort
 */
NSInteger intSort(id num1, id num2, void *context)
{
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}
@end
