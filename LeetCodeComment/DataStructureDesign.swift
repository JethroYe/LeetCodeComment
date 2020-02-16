//
//  DataStructureDesign.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/2/16.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Cocoa

class DataStructureDesign: NSObject {

    //MARK: - 【最小栈】 https://leetcode-cn.com/problems/min-stack/
    /**
        * 尝试通过双指针达到完全不遍历数组的成就，但是发现在 pop 的时候需要遍历一次array 刷新subMin，min不需要遍历
        * 如果这次遍历都不想要，就需要另存一个排好序的队列，并且实现映射。空间换时间而已，没什么意义我就不实现了
     */
    class MinStack {
        
        /// 存储数组
        var innerArray:Array<Int>;
        /// 最小值
        var miniValue:Int;
        
        init() {
            innerArray = Array();
            miniValue = -65532;
        }
        
        func push(_ x: Int) {
            
            if self.innerArray.count == 0 {
                self.miniValue = x;
            }else{
                self.miniValue = min(self.miniValue, x);
            }
            self.innerArray.append(x);
        }
        
        func pop() {
            let last = self.innerArray.last!;
            self.innerArray.removeLast();
            
            if last == self.miniValue {
                if self.innerArray.isEmpty {
                    
                }else{
                    self.miniValue = self.innerArray.min()!;
                }
            }
        }
        
        func top() -> Int {
            guard self.innerArray.count > 0 else {
                return 0;
            }
            
            return self.innerArray.last!;
        }
        
        func getMin() -> Int {
            return self.miniValue;
        }
    }

}
