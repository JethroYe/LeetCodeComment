//
//  SortLearn.h
//  MVVMTest
//
//  Created by JethroiMac on 2019/12/29.
//  Copyright © 2019 JethroiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SortLearn : NSObject


/// 快排
/// @param array 待排序数组
/// @param start 起始指针
/// @param trail 结束指针
+ (void)quickSortArr:(NSMutableArray *)array start:(NSInteger)start trail:(NSInteger)trail;


/// 堆排序算法
/// @param array array
+ (void)heapSort:(NSMutableArray *)array;

@end

NS_ASSUME_NONNULL_END
