//https://leetcode-cn.com/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/solution/er-cha-sou-suo-shu-zhuan-shuang-xiang-lian-biao-ja/

//二叉搜索树转换成有序的双联表
Node* treeToDoublyList(Node* root) 
{
    //Judge Empty
    if (root == NULL)
    {
        return;
    }
    

    //全局静态指针
    static Node *head;
    static Node *curNode;

    //DFS遍历
    inner(root);

    return head;
}   

//DFS
void inner(TreeNode node)
{
    if (node == NULL) return;
    
    inner(node.left);

    //如果pre空的，当前节点一定是头
    if (preNode == NULL)
    {
        head = node;
    }
    else
    {
        preNode.right = node
    }

    //连接当前节点的前序
    node.left = pre;

    //指针前移
    pre = node

    inner(node.right);
    
}