//
//  SortLearn.m
//  MVVMTest
//
//  Created by JethroiMac on 2019/12/29.
//  Copyright © 2019 JethroiMac. All rights reserved.
//

#import "SortLearn.h"



@implementation SortLearn


#pragma mark - 快排

/**
 快排伪代码
 
 void QuickSort(A,s,t){
 
    q = partion(A,s,t);
 
    if(s < t){
 
        QuickSort(A,s,q-1);
        QuickSort(A,q+1,t);
 
    }
 
 }
 
 //关键是partion，原址重排
 int partion(A,s,t){
 
    x = A[t];
    i = s - 1;
    for (j = s to r-1 ){
    
        if(A[j] <= x)
            i++;
            exchange(A[i],A[j]);
    }
    
    exchange(A[i+1],A[t])
    return i+1;
 }
 
 */

//C++版本快排
/*
void Swap(int &a,int &b){ if(a!=b){a^=b;b^=a;a^=b;} }  //如果两个数相等，就不执行位运算交换。因为如果两数相等，结果会是0

int Partition(int *A,int p,int r){
    int x, i;
    x=A[r];
    i=p-1;
    for(int j=p; j<=r-1; ++j){
        if(A[j]<=x) {
            Swap(A[++i], A[j]);
        }
    }
    Swap(A[++i],A[r]);
    return i;
}
 
void QuickSort(int *A,int p,int r){
    if(p<r){
        int q=Partition(A,p,r);
        QuickSort(A,p,q-1);
        QuickSort(A,q+1,r);
    }
}
*/

+ (void)quickSortArr:(NSMutableArray *)array start:(NSInteger)start trail:(NSInteger)trail{
    if(start < trail){
        NSInteger p = [SortLearn partionArray:array start:start trail:trail];
        [SortLearn quickSortArr:array start:start trail:p-1];
        [SortLearn quickSortArr:array start:p+1 trail:trail];
    }
    
}

+ (NSInteger)partionArray:(NSMutableArray *)array start:(NSInteger)start trail:(NSInteger)trail{
    NSInteger X = [array[trail] integerValue];
    NSInteger iIndex = start - 1;
    for (NSInteger jIndex = start; jIndex <= (trail - 1); jIndex ++)
    {
        if([array[jIndex] integerValue] <= X)
        {
            iIndex = iIndex+1;
            [array exchangeObjectAtIndex:iIndex withObjectAtIndex:jIndex];
        }
    }
    iIndex = iIndex + 1;
    [array exchangeObjectAtIndex:(iIndex) withObjectAtIndex:trail];
    
    return (iIndex);
}


#pragma mark - 堆排

/// 维持最大堆的性质
/// @param array 最大堆数组
/// @param itemIndex 一个下标
+ (void)maxHeapify:(NSMutableArray *)array AndIndex:(NSInteger)itemIndex AndLength:(NSInteger) len
{
    NSInteger left = 2*itemIndex + 1;
    NSInteger right = 2*itemIndex + 2;
    NSInteger largest = itemIndex;
 
    // 下面的 largest 只是为了找到最大的
    if(left < len && [array[left] integerValue] > [array[largest] integerValue]){
        largest = left;
    }
    if (right < len && [array[right] integerValue ] > [array[largest] integerValue]) {
        largest = right;
    }
    
    if (largest != itemIndex){
        [array exchangeObjectAtIndex:itemIndex withObjectAtIndex:largest];
        [SortLearn maxHeapify:array AndIndex:largest AndLength:len];
    }
}



/// 建堆
/// @param array 待建堆数组
/// @param len 数组长度
+ (void)buildMaxHeap:(NSMutableArray *)array AndLength:(NSInteger)len{
    //floor(len/2) -- 是最后一个非叶子节点
    for(NSInteger index = floor(len/2); index >= 0; index -- ){
        [SortLearn maxHeapify:array AndIndex:index AndLength:len];
    }
}


/// 堆排序算法
/// @param array array
+ (void)heapSort:(NSMutableArray *)array{
    NSInteger len = array.count;
    [SortLearn buildMaxHeap:array AndLength:len];
    for(NSInteger i = len - 1; i > 0; i--){
        [array exchangeObjectAtIndex:0 withObjectAtIndex:i];
        [SortLearn maxHeapify:array AndIndex:0 AndLength:i];
    }
}

@end
