//
//  MonotonicStack.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/6/12.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Foundation

class MonotonicStackSolution {
    
    //MARK: - 每日温度
    //https://leetcode-cn.com/problems/daily-temperatures/submissions/
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        
        let count = T.count;
        
        guard count != 0 else {
            return [];
        }
        
        //初始化结果数组
        var res:Array<Int> = Array();
        for _ in 0 ..< count {
            res.append(0);
        }

        //初始化单调栈
        var monotonicStack:Array<Int> = Array();
        
        for curIdx in 0 ..< count {
            
            if monotonicStack.isEmpty {
                monotonicStack.insert(curIdx, at: 0)
            }else{
                while !monotonicStack.isEmpty && (T[monotonicStack.first!] < T[curIdx]) {
                    //记录结果
                    let first = monotonicStack.first!;
                    res[first] = curIdx - first;
                    monotonicStack.removeFirst();
                }
                monotonicStack.insert(curIdx, at: 0);
            }
        }
        
        return res;
    }
    
    /// 暴力解决法 -- TLE
    /// - Parameter T: T
    func dailyTemperatures_force(_ T: [Int]) -> [Int] {
        
        let count = T.count;
        
        guard count != 0 else {
            return [];
        }
        
        var res:Array<Int> = Array();
        
        for _ in 0 ..< count {
            res.append(0);
        }
        
        for day in 0 ..< count {
            let nextDay = day + 1;
            for nextDay in (nextDay ..< count) {
                if T[nextDay] > T[day] {
                    res[day] = nextDay - day;
                    break;
                }
            }
        }
        
        return res;
    }
}
