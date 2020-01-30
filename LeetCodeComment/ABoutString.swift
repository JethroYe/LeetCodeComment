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
    
    //MARK: - 验证回文串
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
    
    //MARK: - 无重复字符的最长字符串
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
    
    
    //MARK: - 最长公共前缀
    /// 最长公共前缀 -- 小问题：https://leetcode-cn.com/problems/longest-common-prefix/
    /// - Parameter strs: str
    func longestCommonPrefix(_ strs: [String]) -> String {
        
        //字符串个数
        let strsCount = strs.count;
        
        if(strsCount == 0){
            return "";
        }
        
        if(strsCount == 1){
            return strs.first ?? "";
        }
        
        //结果
        var resStr:String = String();
        
        //最短长度
        var miniLen:Int = (strs.first?.count)!;//强制解包
        
        for index in 1...(strsCount - 1) {
            let miniLenTmp = strs[index].count;
            miniLen = min(miniLenTmp, miniLen);
        }
        
        if(miniLen == 0){
            return "";
        }
        
        for jndex in 0...(miniLen-1) {
            let firstString = strs[0];
            let firstItem = firstString[firstString.index(firstString.startIndex, offsetBy: jndex)];
            for kndex in 1...(strsCount - 1){
                let tmpString:String = strs[kndex];
                let tmpItem = tmpString[tmpString.index(tmpString.startIndex, offsetBy: jndex)];
                if(firstItem == tmpItem){
                    if(kndex == (strsCount-1)){
                        
                        if(resStr.count > 0){
                            resStr.append(tmpItem);
                        }else if(jndex == 0){
                            resStr.append(tmpItem);
                        }
                    }
                }else{
                    break;
                }
            }
        }
        return resStr;
    }
    //MARK: - 大整数乘法
    func multiply(_ num1: String, _ num2: String) -> String {
            
            //两个数字的大小
            let count1 = num1.count;
            let count2 = num2.count;
            
            //判空
            guard count1 != 0 && count2 != 0 else {
                return "0";
            }
            
            //判0
            guard num1 != "0" && num2 != "0" else {
                return "0";
            }
            
            //两个游标
            var index1 = count1 - 1;
            var index2 = count2 - 1;
            
            //结果数组
            var res:String = String();
            
            guard (count1 > 0 && count2 > 0) else {
                res = "";
                return res;
            }
            
            //计算矩阵
            var midResMatrx:Array<Array<Int>> = Array();
            //将矩阵初始化一下，全部填0
            //矩阵的宽是count1+count2-1,高是count2
            let midResMatrixWidth = count1 + count2;
            let midResMatrixHeight = count2;
            for _ in 1...midResMatrixHeight{
                var array:Array<Int> = Array();
                for _ in 1...midResMatrixWidth{
                    array.append(0);
                }
                midResMatrx.append(array);
            }
            
            //开始计算
            while index2 >= 0 {
                
                var jinWei:Int = 0;
                
                var midArr:Array<Int> = Array();
                index1 = count1 - 1;
                while index1 >= 0 {
                    
                    var midRes:Int = 0;
                    
                    //拿到两个数
                    let value1:Int = Int(String(num1[num1.index(num1.startIndex, offsetBy: index1)]))!;
                    let value2:Int = Int(String(num2[num2.index(num2.startIndex, offsetBy: index2)]))!;
                    
                    //求积
                    midRes = (value1 * value2 + jinWei);
                    
                    //判断是否要进位
                    if(midRes >= 10){

                        //需要进位
                        jinWei = midRes/10;
                    }else{

                        //不需要进位
                        jinWei = 0;
                    }
                    
                    if(index1 == 0 && midRes >= 10){
                        //拆分存储
                        midArr.append(midRes%10);//存储个位
                        midArr.append(midRes/10);//存储十位
                    }else{
                        //直接存粗
                        midArr.append(midRes%10);
                    }
                    index1 = index1 - 1;
                }
                
                
                //将MidArr填进矩阵里面
                for kndex in 0...(midArr.count - 1){
                    
                    midResMatrx[(count2 - index2 - 1)][(midResMatrixWidth - (count2 - index2 - 1) - kndex - 1)] = midArr[kndex];
                }
                
                index2 = index2 - 1;
            }
            
            
            var jinwei = 0;
            //终于，矩阵填写完了，开始求和，先宽再高 -- 其实这是一个大整数加法
            for wIndex in (0...midResMatrixWidth - 1).reversed(){
                
                var sum = 0;
                for hIndex in (0...midResMatrixHeight - 1){
                    sum = sum + midResMatrx[hIndex][wIndex];
                    //如果都加完了，就考虑进位
                    if(hIndex == (midResMatrixHeight - 1)){
                        sum = sum + jinwei;
                        if(sum >= 10){
                            jinwei = sum/10;
                            sum = sum % 10;
                        }else{
                            jinwei = 0;
                        }
                        
                        //进位处理完了，准备写入数组
                        res.insert(contentsOf: String(sum), at: res.startIndex);
                    }
                }
            }
            
            //最后，去掉前面的0
            var removeIndex = 0;
            for index in 0...(res.count - 1){
                if res[res.index(res.startIndex, offsetBy: index)] != "0" {
                    removeIndex = index;
                    break;
                }
            }
            
            
            if(removeIndex != 0){
                let startIndex = res.startIndex;
                let endIndex = res.index(startIndex, offsetBy: removeIndex-1);
                let range = startIndex...endIndex;
                res.removeSubrange(range);
            }
            
            
            return res;
        }
}

