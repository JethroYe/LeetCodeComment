//
//  DFSAndPruing.swift
//  LeetCodeComment
//
//  Created by JethroiMac on 2020/8/13.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Foundation

//MARK: - 矩形围绕区域的问题 https://leetcode-cn.com/problems/surrounded-regions/
/**
 *1. 关键思路在于反向思考，如果不能标记出“内部的O”，就要标记处“跟边界联通的O”，这样DFS算法写起来比较简单
 *2. 注意DFS函数的设计
 */
class SolutionForMatrix {
    func solve(_ board: inout [[Character]]) {

        let row = board.count
        
        guard row > 0 else {
            return
        }
        
        let column = board.first!.count
        guard column > 0 else {
            return
        }
        
        //遍历边界，首先是上下边界
        for idx in 0 ..< column {
            
            if board[0][idx] == "O" {
                //DFS标记
                DFS(&board, 0, idx)
            }
            
            if board[row - 1][idx] == "O" {
                //DFS标记
                DFS(&board, row - 1, idx)
            }
            
        }
        
        //遍历左右边界
        for idx in 0 ..< row {
            
            if board[idx][0] == "O" {
                //DFS标记
                DFS(&board, idx, 0)
            }
            
            if board[idx][column - 1] == "O" {
                //DFS标记
                DFS(&board, idx, column - 1)
            }
        }
        
        //第一轮标记完成
        print("---第一轮标记完成---")
        print(board)
        
        
        //将O变成X，M变成O
        for idx in 0 ..< row {
            for jdx in 0 ..< column {
                
                if board[idx][jdx] == "O" {
                    board[idx][jdx] = "X"
                } else if board[idx][jdx] == "M" {
                    board[idx][jdx] = "O"
                }
                
            }
        }

    }
    
    func DFS(_ board: inout [[Character]], _ x:Int, _ y:Int) {
        
        
        let row = board.count;
        let column = board.first!.count;
        
        //出口条件
        guard (x >= 0) && (x < row) && (y >= 0) && (y < column) && (board[x][y] == "O")  else {
            return
        }
        
        //标记
        board[x][y] = "M"
        //四个方向
        DFS(&board, x - 1, y)
        DFS(&board, x + 1, y)
        DFS(&board, x, y - 1)
        DFS(&board, x, y + 1)
        
    }
    
}
