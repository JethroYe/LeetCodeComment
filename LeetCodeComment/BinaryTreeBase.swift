//
//  BinaryTreeBase.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/2/27.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//
//  基本二叉树题目
import Foundation

//MARK: - 【重建二叉树】https://leetcode-cn.com/problems/zhong-jian-er-cha-shu-lcof/
/**
    * 递归解法
 */

class Solution1 {
    
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.count == 0 || inorder.count == 0 || (preorder.count != inorder.count) {
            return nil;
        }
        
        if preorder.count == 1 || inorder.count == 1 {
            let node:TreeNode = TreeNode(preorder.first!);
            return node;
        }
        
        if preorder.count == 2 || inorder.count == 2 {
            
            let preFirst:Int = preorder.first!
            let preLast:Int = preorder.last!
            let InFirst:Int = inorder.first!
            let rootNode:TreeNode = TreeNode(preFirst);

            if preFirst == InFirst {
                let leapNode:TreeNode = TreeNode(preLast);
                rootNode.right = leapNode;
            }else{
                let leapNode:TreeNode = TreeNode(preLast);
                rootNode.left = leapNode;
            }
            return rootNode;
        }
        
        return self.innerBuildTree(preorder, inorder);
    }
    
    
    func innerBuildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        
        if preorder.count == 0 || inorder.count == 0 {
            return nil;
        }
        
        if preorder.count == 1 && inorder.count == 1 {
            
            let node:TreeNode = TreeNode(preorder.first!);
            return node;
        }
        
        //rootNode
        let rootNode:TreeNode = TreeNode(preorder.first!);
        
        //使用上面的index拆分得到两个数组
//        let slipedArray = inorder.split(separator: preorder.first!);
        let slipedArray = inorder.split(separator: preorder.first!, maxSplits: preorder.count, omittingEmptySubsequences: false);
        
        //中序左
        let inorderLeft:Array<Int> = Array(slipedArray.first!)
        //中序右
        let inorderRight:Array<Int> = Array(slipedArray.last!)
        
        //根据中序左右的长度，拆分前序数组
        
        //前序左
        let startIndexLeft:Int = 1;
        let preOrderLeftCount = inorderLeft.count;
        var preOrderLeft:Array<Int> = Array();
        if preOrderLeftCount != 0 {
            preOrderLeft = Array(preorder[startIndexLeft...(startIndexLeft + preOrderLeftCount - 1)]);
        }
         
        
        //前序右
        let startIndexRight:Int = startIndexLeft+inorderLeft.count;
        let preOrderRightCount = inorderRight.count;
        var preOrderRight:Array<Int> = Array();
        if preOrderRightCount != 0 {
            preOrderRight = Array(preorder[startIndexRight...(startIndexRight + preOrderRightCount - 1)]);
        }
         
        
        //开始递归
        rootNode.left = self.buildTree(preOrderLeft, inorderLeft);
        rootNode.right = self.buildTree(preOrderRight, inorderRight);
        
        return rootNode;
    }
}
