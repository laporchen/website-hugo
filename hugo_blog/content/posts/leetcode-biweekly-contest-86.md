---
title: "Leetcode Biweekly Contest 86 writeup"
date: 2022-09-04T00:09:17+08:00
draft: false 
toc: false
images:
tags:
  - leetcode
  - solution
---


Did today's biweely contest in around 40 minutes. Todays's problems are really weird.

## [Q1 Find Subarrays With Equal Sum](https://leetcode.com/problems/find-subarrays-with-equal-sum/)
**Thoughts : Brute-force**

We only looking for subarray of length two.
So we just iterate through the entire array and insert the sum into a set. If the value is already in the set means we have to subarray with equal sum.

I misunderstood the problem during the contest. Took 9 minutes to do this one. Jeez.

**Solution during contest**
```cpp=
class Solution {
public:
    bool findSubarrays(vector<int>& nums) {
        unordered_set<int> st;
        int cur = 0;
        for(int i = 0;i<nums.size() - 1;++i) {
            if(st.count(nums[i] + nums[i+1])) return true;
            st.insert(nums[i]+nums[i+1]);
        }
        return false;
    }
};
```

## [Q2 Strictly Palindromic Number](https://leetcode.com/problems/strictly-palindromic-number/)
**Thoughts : IDK**

I really don't have a good explaination for this one. I took a wild guess and just return false.

**Solution during contest**
```cpp=
class Solution {
public:
    bool isStrictlyPalindromic(int n) {
        return false;
    }
};
```
## [Q3 Maximum Rows Covered by Columns](https://leetcode.com/problems/maximum-rows-covered-by-columns/)
**Thoughts : Brute-force,bitwise**
The row is covered when all the 1 in this row is in the selected columns, which means row with 1 in those unselected columns is not covered. So we check all the combinations for unselected columns and count the number of uncover rows in these column. We will get the answer by minimize this value. 

The code is spaghetti cus my brain was jammed.
**Solution during contest**
```cpp=
class Solution {
public:
    int maximumRows(vector<vector<int>>& mat, int cols) {
        if(cols == mat[0].size()) return mat.size();
        int n = mat.size();
        int m = mat[0].size();
        cols = m - cols;
        int res = n;
        for(int i = 0;i < (1 << m);++i) {
            int cnt = 0;
            for(int j = 0;j<m;++j) {
                if(i & (1<<j))++cnt;
            }
            if(cnt == cols) {
                set<int> st;
                //cout << i <<endl;
                for(int j = 0;j<m;++j) {
                    if(i & (1<<j)) {
                        //cout << "j = " << j<<endl; 
                        for(int k = 0;k<n;++k) {
                            if(mat[k][j] == 1) {
                                st.insert(k);
                            }
                        }
                    }
                }
                res = min((int)st.size(),res);
        
            }
        }
        return n - res;
        
    }
};
```

## [Q4 Maximum Number of Robots Within Budget](https://leetcode.com/problems/maximum-number-of-robots-within-budget/)
**Thoughts : Greedy, Sliding window**

We can iterate through the robots and add all of them into the selection. If adding the current robot will blow the budget. Then we remove the front robots until the selection is empty or the budget is enough for current robot. The answer is the maxinum number of selection during this loop. 
I use a multiset to record the current maximum chargeTime.

**Solution during contest**
```cpp=
class Solution {
public:
    int maximumRobots(vector<int>& chargeTimes, vector<int>& runningCosts, long long budget) {
        multiset<int> st;
        int n = chargeTimes.size();
        int cnt = 0;
        long long runSum = 0;
        int res = 0;
        for(int i = 0;i<n;++i) {
            while(cnt && (runSum + runningCosts[i])* (cnt+1) + max(*st.rbegin(),chargeTimes[i]) > budget) {
                runSum -= runningCosts[i - cnt];
                st.erase(st.find(chargeTimes[i-cnt]));
                --cnt;
            }
            if(!cnt && (runSum + runningCosts[i])* (cnt+1) + chargeTimes[i] > budget) continue;
            runSum += runningCosts[i];
            st.insert(chargeTimes[i]);
            ++cnt;
            res = max(res,cnt);
        }
        return res;
    }
};
```

