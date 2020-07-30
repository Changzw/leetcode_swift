//
//  1. pow(n,m).swift
//  leetCode
//
//  Created by czw on 7/26/20.
//  Copyright © 2020 czw. All rights reserved.
//

import Foundation

/*
 难度：中等
 https://leetcode-cn.com/problems/powx-n/
 实现 pow(x, n) ，即计算 x 的 n 次幂函数。
 
 示例 1:
 输入: 2.00000, 10
 输出: 1024.00000
 
 示例 2:
 输入: 2.10000, 3
 输出: 9.26100
 
 示例 3:
 输入: 2.00000, -2
 输出: 0.25000
 解释: 2-2 = 1/22 = 1/4 = 0.25
 
 说明:
 -100.0 < x < 100.0
 n 是 32 位有符号整数，其数值范围是 [−231, 231 − 1] 。
 
 
 分冶
 当为 奇数
 f(n) = f(n-1/2) * f(n-1/2) * f(1)
 当为 偶数
 f(n) = f(n/2) * f(n/2)
 
 f(1) = x
 */

class PowXN {
  func myPow(_ x: Double, _ n: Int) -> Double {
    if n == 1 { return x }
    if n == -1 { return 1/x }
    if n == 0 { return 1 }
    
    if n % 2 == 0 { // 偶数
      let y = myPow(x, n/2)
      return y * y
    }else {
      let m = n - 1
      let y = myPow(x, m/2)
      return y * y * x
    }
  }
  
  func myPow_(_ x: Double, _ n: Int) -> Double {
    if n == 1 { return x }
    if n == -1 { return 1/x }
    if n == 0 { return 1 }
    
    var res: Double!
    var i: Int!
    
    if n % 2 == 0 {
      res = 1
      i = n
    }else {
      res = x
      i = n - 1
    }
    
    if i > 0 {
      while i != 1 {
        res *= res
        i /= 2
      }
    }else {
      
    }
    return res
  }
}

extension PowXN: Algorithm {
  func doTest() {
    performLogCostTime(self.name + "method1") {
      print(self.myPow(4,-4))
    }
  }
}


