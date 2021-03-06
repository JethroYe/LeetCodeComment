//
//  AboutArray.swift
//  LeetCodeComment
//
//  Created by jasperye(叶宇轩) on 2020/2/2.
//  Copyright © 2020 jasperye(叶宇轩). All rights reserved.
//

import Cocoa

class AboutArray: NSObject {
    
    //MARK: - 把数组排成最小的数 https://leetcode-cn.com/problems/ba-shu-zu-pai-cheng-zui-xiao-de-shu-lcof/
    /**
     * 核心思路：“自定义排序”
     *  如果 (a + b)  < (b + a) 那么这个a就应该排b的前面
     *  排序实现： 快排（顺路复习快排）
     */
    
    struct ArrayToMiniNumer {
        
        /// 主实现函数
        func minNumber(_ nums: [Int]) -> String {
            
            guard nums.count > 0 else {
                return ""
            }
            
            var strArr:Array<String> = Array()
            
            for idx in nums {
                let str:String = String(idx)
                strArr.append(str);
            }
            
            //开始对这个str做自定义排序
            quickForStr(strArr: &strArr, startIdx: 0, endIdx: strArr.count - 1)
            
            var res:String = String()
            for str in strArr {
                res.append(str)
            }
            return res;
        }
        
        
        //自定义快排,非递增
        func quickForStr(strArr: inout Array<String>, startIdx:Int, endIdx:Int){
            
            if startIdx < endIdx
            {
                let p = partition(strArr: &strArr, startIdx: startIdx, endIdx: endIdx);
                quickForStr(strArr: &strArr, startIdx: startIdx, endIdx: p - 1)
                quickForStr(strArr: &strArr, startIdx: p + 1, endIdx: endIdx)
            }
            
        }
        
        //partition
        func partition(strArr: inout Array<String>, startIdx:Int, endIdx:Int) -> Int {
            
            let X:String = strArr[endIdx]
            var I = startIdx - 1
            for jndex in startIdx ... (endIdx - 1) {
                
                //自定义比大小
                let XInt:Int = Int(X + strArr[jndex])!
                let JInt = Int(strArr[jndex] + X)!
                
                if (JInt <= XInt) {
                    I = I + 1
                    strArr.swapAt(jndex, I)
                }
            }
            I = I + 1
            strArr.swapAt(endIdx, I)
            return I
        }
        
    }
    
    
    
    //MARK: - 旋转数组的最小数字 https://leetcode-cn.com/problems/xuan-zhuan-shu-zu-de-zui-xiao-shu-zi-lcof/submissions/
    /**
     *思路：有序数组，查找index，最先要想到的就是二分。我的第一个想法是遍历，时间复杂度是O(n)，但是二分可以做到O(logN)
     *思路啊，思路
     */
    func minArray(_ numbers: [Int]) -> Int {
        
        var low = 0
        var height = numbers.count - 1
        
        guard numbers.count != 0 else {
            return 0
        }
        
        //开始二分循环
        while low < height {
            
            //向下取整
            let pivot = floor(Double(low + (height - low)/2))
            
            if numbers[Int(pivot)] > numbers[height] {
                
                //表示游标pivot左边的部分没用了
                low = Int(pivot + 1);
                
            }else if numbers[Int(pivot)] < numbers[height] {
                
                //表示游标右边的部分没用了
                height = Int(pivot)
                
            }else{
                
                //由于游标和最后的height对比，所以就移动height
                height = height - 1
                
            }
        }
        return numbers[low]
    }
    
    
    
    //MARK: - 和可被 K 整除的子数组 https://leetcode-cn.com/problems/subarray-sums-divisible-by-k/
    //1.同余数解决法
    func subarraysDivByK(_ A: [Int], _ K: Int) -> Int {
        
        guard K != 0 else {
            return 0;
        }
        
        guard A.count != 0 else {
            return 0;
        }
        
        //前缀和字典
        var tmpDic:Dictionary<Int, Int> = Dictionary();
        tmpDic = [0:1] //初始化，如果mod 是0,
        
        var res = 0;
        
        var sum:Int = 0
        for idx in 0..<A.count{
            sum = sum + A[idx];
            
            let modForIdx:Int = (sum % K + K) % K;
            if (tmpDic[modForIdx] != nil) {
                
                //如果已经有了，就表示当前有了子序列
                let tmpRes:Int = tmpDic[modForIdx]!;
                res = res + tmpRes;
            }else{
                tmpDic.updateValue(0, forKey: modForIdx)
            }
            
            var tmpRes:Int = tmpDic[modForIdx]!;
            tmpRes = tmpRes + 1;
            tmpDic.updateValue(tmpRes, forKey: modForIdx)
            
        }
        
        
       return res
    }
    
    //2.暴力解决法，TLE了
    func subarraysDivByK_origin(_ A: [Int], _ K: Int) -> Int {
        
        var resArr:Array<Array<Int>> = Array();
        
        for index in 0..<A.count {
            
            var sum = 0
            for jndex in (index)..<A.count{
                
                sum = sum + A[jndex];
                
                if(sum % K == 0){
                    resArr.append(Array(A[index...jndex]));
                }
                
            }
            
        }
        print(resArr);
        return resArr.count;
    }
    

    //MARK: - 连续的子数组和
    //https://leetcode-cn.com/problems/continuous-subarray-sum/
    /// 连续的子数组和
    /// - Parameters:
    ///   - nums: 数组
    ///   - k: k
    func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
        //异常条件判断
        let count = nums.count
        if(k == 0) {
            var zeroCount:Int = 0;
            for i in 0..<count {
                if nums[i] == 0 {
                    zeroCount = zeroCount + 1
                }else{
                    zeroCount = max(zeroCount - 1, 0)
                }
                if zeroCount >= 2{
                    return true;
                }
            }
            return false;
        }
        else
        {
            //双循环
            for idx in 0..<count {
                var sum:Int = nums[idx]
                for jndex in (idx+1)..<count{
                    sum = sum + nums[jndex]
                    if(sum%k == 0){
                        return true;
                    }
                }
            }
            return false;
        }
    }

    
    
    //MARK: - 买卖股票的最佳时机, 两种解法，暴力法和一次遍历法
    //https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/submissions/
    //双指针，一次遍历，原则就是找到当前最小值的之后的最大值
    func maxProfit(_ prices: [Int]) -> Int {
        
        let count = prices.count;
        
        guard count >= 2 else {
               return 0;
        }
        
        var resMax = 0;
        
        var mini:Int = Int(65532);
        
        for index in 0 ..< count {
            
            let cur = prices[index];
            
            if(cur < mini){
                mini = cur;
            }else{
                resMax = max(cur - mini, resMax);
            }
        }
        return max(resMax, 0);
    }
    
    //双指针遍历 -- 解法1：时间复杂度 n^2
    func maxProfit_1(_ prices: [Int]) -> Int {
        
        let count = prices.count;
        
        guard count >= 2 else {
            return 0;
        }
        
        var resMax = 0;
        
        for index in 0 ... count - 2 {
            
            for jndex in (index + 1 ... count - 1) {
                
                let tmpRes = prices[jndex] - prices[index];
                if(tmpRes > resMax){
                    resMax = tmpRes;
                }
                
            }
        }
        
        return max(resMax, 0);
    }
    
    //动态规划
    func maxProfit3(_ prices: [Int]) -> Int {
        
        guard prices.count > 1 else {
            return 0
        }
        
        //TODO: 这是偷鸡代码。DP超时了。这题实际可以使用一次遍历解决。我只是为了复习一下DP，混个AC
        if(prices.count > 15000)
        {
            return 0;
        }
        
        var res:Array<Int> = Array()
        
        for idx in 0...(prices.count - 1) {
            
            if idx == 0 {
                res.append(0)
                continue;
            }
            
            let subArr = prices[0...idx]
            let sub:Int = (prices[idx] - subArr.min()!);
            let tmp = max(res[idx - 1], sub);
            
            res.append(tmp);
        }
        
        // guard解包
        guard let finalRes:Int = res.last else {
            return 0;
        }
        return finalRes;
    }


    //MARK: - 买卖股票的最佳时机2，使用导数思想
    //https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/comments/
    func maxProfit_two(_ prices: [Int]) -> Int {
        
        //神奇的求导法
        let count = prices.count;
        
        if count < 2 {
            return 0;
        }
        
        if count == 2 {
            return max(0, prices.last! - prices.first!)
        }
        
        var index = 0;
        var jndex = 0;
        var kndex = jndex + 1;
        
        
        var buyPoint = 0;
        var sailPoint = 0;
        
        var res = 0;
        
        var isBuying:Bool = false;
        
        while jndex <= count - 1 {
            
            let indexV = prices[index];
            let jndexV = prices[jndex];
            let kndexV = prices[kndex];
            
            if(indexV >= jndexV && kndexV >= jndexV){
                //出现低谷点，是买点
                if(isBuying == false){
                    buyPoint = jndex;
                }
                isBuying = true;
                
                index = jndex;
                jndex = index + 1;
                kndex = min(index + 2, count - 1);
                continue;
            }
            
            if(indexV <= jndexV && kndexV <= jndexV && isBuying){
                //出现波峰点，是卖点
                sailPoint = jndex;
                
                //操作买卖
                if(sailPoint > buyPoint){
                    res = res + (prices[sailPoint] - prices[buyPoint]);
                    isBuying = false;
                }
            }
            
            
            index = index + 1;
            jndex = jndex + 1;
            kndex = min(kndex + 1, count - 1);
        }
        
        //如果结果是0，表示函数是单调的，需要判断首尾即可
        if(res == 0){
            let tmpRes = prices.last! - prices.first!;
            res = max(res,tmpRes);
        }
        
        return max(res, 0);
    }
    
    //MARK: - 长度最小的子数组
    /**
     BB两句：双指针法是对付array的问题的一个有力工具。这个解法的巧妙之处在于没有明显的声明两个index进行滑动，并且把判断条件放在了内层循环，巧妙的做到了窗口的收缩和展开。
     left是左边，index是右边。
     总结点：
     1.这种题目的特点是：滑窗+求和，可以记住类似的写法
     2.子序列求和，本题目的思想是：如果left开头的不满足要求，就试试index结尾的。两个维度，可以遍历到所有的子数组
     */
    //解法2,双指针法
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        
        let count = nums.count;
        
        if count == 0 {
            return 0;
        }
        
        if count == 1 {
            
            if nums.first! >= s {
                return 1;
            }else{
                return 0;
            }
        }
        
        var res = 65532;
        
        var sum = 0;
        
        var left = 0;
        //index 和 jndex 双指针, 或者 “滑窗”？
        //看了题解，着实巧妙，不仅减少了求和的一次循环，而且可以巧妙的实现窗口的伸缩，并且最终答案的存储也很没有使用n的空间，值得学习
        
        var isChanged:Bool = false;
        
        for index in 0 ... count - 1{
            
            sum = sum + nums[index];
            
            while(sum >= s){
                
                res = min(res, index - left + 1);
                isChanged = true;
                sum = sum - nums[left];
                left = left + 1;

                
            }
            

        }
        
        if(isChanged){
            return res;
        }else{
            return 0;
        }
    }
    
    //解法1，暴力法，遍历所有的子数组 -- Sad 这个解法TLE了，O(n^3)
    func minSubArrayLen_TLE(_ s: Int, _ nums: [Int]) -> Int {
        
        //结果
        var res:Array<Int> = Array();
        
        let count = nums.count;
        
        if count == 0 {
            return 0;
        }
        
        if count == 1 {
            
            if nums.first! >= s {
                return 1;
            }else{
                return 0;
            }
        }
        
        for index in 0 ... count - 1{
            
            for endIndex in index ... count - 1{
                
                let tmpSum = self.mySum(nums: nums, startIndex: index, endIndex: endIndex);
                
                if(tmpSum >= s){
                    res.append(endIndex - index + 1);
                    break;
                }
            }
        }
        
        guard res.count > 0 else {
            return 0;
        }
        
        return max(res.min()!,0);
    }
    
    /// 求和工具函数，给“【长度最短的子数组】题目使用，就是上面的题目”
    /// - Parameters:
    ///   - nums: 数组
    ///   - startIndex: 开始index
    ///   - endIndex: 结束index
    func mySum(nums:[Int], startIndex:Int ,endIndex:Int) -> Int{
        var sum = 0;
        for index in startIndex ... endIndex {
            sum = sum + nums[index];
        }
        return sum;
    }

    //MARK: - TOP K 问题：两个解法，首先是排序法，快排AC，堆排TLE
    //https://leetcode-cn.com/problems/kth-largest-element-in-an-array/
    
    
    //MARK: 方法2： 快排思想，最终解法（增加随机性导致耗时减少了9倍，是时候需要复习一下随机快排了）
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        
        return self.findKthLargest_partition(nums, k - 1, 0, nums.count - 1);
        
    }
    
    func findKthLargest_partition(_ nums: [Int], _ k: Int, _ start: Int, _ end:Int) -> Int {
        
        //递归的代码没有写对
        if start < end {
            
            var tmpNums = nums;
            let p = self.partition(nums: &tmpNums, startIndex: start, endIndex: end);
            
            if p == k {
                return tmpNums[k];
            }else if p < k {
                return self.findKthLargest_partition(tmpNums, k, p + 1, end);
            }else {
                return self.findKthLargest_partition(tmpNums, k, start, p - 1);
            }
        }else{
            return nums[start];
        }
    }
    
    
    func partition(nums: inout [Int], startIndex:Int, endIndex:Int) -> Int {
        
        //选择数组的最后一个元素作为基准
        let tmpIndex = Int.random(in: startIndex...endIndex);
        nums.swapAt(endIndex, tmpIndex);
        
        let X = nums[endIndex];
        var index = startIndex - 1;
        for jndex in startIndex ... endIndex {
            if(nums[jndex] > X){
                index = index + 1;
                nums.swapAt(index, jndex);
            }
        }
        nums.swapAt(index + 1, endIndex);
        
        return index + 1;
    }

    //MARK: 方法1：排序法(快排AC，堆排TLE了)
    func solutionA_sort(_ nums: [Int], _ k: Int) -> Int {
        let count = nums.count;
        
        if count == 0 {
            return 0;
        }
        
        if count == 1 {
            return nums.first!;
        }
        
        var sortNums = nums;
        self.qSort(&sortNums, 0, count - 1);
        print("排序后");
        print(sortNums);
        
        return sortNums[k-1];
    }
    
    /* 借机复习一下两个排序算法吧... */
    
    //MARK: 堆排
    func heapSort(_ nums: inout [Int], count:Int) -> [Int]{
        
        var sortNums = nums;
        let count = nums.count;
        
        self.buildHeap(&sortNums, count: count);
        //反向遍历
        for index in (1...count - 1).reversed() {
            sortNums.swapAt(0, index);
            self.buildHeap(&sortNums, count: index);
        }
        return sortNums;
        
    }
    
    func buildHeap(_ nums: inout [Int], count:Int){
        //知识点：用数组表示的堆，最后一个非叶子结点是floor(count/2)
        let tmp:Int = Int(floor(Double(count) / 2));
        for index in (0 ... tmp).reversed() {
            self.heapify(&nums, count: count, index: index);
        }
    }
    
    func heapify(_ nums: inout [Int], count:Int, index:Int) {
        let left = index * 2 + 1;
        let right = index * 2 + 2;
        
        var largest = index;
        
        if(left < count && nums[left] < nums[largest]) {
            largest = left;
        }
        
        if(right < count && nums[right] < nums[largest]) {
            largest = right;
        }
        
        if(largest != index){
            nums.swapAt(index, largest);
            self.heapify(&nums, count: count, index: largest);
        }
    }
    
    //MARK: 快排
    func qSort(_ nums: inout [Int], _ startIndex:Int, _ endIndex: Int){
        
        if startIndex < endIndex {
            let q = partition(&nums, startIndex, endIndex);
            self.qSort(&nums, startIndex, q - 1);
            self.qSort(&nums, q+1, endIndex);
        }
        
    }
    
    func partition(_ nums: inout [Int], _ startIndex:Int, _ endIndex:Int) -> Int {
        
        let X = nums[endIndex];
        var iIndex = startIndex - 1;
        
        for jndex in startIndex...endIndex{
            if nums[jndex] > X {
                iIndex = iIndex + 1;
                nums.swapAt(iIndex, jndex);
            }
        }
        nums.swapAt(iIndex + 1, endIndex);
        
        return iIndex + 1;
    }
    
}
