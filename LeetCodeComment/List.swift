//
//  List.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/5/10.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Foundation

class solution {
        
    //MARK: https://leetcode-cn.com/problems/swap-nodes-in-pairs/
    /// 两两交换链表中的节点
    /// - Parameter head: head
    func swapPairs(_ head: ListNode?) -> ListNode? {
        //出口
        if(head == nil || head?.next == nil){
            return head;
        }
        
        var first:ListNode = head!
        var second:ListNode = head!.next!;
        
        //交换
        first.next = swapPairs(second.next);
        second.next = first;
        
        return second;
        
    }

    
}
