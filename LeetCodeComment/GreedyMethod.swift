//
//  GreedyMethod.swift
//  LeetCodeComment
//
//  Created by JethroiMac on 2020/12/31.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Foundation

//MARK: - 无重叠区间 https://leetcode-cn.com/problems/non-overlapping-intervals/
/**
 * 贪心是DP的一个特例。DP可以暴力算法的指数级时间通过消除重复子问题的方式降低到多项式级别，
 * 贪心可以把DP的多项式级时间降低到常数级别
 * 贪心的重要性质：每一步都做出一个局部最优的选择，最终的结果就是全局最优的。如果能证明一个问题有这样的性质，
 * 那么就放心的使用贪心算法吧
 * 大部分问题明显不具有贪心选择性质。比如打牌，对手出对儿三，按照贪心策略，你应该出尽可能小的牌刚好压制住对方，但现实情况我们甚至可
 * 能会出王炸。这种情况就不能用贪心算法，而得使用动态规划解决，充分考虑所有情况得出最优解
 *
 *--------------------------------------------------------------------------
 *  暴力算法    |         DP                       |           贪心
 *--------------------------------------------------------------------------
 * 穷举所有可能  | 穷举所有可能，但是不会重复求解同一个问题 | 通过贪心性质，直接找出最优解
 *--------------------------------------------------------------------------
 */
class eraseOverlapIntervalsSolution {
    
    struct RealInterval {
        var left:Int
        var right:Int
    }
    
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        
        guard intervals.count > 0 else {
            return 0
        }
        
        //1.将输入转换成RealInterval 结构的数组
        var realIntervals:Array<RealInterval> = Array()
        for item in intervals {
            let realInterval = RealInterval(left: item.first!, right: item.last!)
            realIntervals.append(realInterval);
        }
        //2.排序
        realIntervals.sort { (itemA:RealInterval, itemB:RealInterval) -> Bool in
            return itemA.right < itemB.right
        }
        
        //3.遍历
        var curIdx:Int = 1
        var count = realIntervals.count
        
        while curIdx < count {
            
            if realIntervals[curIdx].left < realIntervals[curIdx - 1].right {
                //有重叠了，需要将后面的移除
                realIntervals.remove(at: curIdx)
                count = count - 1
            }else{
                //没有重叠，移动光标
                curIdx = curIdx + 1
            }
        }
        
        let res = intervals.count - realIntervals.count
        
        return res
    }
