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

//1.验证回文串
/*
 日了狗这个题目在LeetCode上说我超时了，我怀疑是Swift操作字符串的函数耗时比较长，如果用C++来移动指针的话可能会快过remove字符串中的字符
 题目总结：
    1.空字符串不能remove字符
    2.Swift中的字符对象是Character
    3.Swift字符串不能按照index遍历访问
*/
class Solution_HuiWenChuan {
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
}

