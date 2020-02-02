//
//  AboutArray.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/2/2.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Cocoa

class AboutArray: NSObject {

    //MARK: - 买卖股票的最佳时机, 两种解法，暴力法和一次遍历法
    //https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/submissions/
    //双指针，一次遍历，原则就是找到当前最小值的之后的最大值
    func maxProfit(_ prices: [Int]) -> Int {
        
        let count = prices.count;
        
        guard count >= 2 else {
               return 0;
        }
        
        var resMax = 0;
        
        var mini:Int = Int(65532);
        
        for index in 0 ..< count {
            
            let cur = prices[index];
            
            if(cur < mini){
                mini = cur;
            }else{
                resMax = max(cur - mini, resMax);
            }
        }
        return max(resMax, 0);
    }
    
    //双指针遍历 -- 解法1：时间复杂度 n^2
    func maxProfit_1(_ prices: [Int]) -> Int {
        
        let count = prices.count;
        
        guard count >= 2 else {
            return 0;
        }
        
        var resMax = 0;
        
        for index in 0 ... count - 2 {
            
            for jndex in (index + 1 ... count - 1) {
                
                let tmpRes = prices[jndex] - prices[index];
                if(tmpRes > resMax){
                    resMax = tmpRes;
                }
                
            }
        }
        
        return max(resMax, 0);
    }

    
}
