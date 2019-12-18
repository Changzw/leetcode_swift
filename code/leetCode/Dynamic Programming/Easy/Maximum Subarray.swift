//
//  Maximum Subarray.swift
//  leetCode
//
//  Created by czw on 12/6/19.
//  Copyright © 2019 czw. All rights reserved.
//

import Foundation
//https://leetcode.com/problems/maximum-subarray/

/*
 Given an integer array nums,
 find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.
 
 Example:
 
 Input: [-2,1,-3,4,-1,2,1,-5,4],
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 Follow up:
 
 If you have figured out the O(n) solution,
 try coding another solution using the divide and conquer approach, which is more subtle.
 */

class MaximumSubarray {
// 暴力求解
  /*
   遍历所有
   O(n³)
   */
  func maxSubArray(_ nums: [Int]) -> Int {
    var currentSum = 0, maxSum = Int.min
    var i = 0, j = 0, k = 0
    while i<nums.count {
      j = i
      while j<nums.count {
        k = i
        while k<=j {
          currentSum += nums[k]
          if currentSum > maxSum {
            maxSum = currentSum
          }
          k += 1
        }
        j += 1
      }
      i += 1
    }
    return 0
  }
  
//  在 1 上优化，减少一层循环 O(n²)
  func maxSubArray2(_ nums: [Int]) -> Int {
    var currentSum = 0, maxSum = Int.min
    var i = 0, j = 0
    while i<nums.count {
      j = i
      while j<nums.count {
        currentSum += nums[j]
        if currentSum > maxSum {
          maxSum = currentSum
        }
        j += 1
      }
      i += 1
    }
    return 0
  }
  
  /*
   divide and conquer
   分成三个子问题处理
   左边：maxLeft  = maxSubArray(nums, left, (right+left)/2)
   右边：maxRight = maxSubArray(nums, (right+left)/2, left)
   中间：包含left部最右边的元素的 maxSum0 和 包含right最左边元素的最大maxSum1
        maxMid   = maxSum0 + maxSum1
   终止条件
        left >= right
   */
  func maxSubArray3(_ nums: [Int]) -> Int {
    func maxSubArray(_ nums: [Int], left: Int, right: Int) -> Int{
      if left >= right {
        return nums[left]
      }
      let mid = (left + right) / 2
      let maxLeftSum  = maxSubArray(nums, left: left, right: mid)
      let maxRightSum = maxSubArray(nums, left: mid+1, right: right)
      
      var maxLeftBorderSum = Int.min, maxRightBorderSum = Int.min, leftBorderSum = 0, rightBorderSum = 0
      var i = mid, j = mid + 1
      while i >= left {
        leftBorderSum += nums[i]
        if leftBorderSum > maxLeftBorderSum {
          maxLeftBorderSum = leftBorderSum
        }
        i -= 1
      }
      
      while j <= right {
        rightBorderSum += nums[j]
        if rightBorderSum > maxRightBorderSum {
          maxRightBorderSum = rightBorderSum
        }
        j += 1
      }
      
      return max(maxLeftSum, maxRightSum, maxLeftBorderSum + maxRightBorderSum)
    }
    
    return maxSubArray(nums, left: 0, right: nums.count - 1)
  }

//when it comes to DP, the first thing for us to figure out is the format of the sub problem(or the state of each sub problem).
//The format of the sub problem can be helpful when we are trying to come up with the recursive relation.
  func maxSubArray4(_ nums: [Int]) -> Int {
    var maxCurrentSum = nums[0], maxSum = nums[0], i = 0
    while i<nums.count {
      maxCurrentSum = max(nums[i], maxCurrentSum + nums[i])
      maxSum = max(maxCurrentSum, maxSum)
      i += 1
    }
    
    return maxSum
  }
}

extension MaximumSubarray: Algorithm {
  var name: String{
    return "Maximum Subarray"
  }
  
  func doTest() {
    performLogCostTime(self.name+"0") {
      print(maxSubArray3([-2,1,-3,4,-1,2,1,-5,4]))
    }
    
    
    performLogCostTime(self.name+"1") {
      print(maxSubArray4([-2,1,-3,4,-1,2,1,-5,4]))
    }

  }
}
