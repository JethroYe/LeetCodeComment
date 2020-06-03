//https://leetcode-cn.com/problems/er-cha-shu-de-zui-jin-gong-gong-zu-xian-lcof/
//二叉树公共祖先
class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {

        //判断是否命中了p,q
        //请注意p, q 是没有变化过的，在整个递归过程中，只用来判断
        if (root == NULL || root == p || root == q)
        {
            return root;
        }

        //先写递归,递归主体很容易理解，就是一个简单后左右根后序遍历
        TreeNode *left = lowestCommonAncestor(root->left,p,q);
        TreeNode *right = lowestCommonAncestor(root->right,p,q);

        //关键在与理解返回值和出口条件

        //如果左边没有，就返回右边
        if (left == NULL){
            return right;
        }
        //如果右边没有，就返回左边
        if (right == NULL){
            return left;
        }
        //如果左右都没有，就返回root -- 这里是叶子节点
        return root;
    }
};
