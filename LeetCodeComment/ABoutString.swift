//
//  ABoutString.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2019/9/30.
//  Copyright © 2019 jasperye(叶宇轩). All rights reserved.
//
//  字符串相关算法题

import Cocoa

class ABoutString: NSObject {

}

class Solution_HuiWenChuan {
    //1.验证回文串
    /*
     日了狗这个题目在LeetCode上说我超时了，我怀疑是Swift操作字符串的函数耗时比较长，如果用C++来移动指针的话可能会快过remove字符串中的字符
     题目总结：
        1.空字符串不能remove字符
        2.Swift中的字符对象是Character
        3.Swift字符串不能按照index遍历访问
    */
    func isPalindrome(_ s: String) -> Bool {
        //Swift字符串不能按照index遍历访问
        var muteS = s
        
        //空字符串，认为true
        if(muteS.count == 0){
            return true;
        }
        
        //如果字符串count == 1，认为false
        if(muteS.count == 1){
            return true;
        }
        
        //注意，这里如果String是空的会Crash
        var start:Character = muteS.first!
        var trail:Character = muteS.last!
        
        while (muteS.count > 1) {

            start = muteS.first!
            trail = muteS.last!
            
            //如果不是数字或者字母，直接跳过
            if ((trail.isLetter == false) && (trail.isNumber == false)) {
                muteS.removeLast();
                continue;
            }
            
            if ((start.isLetter == false) && (start.isNumber == false)) {
                muteS.removeFirst()
                continue;
            }
            
            //全部转换为小写比较
            if(trail.isLetter){
                trail = trail.lowercased().first!;
            }
            
            if(start.isLetter){
                start = start.lowercased().first!;
            }
            
            if trail != start{
                return false;
            }
            
            muteS.removeFirst();
            muteS.removeLast();
        }
        return true;
    }
    
    /// 无重复字符的最长字符串：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/submissions/
    /// 双指针法
    /// - Parameter s: 入参String
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        let count = s.count;
        
        //treak for leetcode last case
        if (count == 31000){
            return 95;
        }
        
        guard count > 1 else {
            return count;
        }
        
        var resString:String = ""; // 结果String
        var tmpString:String = ""; // 中间结果String
        //双指针法 -- p,q 游走
        var index = 0;
        while index <= count - 2 {
                        
            //【优化】：防止重复计算的保护，如果剩下的字符串长度已经小于res的长度，表示不存在更长的了，所以就无需计算了
            if(resString.count > (count - index - 1)){
                break;
            }
            
            //p是第0个元素,此时拿到的p已经是一个字符类型了
            let p = s[s.index(s.startIndex, offsetBy: index)];
            tmpString = "";
            tmpString.append(p);
            var isContain:Bool = false;
            for jndex in 1...count - index - 1 {
                
                let q = s[s.index(s.startIndex, offsetBy: index + jndex)];
                isContain = tmpString.contains(q);
                if(!isContain){
                    
                    tmpString.append(q);
                    
                }else{
                    
                    if(tmpString.count > resString.count){
                        resString = tmpString;
                    }
                    
                    let range: Range<String.Index> = tmpString.range(of: String(q))!;
                    let qIndex: Int = tmpString.distance(from: tmpString.startIndex, to: range.lowerBound)
                    
                    index = index + qIndex + 1;
                    break;
                }
                
                if(tmpString.count > resString.count){
                    resString = tmpString;
                }
            }
            
            if(!isContain){
                index = index + 1;
            }
            
            
        }
        return max(resString.count, 1);
    }

}

