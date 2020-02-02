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

    //MARK: - 买卖股票的最佳时机2，使用导数思想
    //https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/comments/
    func maxProfit_two(_ prices: [Int]) -> Int {
        
        //神奇的求导法
        let count = prices.count;
        
        if count < 2 {
            return 0;
        }
        
        if count == 2 {
            return max(0, prices.last! - prices.first!)
        }
        
        var index = 0;
        var jndex = 0;
        var kndex = jndex + 1;
        
        
        var buyPoint = 0;
        var sailPoint = 0;
        
        var res = 0;
        
        var isBuying:Bool = false;
        
        while jndex <= count - 1 {
            
            let indexV = prices[index];
            let jndexV = prices[jndex];
            let kndexV = prices[kndex];
            
            if(indexV >= jndexV && kndexV >= jndexV){
                //出现低谷点，是买点
                if(isBuying == false){
                    buyPoint = jndex;
                }
                isBuying = true;
                
                index = jndex;
                jndex = index + 1;
                kndex = min(index + 2, count - 1);
                continue;
            }
            
            if(indexV <= jndexV && kndexV <= jndexV && isBuying){
                //出现波峰点，是卖点
                sailPoint = jndex;
                
                //操作买卖
                if(sailPoint > buyPoint){
                    res = res + (prices[sailPoint] - prices[buyPoint]);
                    isBuying = false;
                }
            }
            
            
            index = index + 1;
            jndex = jndex + 1;
            kndex = min(kndex + 1, count - 1);
        }
        
        //如果结果是0，表示函数是单调的，需要判断首尾即可
        if(res == 0){
            let tmpRes = prices.last! - prices.first!;
            res = max(res,tmpRes);
        }
        
        return max(res, 0);
    }
    
}
