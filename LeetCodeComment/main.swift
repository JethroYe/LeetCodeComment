//
//  main.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2019/9/30.
//  Copyright © 2019 jasperye(叶宇轩). All rights reserved.
//

import Foundation

class Solution {
    
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
}
func main() {
    
    var solu = Solution();
    
    var arr = [-2,1,-3,4,-1,2,1,-5,4];
    
    
    var res = solu.maxSubArray(arr);
}


main();
