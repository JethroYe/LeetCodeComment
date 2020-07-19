//
//  ArrayOperate.swift
//  LeetCodeComment
//
//  Created by JethroiMac on 2019/12/18.
//  Copyright © 2019 jasperye(叶宇轩). All rights reserved.
//

import Foundation
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 *
 *两数之和 https://leetcode-cn.com/problems/add-two-numbers/
 *
 *风骚解法：直接转换成 double，双精度整数，然后求和就完了，不过要考虑溢出的情况
 */

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
    }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var res:ListNode = ListNode(0);
        
        if l1 == nil {
            
            return nil;
        }
        
        if l2 == nil{
            
            return nil;
        }
        
        var plus = 0;//进位标记
        
        //两个游标
        var cur1 = l1;
        var cur2 = l2;
        
        while (cur1 != nil || cur2 != nil) {
            
            var val1 = cur1?.val? cur1?.val : 0;
            var val2 = cur2?.val? cur2?.val : 0;
            
            var sum = Int(val1) + Int(val1);
            
            if(sum < 10){
                res.val = sum;
                plus = 0;
            }else{
                plus = plus + 1;
                res.val = sum - 10;
            }
            
            //游标前进
            cur1 = cur1?.next;
            cur2 = cur2?.next;
            
            
        }
        
        
        return nil;
    }
}}
