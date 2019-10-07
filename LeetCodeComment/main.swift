//
//  main.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2019/9/30.
//  Copyright © 2019 jasperye(叶宇轩). All rights reserved.
//

import Foundation

class Solution {
    
    
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
    }
}
func main() {
    
    var solu = Solution();
    
    var res = solu.climbStairs(2);
    
    print(res);
}


main();
