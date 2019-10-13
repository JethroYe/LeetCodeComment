//DFS 伪代码

void DFS(G){
    //第一步，全图初始化为白色，pi = NULL;
    for each v in G.v{
        v.color = white;
        v.pi = NULL;
    }

    //全局时间戳，time = 0
    int time = 0;

    //--------开始DFS--------

    //首先遍历全部节点
    for each u in G.V{
        //如果是白色，就开始一次DFS
        if(color == white){
            //这句代码每执行一次，就会生成一个DFS树
            DFS_Visit(G.u);
        }
    }
    
}


void DFS_Visit(G.u){

}