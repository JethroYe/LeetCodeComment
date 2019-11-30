//
//  main.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2019/9/30.
//  Copyright © 2019 jasperye(叶宇轩). All rights reserved.
//

import Foundation

class Solution {
    func longestPalindrome(_ s: String) -> String {
        
        var resArr = Array<String>();
        
        let count:Int = s.count;
        
        var dp = Array<Array<Bool>>();
        
        var i = 0;
        while (i < count) {
            
            var j = 0;
            var tmp = Array<Bool>();
            while (j < count) {
                tmp.append(false)
                j = j + 1;
            }
            dp.append(tmp)
            
            i = i + 1;
        }
        
        
        var start = 0;
        while (start < count) {
            
//        for start in 0...count{
            
            var tempArr = Array<Bool>();
                
            var trail = count - 1;
            while (trail > start) {
//            for trail in start...count{
                
                var isPalindorme = false;
                
//                var startStr:Character = s[start-1 ... start];
//                var trailStr:Character = s[trail-1 ... trail];
                
                let startChar = s[s.index(s.startIndex, offsetBy: 1)];
                let trailChar = s[s.index(s.endIndex, offsetBy: -1)];
                
                if ((dp[start][trail - 1] == true) && (startChar == trailChar)) {
                    isPalindorme = true;
                    resArr.append(startChar);
                }else{
                    isPalindorme = false;
                }
                tempArr.append(isPalindorme);
                
                trail = trail - 1;
            }
            
            dp.append(tempArr);
            
            start = start + 1;
        }
        
        //遍历结果数组，找长度最长的
        if resArr.count == 0 {
            return ""
        }
        var res = resArr.first!;
        for item in resArr {
            if item.count > res.count {
                res = item;
            }
        }
        
        return res;
    }
}


func main() {
    
    var solu = Solution();
    var res = solu.longestPalindrome("babad");
    print (res);
}


main();
