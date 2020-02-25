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

    //MARK: - 【LRU】 https://leetcode-cn.com/problems/lru-cache/
    /**
        * Dictionary 存储数据，同时<Key, value>用双向链表保存，以维护先后顺序。
        * 双向链表非常有趣，值得再看看类似题目
     */
    class LRUCache {

        ///ListNode -- 辅助存储
        class ListNode: NSObject {
            var pre:ListNode? = nil;
            var next:ListNode? = nil;
            
            var key:Int = 0;
            var value:Int = 0;
            
        }
        

        ///propertys
        var capacity:Int;
        var innerDic:Dictionary<Int, ListNode>;
        var head:ListNode;
        var trail:ListNode;

        init(_ capacity: Int) {
            
            //初始化hashmap
            self.capacity = capacity;
            self.innerDic = Dictionary();
            
            //初始化辅助链表
            self.head = ListNode();
            self.trail = ListNode();
            
            self.head.next = self.trail;
            self.trail.pre = self.head;
            
        }
        
        func get(_ key: Int) -> Int {
            if (self.innerDic.keys.contains(key))
            {
                let tmpModel:ListNode = self.innerDic[key]!;
                
                //调整Model 的位置
                //首先删除
                tmpModel.pre?.next = tmpModel.next;
                tmpModel.next?.pre = tmpModel.pre;
                
                //再添加
                tmpModel.next = head.next;
                head.next?.pre = tmpModel;
                tmpModel.pre = head;
                head.next = tmpModel;
                
                
                //返回值
                return tmpModel.value;
                
            }else{
                
                return -1;
            }
        }
        
        func put(_ key: Int, _ value: Int) {
            
            let newNode = ListNode()
            newNode.value = value;
            newNode.key = key;
            
            if self.innerDic.keys.contains(key) {
                
                //已经存在了，直接替换即可
                var nodeForDel = self.innerDic[key];
                
                //node要在链表中删除自己
                nodeForDel?.pre?.next = nodeForDel?.next;
                nodeForDel?.next?.pre = nodeForDel?.pre;
                
                //替换
                self.innerDic[key] = newNode;
                
            }else{
                //判断是否超过了范围，如果超过了，就需要删除
                if (self.innerDic.count >= self.capacity){
                    
                    //删除队尾节点
                    var nodeForDel:ListNode? = trail.pre;
                    trail.pre = nodeForDel!.pre;
                    nodeForDel!.pre?.next = trail;
                    self.innerDic.removeValue(forKey: nodeForDel!.key);
                }
                //插入dic，插入listNode
                self.innerDic[key] = newNode;
                
                //放入链表中的头节点
                self.head.next?.pre = newNode;
                newNode.next = self.head.next;
                newNode.pre = head;
                head.next = newNode;
            }
            
        }
    }

    
    //MARK: - 【从尾到头打印链表】 https://leetcode-cn.com/problems/cong-wei-dao-tou-da-yin-lian-biao-lcof/
    /**
        * 自己实现一个简单的 栈
        * 入+出，两次遍历，简单题
     */
    public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        }
    }
    
    class Stack {
        
        //内部存储
        public var innerArr:Array<Int>;
        init() {
            self.innerArr = Array();
        }
        
        func push(item:Int) {
            self.innerArr.insert(item, at: 0);
        }
        
        func pop() -> Int {
            let item:Int = self.innerArr.first!;
            self.innerArr.remove(at: 0);
            return item;
        }
        
        func stackSize() -> Int {
            return self.innerArr.count;
        }
    }
    
    
    
    func reversePrint(_ head: ListNode?) -> [Int] {

        if head == nil {
            return [];
        }
        
        //堆栈法
        var resArray:Array<Int> = Array();
        
        var cur = head;
        
        var stack:Stack = Stack();
        
        while (cur != nil) {
            stack.push(item: cur!.val);
            cur = cur!.next;
        }
        
        for _ in 0 ..< stack.stackSize(){
            let item = stack.pop();
            resArray.append(item);
        }
        
        return resArray;
    }
    
    
}
