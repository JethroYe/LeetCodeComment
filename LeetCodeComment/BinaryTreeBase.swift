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

//MARK: - 【二叉树镜像】https://leetcode-cn.com/problems/er-cha-shu-de-jing-xiang-lcof/
/**
 * 关于二叉树题目的思考：
 * 1. 大部分都是递归，而且是左右递归
 * 2. 分析针对每个节点的操作，寻找共性，共性就是被递归的点
 * 3. 寻找出口
 * 4. 递归需要一个blink，在脑子里先把递归流程走通再写代码
 
 */
class Solution2 {
    
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
    
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return root;
        }
        
        let left = mirrorTree(root?.left)
        let right = mirrorTree(root?.right)
        root?.left = right;
        root?.right = left;
        return root;
    }
    
    
    //MARK: - 【层序遍历二叉树】https://leetcode-cn.com/problems/cong-shang-dao-xia-da-yin-er-cha-shu-lcof/submissions/
    /**
     * 本题目的一些思考：
     * 1. 不要死板，二叉树题目不一定全都是递归的！
     * 2. 学习Swift let解包和if解包，两种解法
     */
    func levelOrder(_ root: TreeNode?) -> [Int] {
        
        var arr:Array<TreeNode> = Array()
        var resArr:Array<Int> = Array();
        
        //guard let 解包
        guard let unWrapRoot = root  else {
            return resArr;
        }
        
        //根节点如队
        arr.append(unWrapRoot);
        while arr.count > 0 {
            
            let firstNode = arr.first
            
            //if let 解包
            if let unWrapValue = firstNode?.val {
                //将结果保存
                resArr.append(unWrapValue)
            }
            
            //弹出第一个节点
            arr.removeFirst()
            
            //如果first有左右儿子，塞入队列
            if let unWrapLeft = firstNode?.left {
                arr.append(unWrapLeft)
            }
            if let unWrapRight = firstNode?.right {
                arr.append(unWrapRight)
            }
        }
        
        return resArr
    }

    //MARK: - 二叉树右视图
    //https://leetcode-cn.com/problems/binary-tree-right-side-view/submissions/
    
    /// BFS 广度优先解法
    /// - Parameter root: 根节点
    /// BB 2句：通过层序遍历的驱动方式，用另一个辅助数组记录层数。这个思路很棒。
    /// 同时，利用字典的去重特性，完美保存了每一层最后一个节点，这个思路也很棒
    func rightSideViewForBFS(_ root: TreeNode?) -> [Int] {
        
        guard let root:TreeNode = root else {
            return [];
        }
        
        //深度队列 -- 辅助队列记录深度，和实际Queue同出同进
        var depthQueue:Array<Int> = Array();
        //队列
        var queue:Array<TreeNode> = Array();
        //结果dic，层数为key，节点值为value 利用NSDictionary去重的原理
        var resDic:Dictionary<Int,TreeNode> = Dictionary();
        
        //初始化，准备开始遍历
        queue.append(root);
        depthQueue.append(0);
        
        
        while queue.count > 0 {
            
            let node:TreeNode = queue.removeFirst();
            let depth:Int = depthQueue.removeFirst();
            
            resDic[depth] = node;
            print("node.val = ", +node.val);
            print("depth = ", +depth);
            if (node.left != nil) {
                queue.append(node.left!);
                depthQueue.append(depth + 1);
            }
            
            if (node.right != nil) {
                queue.append(node.right!);
                depthQueue.append(depth + 1);
            }
        }
        
        let maxDepth = resDic.count;
        var finalRes:Array<Int> = Array();
        
        for idx in 0..<maxDepth {
            finalRes.append(resDic[idx]!.val);
        }
        
        return finalRes;
    }
    
}
