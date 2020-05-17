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
    
    //MARK: 三步问题
    //https://leetcode-cn.com/problems/three-steps-problem-lcci/
    func waysToStep(_ n: Int) -> Int {
        var dp:Array<Int> = Array(arrayLiteral: 0,1,2,4);
        if(n < 4){
            return (dp[n]%1000000007)
        }
        for idx in 4...n {
            let res:Int = dp[idx - 1] + dp[idx - 2] + dp[idx - 3];
            dp.append(res%1000000007);
        }
        return dp[n]
    }

    
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
        for _ in 0...n {
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
    }
    
    //MARK: - 不同路径
    /// 动态规划，不同路径问题 https://leetcode-cn.com/problems/unique-paths/submissions/
    /// - Parameters:
    ///   - m: M*N
    ///   - n: M*N
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        //DP解法，自底向上 -- 顺着推
        var res:Array<Array<Int>> = Array();

        //先初始化一下数组 -- swift究竟如何写一个矩阵？
        for _ in 0...m {
            var array:Array<Int> = Array();
            for _ in 0...n {
                array.append(0);
            }
            res.append(array);
        }

        for index in 0...m {
            for jndex in 0...n {

                var tmp = 0;

                if(index == 0 && jndex == 0){
                    tmp = 1;
                }else if(index == 0 || jndex == 0){
                    tmp = 1;
                }else{
                    tmp = (res[index - 1][jndex]) + (res[index][jndex - 1]);
                }
                res[index][jndex] = tmp;
            }
        }
        return res[m - 1][n - 1];
        
        /*这里还有一个超时的简单解法，这里有很多重复计算，加上记录就是DP了
            if(m <= 0 || n <= 0){
                return 0;
            }

            if(m == 1 || n == 1){
                return 1;
            }

            if(m == 2 && n == 2){
                return 2;
            }

            return (uniquePaths(m-1, n)) + (uniquePaths(m, n-1));

         */
    }
    
    //MARK: - 不同的二叉搜索树
    
    /// 动态规划，不同的二叉搜索树 https://leetcode-cn.com/problems/unique-binary-search-trees/
    /// - Parameter n: n
    func numTrees(_ n: Int) -> Int {
        
        /*
            这个算法的计算量可以被优化一半，原因是里面有一部分的求和计算重复了
         */
        
        //结果数组，首先简单初始化一下
        var resArray:Array<Int> = Array();
        var tmp = 0;
        for index in 0...n {
            if (index < 2) {
                tmp = 1
            }else{
                tmp = 0;
                for jndex in 0...(index-1) {
                    //重温；这个状态转移方程之所以可以这么写，关键思路在于：串“123”和串“456”生成的BST的个数，是一样的，所以才能递归
                    tmp = tmp + (resArray[jndex]*resArray[(index - jndex - 1)]);
                }
            }
            resArray.append(tmp);
        }
        
        return resArray.last ?? 0;
    }
    
    //MARK: - 最短路径和 https://leetcode-cn.com/problems/minimum-path-sum/
        
    func minPathSum(_ grid: [[Int]]) -> Int {
        
        let m = grid.count;
        
        if(m == 0){
            return 0;
        }
        
        
        let n = grid[0].count;
        
        var resMatrix:Array<Array<Int>> = Array();
        
        //先初始化一下
        for _ in 0 ..< m {
            var tmpArray:Array<Int> = Array();
            for _ in 0 ..< n{
                tmpArray.append(0);
            }
            resMatrix.append(tmpArray);
        }
        
        
        for index in 0 ..< m {
            
            for jndex in 0 ..< n{
                
                var tmpValue = -1;
                
                if(index == 0 && jndex == 0){
                    tmpValue = grid[0][0];
                }else if(index == 0){
                    tmpValue = resMatrix[0][jndex - 1] + grid[index][jndex];
                }else if(jndex == 0){
                    tmpValue = resMatrix[index - 1][jndex] + grid[index][jndex];
                }else{
                    tmpValue = min(resMatrix[index - 1][jndex], resMatrix[index][jndex - 1]) + grid[index][jndex];
                }
                resMatrix[index][jndex] = tmpValue;
            }
            
        }
           
        return resMatrix.last!.last!;
    }

    
    //MARK: - 三角形最短路径和
    //https://leetcode-cn.com/problems/triangle/submissions/
    /**
     本题总结：算法题目有两个重点：
        想出算法
        变成代码
     对于DP题目，要找对状态转移方程，实际操作dp方程发现可以解决问题后，尝试寻找子问题和总问题之间的递归关系
     通常会遇到递归+方程两个考点。如果要保存中间结果，通常遇到矩阵，如果矩阵写出来了，题目也就解决了
     */
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        
        let count:Int = triangle.last?.count ?? 0;
        
        guard count != 0 else {
            return 0;
        }
        
        //首先初始化一个结果数组
        var dp:Array<Array<Int>> = Array();
        
        for _  in 0 ..< count {
            var tmpArray:Array<Int> = Array();
            for _ in 0 ..< count {
                tmpArray.append(0);
            }
            dp.append(tmpArray);
        }
        
        for index in 0 ..< count {
                        
            for jndex in 0 ... index{
                
                var tmpRes = 0;
                
                if(index == 0 && jndex == 0){
                    tmpRes = triangle[index][jndex];
                }else{
                    
                    let tmpIndex = max(0, index - 1);
                    let tmpJndex = max(0, jndex - 1);
                    let tmpJndex2 = min(jndex,index - 1);
                    tmpRes = min(dp[tmpIndex][tmpJndex], dp[tmpIndex][tmpJndex2]) + triangle[index][jndex];
                }
                dp[index][jndex] = tmpRes;
            }
        }
        
        return dp.last?.min()! ?? 0;
        
    }
    
    //MARK: - 斐波那契数列，DP解法 -- 快速矩阵幂太骚了。。。
    //https://leetcode-cn.com/problems/fei-bo-na-qi-shu-lie-lcof/
    func fib(_ n: Int) -> Int {
        
        if n == 0 {
            return 0
        }
        
        if n == 1 {
            return 1
        }
        
        var s:Array<Int> = Array()
        
        s.append(0);
        s.append(1);
        
        for idx in 2...n{
            let item = (s[idx - 1] + s[idx - 2])%1000000007;
            s.append(item)
        }
        
        return s.last!
    }
    
    //MARK: - 青蛙跳台阶问题，DP解法 -- 快速矩阵幂太骚了。。。
    //https://leetcode-cn.com/problems/qing-wa-tiao-tai-jie-wen-ti-lcof/
    func numWays(_ n: Int) -> Int {
        
        var dp:Array<Int> = Array();
        
        for idx in 0...n {
            
            if idx == 0{
                dp.append(1);
            }else if idx <= 2 {
                dp.append(idx)
            }else{
                let item = (dp[idx - 2] + dp [idx - 1])%1000000007
                dp.append(item);
            }
        }
        return dp[n];
    }

}
