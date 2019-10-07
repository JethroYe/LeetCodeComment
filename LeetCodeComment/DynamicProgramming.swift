//
//  DynamicProgramming.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2019/10/4.
//  Copyright © 2019 jasperye(叶宇轩). All rights reserved.
//
//  动态规划

import Cocoa

class DynamicProgramming: NSObject {
    
    //MARK: 扔鸡蛋问题
    func superEggDrop(_ K: Int, _ N: Int) -> Int {
            
        //1.特殊情况，如果蛋个数K少于1个，或者楼层数少于1层，那么最少尝试次数是0次
        if (K < 1 || N < 1) {
            return 0;
        }
        //2.初始化一个矩阵，用来做备忘录以及输出最后的结果 -- 请注意这里Swift二维矩阵的初始化，使用范型，非常机智
        //这个矩阵的行代表蛋个数，列代表楼层数
        var catchMatrix:Array<Array <Int>> = Array();
        //3.将矩阵的每个元素初始化成最大尝试数，也就是楼层数N，最大尝试数就是最坏情况，每层都要扔一次
        //(垃圾小燕子，不能for i，还要老子用wile)
        var i = 0;
        while (i <= K) {
            var j = 0;
            var tmpArr:Array<Int> = Array()
            while (j <= N){
                tmpArr.append(j);
                j = j + 1;
            }
            catchMatrix.append(tmpArr);
            i = i + 1;
        }
        
        //初始化完成了，开始逐行计算填表
        var egg = 1;
        //先遍历蛋，再遍历楼
        while(egg <= K){
            
            var floor = 1;
            while (floor <= N){
                
                var Min = catchMatrix[egg][floor];
                //开始遍历层数，现在鸡蛋的个数是egg，需要查看egg个鸡蛋下，不同层数变化需要多少次,求鸡蛋个数不变，不同层数的最大值
                var Max = 0;
                var index = 1;
                while (index <= floor) {
                    //如果鸡蛋碎了
                    let temp1 = catchMatrix[egg - 1][index - 1] + 1;
                    //如果鸡蛋没碎
                    let temp2 = catchMatrix[egg][floor - index] + 1;
                    Max = max(temp1, temp2);
                    
                    if(Max < Min){
                        Min = Max;
                    }
                    index = index + 1;
                }
                catchMatrix[egg][floor] = Min;
                
                floor = floor + 1;
            }
            
            egg = egg + 1;
        }
        
        return catchMatrix[K][N];
    }

    //MARK: 最大子序列问题
    /// 动态规划：最大子序列问题
    /// - Parameter nums: 输入数组
    func maxSubArray(_ nums: [Int]) -> Int {
        //这个题，是一个典型的DP题
        
        //使用Array() 初始化，需要指定范型
        var dp = Array<Int>();
        
        var i = 0
        while i < nums.count{
            dp.append(0);
            i = i + 1;
        }
        
        //如果输入数组的长度是0，那么就直接返回0
        if(nums.count == 0){
            return 0;
        }
        
        var index = 0;
        while (index < nums.count) {
            
            if(index == 0){
                dp[index] = nums[index];
            } else {
                //请注意，这里的递推式有点难以理解，但是确实是这么推的。直接使用dp[index - 1]的原因是，剩下几种情况不是子串，可以直接忽略
                dp[index] = max(nums[index], (dp[index-1] + nums[index]));
            }
            index = index + 1;
        }
        
        
        //得到返回值
        var res = dp[0];
        for item in dp {
            if item > res {
                res = item
            }
        }
        return res
    }

    // MARK: - 爬楼梯问题
    /// 动态规划，爬楼梯问题 https://leetcode-cn.com/problems/climbing-stairs/
    /// - Parameter n: 楼梯数
    func climbStairs(_ n: Int) -> Int {
        
        var dp = Array<Int>();
        
        //初始化dp
        for j in 0...n {
            dp.append(0);
        }
        
        for index in 0...n {
            
            if index < 3 {
                
                dp[index] = index
                
            }else{
                
                dp[index] = (dp[1] * dp[index - 1]) + ((dp[2] - 1) * dp[index - 2])
                
            }
        }
        
        return dp[n];
    }}
