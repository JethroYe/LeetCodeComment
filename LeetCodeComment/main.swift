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
        
        for start in 0...count{
            
            var tempArr = Array<Bool>();
            
            var charSet:CharacterSet = CharacterSet();
            charSet =
            
            for trail in start...count{
                
                var isPalindorme = false;
                
                var startStr:Character = s[start-1 ... start];
                var trailStr:Character = s[trail-1 ... trail];
                if ((dp[start][trail - 1] == true) && (startStr == trailStr)) {
                    isPalindorme = true;
                }else{
                    isPalindorme = false;
                }
                tempArr.append(isPalindorme);
            }
            
            dp.append(tempArr);
        }
        
        
        
        
        
        
        
        //遍历结果数组，找长度最长的
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
}


main();
