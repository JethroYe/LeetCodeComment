//
//  DFSClass.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/6/11.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Foundation

class DFSSolution {
    
    //MARK: - 矩阵中的路径
    /// https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof/
    /// - Parameters:
    ///   - board: 矩阵
    ///   - word: 字符串
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard board.count > 0 && board[0].count > 0 else {
            return false
        }
        if word.count == 0 {
            return false
        }
        var boradVar = board
        
        for idx in 0 ..< boradVar.count {
            for jdx in 0 ..< boradVar[0].count{
                let res:Bool = DFSForExist(&boradVar, word, 0, idx, jdx)
                if res {
                    return true
                }
            }
        }
        return false
    }
    //递归查找函数
    func DFSForExist(_ board: inout [[Character]], _ word:String, _ strIdex:Int, _ idx: Int, _ jdx: Int) -> Bool {
        
        let startIndex = word.index(word.startIndex,offsetBy: strIdex)
        let endIndex = word.index(startIndex,offsetBy: 1)
        let curChar:String = String(word[startIndex..<endIndex])
        
        //首先判断边界条件 -- 递归出口之一
        if (strIdex >= word.count || strIdex < 0) || (idx >= board.count || idx < 0) || (jdx >= board[0].count || jdx < 0) {
            return false
        }
        
        //其次判断是否相等
        if curChar != String(board[idx][jdx]) {
            return false
        }

        
        if strIdex == word.count - 1 {
            return true
        }
        
        let tmp = board[idx][jdx]
        board[idx][jdx] = "]"
        let nextLevelRes = DFSForExist(&board, word, strIdex + 1, idx, jdx + 1) ||
            DFSForExist(&board, word, strIdex + 1, idx, jdx - 1) ||
            DFSForExist(&board, word, strIdex + 1, idx + 1, jdx) ||
            DFSForExist(&board, word, strIdex + 1, idx - 1, jdx)
        board[idx][jdx] = tmp
        return nextLevelRes
    }
    //MARK:------------------------------------------------------------------------------------------------------
}
