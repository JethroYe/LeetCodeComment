//
//  BinaryTreeBase.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/2/27.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//
//  基本二叉树题目
import Foundation

//MARK: - 二叉树的子结构 https://leetcode-cn.com/problems/shu-de-zi-jie-gou-lcof/submissions/
class isSubStructureSolution {
    
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

    
    func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        
        if (A == nil || B == nil)
        {
            return false;
        }
        
        //首先，判断A，B的根节点，行就return
        if (recur(A: A, B: B))
        {
            return true;
        }
        
        //如果上面不行，那就递归的检查A.left 和 B
        if(isSubStructure(A!.left, B))
        {
            return true
        }
        
        //如果上面还不行，就递归检查A.right 和 B
        if(isSubStructure(A!.right, B))
        {
            return true;
        }
        
        //如果都不行，只能return false
        return false;
    }
    
    func recur(A: TreeNode?, B: TreeNode?) -> Bool {
        //如果B是nil，一定是A的子结构，返回true
        if B == nil {
            return true
        }
        //如果A是nil，B一定不是A的子结构
        if A == nil {
            return false
        }
        //如果A,B 根节点值都不一样，那么就无需比较了，直接返回即可
        if A!.val != B!.val {
            return false
        }
        //排除上面所有的情况，就需要递归对比了
        return recur(A: A?.left, B: B?.left) && recur(A: A?.right, B: B?.right);
    }
    
}

/// 二叉树中和为某一值的路径
//https://leetcode-cn.com/problems/er-cha-shu-zhong-he-wei-mou-yi-zhi-de-lu-jing-lcof/submissions/
class SolutionOfBinaryTreeSum {
    
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
    
    //本题目重点在于 -- 记录路径
    var resArr:Array<Array<Int>> = Array()
    var path:Array<Int> = Array()
    
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        innerPathSum(root, sum);
        return resArr;
    }
    
    
    func innerPathSum(_ root: TreeNode?, _ sum:Int){
        
        guard let realRoot = root else {
            return
        }
        
        path.append(realRoot.val);
        let innerSum = sum - realRoot.val;
        
        if innerSum == 0 && realRoot.left == nil && realRoot.right == nil {
            resArr.append(path);
        }
        
        innerPathSum(realRoot.left, innerSum);
        innerPathSum(realRoot.right, innerSum);
        
        path.removeLast();
    }
    
}


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
    
    //MARK: - 【二叉树z序遍历】
    //解题重点：使用临时变量记录Queue的大小，从而得到每层有多少节点
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        
        guard let root = root else {
            return [];
        }
        
        //双端队列法
        var res:Array<Array<Int>> = Array()
        
        var queue:Array<TreeNode> = Array()
        queue.append(root)
        
        
        //层序遍历
        while queue.count > 0 {
            
            var curLevelRes:Array<Int> = Array()
            
            let curLevelCount = queue.count
            
            //这里利用curLevelCount来记录层序信息真的很骚
            for _ in 0..<curLevelCount{
                
                let node = queue.removeFirst()
                
                if res.count % 2 == 0 {
                    //队头插入
                    curLevelRes.append(node.val)
                }else{
                    //队尾插入
                    curLevelRes.insert(node.val, at: 0)
                }
                
                if node.left != nil {
                    queue.append(node.left!)
                }
                
                if node.right != nil {
                    queue.append(node.right!);
                }
            }
            res.append(curLevelRes)
            curLevelRes.removeAll()
            
        }
        
        
        return res
        
    }
    
    
    //MARK: - 【求二叉树深度】
    //https://leetcode-cn.com/problems/er-cha-shu-de-shen-du-lcof/submissions/
    func maxDepth(_ root: TreeNode?) -> Int {
        //递归出口
        if root == nil {
            return 0
        }
        let depth = max(maxDepth(root!.left), maxDepth(root!.right)) + 1;
        return depth;
        
    }
    
    
    //MARK: - 【反转二叉树】
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
    
    //MARK: - 【检查二叉树是否是镜像的】https://leetcode-cn.com/problems/symmetric-tree/submissions/
    //递归实现
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        guard let root = root else {
            //root 节点是nil，true
            return true;
        }
        
        //如果一个树的左子树和右子树一致，表示是对称了
        //使用双指针法判断
        return check(pNode: root, qNode: root)
    }
    
    func check(pNode:TreeNode?, qNode:TreeNode?) -> Bool {
            
        //左右都空，true
        if pNode == nil && qNode == nil {
            return true
        }
        //一个空，false
        if pNode == nil || qNode == nil {
            return false
        }
        
        //后面可以安全的强制解包了
        let isTrue = (pNode!.val == qNode!.val) && check(pNode: pNode!.left, qNode: qNode!.right) && check(pNode: pNode!.right, qNode: qNode!.left)
        return isTrue
        
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

    //MARK: - 【二叉树右视图】
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
    
    
    //MARK: - 【判断二叉树是否是平衡的】
    //https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof/
    
    /**思路：
     * 题目中已经说明了思路，比较简单。从root节点开始判断左右子树的高度相差是否超过了1
     * 如果超过了，那么直接返回true
     * 否则就递归的左右节点进行判断
     * 这种方式计算比较复杂，递归调用次数过多，尤其是求树深度的部分，递归次数过多。接下来看看题解有没有什么高效的办法
     */
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let realRoot = root else {
            return true
        }
        
        if (abs(maxDepth(realRoot.left) - maxDepth(realRoot.right)) <= 1){
            //继续检查
            return (isBalanced(realRoot.left) && isBalanced(realRoot.right))
        }else{
            //结束
            return false;
        }
    }
    
    //MARK: - 【求二叉树中两个节点的最近公共父节点】
    //https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/
    
    /**思路：
     * 后续遍历递归
     */
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        
        if root == nil {
            return root
        }
        
        //认为没有重复value的节点吧
        if (root!.val == p!.val) || (root!.val == q!.val) {
            return root!
        }
        
        let left = lowestCommonAncestor(root!.left, p, q);
        let right = lowestCommonAncestor(root!.right, p, q);
        
        //执行到这里左右只有一个有值，如果都没有，就是root
        if left == nil {
            //左边没有，返回右边
            return right
        }else if right == nil {
            //右边没有，返回左边
            return left
        }else{
            //左右都没用，命中了！
            return root
        }
    }
}
