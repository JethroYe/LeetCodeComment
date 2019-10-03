//
//  main.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2019/9/30.
//  Copyright © 2019 jasperye(叶宇轩). All rights reserved.
//

import Foundation

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        
        //Swift字符串不能按照index遍历访问
        
        //处理字符串，只保留数字和字母
        var muteS = s
        
//        for c in s {
//                if c.isLetter{
//                    var valide:String = String(c)
//                    valide = valide.lowercased()
//                    muteS = muteS + valide
//                }else if c.isNumber{
//                    var valide2:String = String(c)
//                    muteS = muteS + valide2
//                }
//        }
        
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

func main() {
    var ss = Solution()
    var isP = ss.isPalindrome("race a car")
    print(isP);
}


main();
