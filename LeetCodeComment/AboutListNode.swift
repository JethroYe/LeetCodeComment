//
//  AboutListNode.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/5/18.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//
//  链表相关题目

import Foundation

class AboutListNode {
    
    //MARK: 反转链表
    //https://leetcode-cn.com/problems/fan-zhuan-lian-biao-lcof/
    /// 风骚递归 -- 反转链表
    /// - Parameter head: head
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil && head!.next == nil {
            return head!;
        }
        let ret = reverseList(head!.next);
        head!.next!.next = head;
        head!.next = nil;
        return ret;
    }
    

}
