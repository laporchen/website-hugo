---
title: "Leetcode Weekly Contest 305 writeup"
date: 2022-08-10T09:43:09+08:00
draft: false 
toc: false
images:
tags:
  - untagged
---

I'll try to write solutions I came up during the contests. To improve my ability to explain things to others.
現在leetcode每周競賽完來試著寫有解出來的題目的作法，不然我真的不太會跟別人說明我的思路。

## [Q1 Number of Arithmetic Triplets](https://leetcode.com/problems/number-of-arithmetic-triplets/)
**Thoughts : Brute-force**

We are looking for `i<j<k` ,`nums[j] - nums[i] == diff` and `nums[k] - nums[j] == diff`
We just iterate through the array for index j, and an inner loop for index i.
If `nums[j] - nums[i] == diff`, then we can check if the number `nums[j] + diff` exists. If it exist then we found a triplet. 
We don't have to check the index k since the array is strictly increasing.
Make sure the index does not go out of range.
**Solution during contest**
```cpp=
class Solution {
public:
    int arithmeticTriplets(vector<int>& nums, int diff) {
        bool exist[205] = {0};
        int n = nums.size();
        for(int &v:nums) {
            exist[v] = 1;
        }
        int res = 0;
        for(int i = 0;i<n;++i) {
            for(int j = i+1;j<n;++j) {
                if(nums[j] - nums[i] <= nums[n-1] && nums[j] - nums[i] == diff) {
                    if(nums[j] + diff <= 200 && exist[nums[j] + diff]) {
                        ++res;
                    }
                }
            }
        }
        return res;
    }
};
```

## [Q2 Reachable Nodes With Restrictions](https://leetcode.com/problems/reachable-nodes-with-restrictions/)
**Thoughts : BFS**
The problem asks for the maximum nodes we can reach from 0 without touching the restricted nodes. Since it is a tree, so the restricted is just ignore every restricted nodes and their child nodes. 
A breadth-first search over the tree can find the answer. Use a set to check if the current node is restricted. Only add unrestriced nodes to the queue.

**Solution during contest**
```cpp=
class Solution {
public:
    set<int> no;
    vector<int> adjs[100005];
    int reachableNodes(int n, vector<vector<int>>& edges, vector<int>& restricted) {
        for(int &v:restricted) no.insert(v);
        for(auto &e:edges) {
            adjs[e[0]].push_back(e[1]);
            adjs[e[1]].push_back(e[0]);
        }
        int vis[100005] = {0};
        queue<int> q;
        q.push(0);
        int res = 0;
        while(q.size()) {
            int n = q.size();
            while(n--) {
                auto f = q.front();q.pop();
                if(vis[f]) continue;
                vis[f] = true;
                ++res;
                for(auto adj:adjs[f]) {
                    if(no.count(adj)) {
                        continue;
                    }
                    
                    q.push(adj);
                }
            }
        }
        return res;
    }
};
```
## [Q3 Check if There is a Valid Partition For The Array](https://leetcode.com/problems/check-if-there-is-a-valid-partition-for-the-array/)
**Thoughts : DP**
We prepare an array `part` to memorize the state of the of the dp.
The value of `part[i]` means if we can make a valid partition from 0 to i-1.
if we can make a valid partition for the subarray until current index. Then we can check the the three condition starts from the current index.

**Solution during contest**
```cpp=
class Solution {
public:
    bool validPartition(vector<int>& nums) {
        bool part[100005] = {0};
        int n = nums.size();
        nums.push_back(-1);
        nums.push_back(-1);
        part[0] = true;
        int cnt = 1;
        bool inc = true;
        bool prev = -1;
        for(int i = 0;i<n;++i) {
            if(part[i] && nums[i] == nums[i+1]) {
                part[i+2] = true;
            }
            if(part[i] && nums[i+1] == nums[i] && nums[i+2] == nums[i]) {
                part[i+3] = true;
            }
            if(part[i] && nums[i] + 1 == nums[i+1] && nums[i] + 2 == nums[i+2]) {
                part[i+3] = true;
            }
        }

        return part[n];
    }
};
```

## [Q4 Longest Ideal Subsequence](https://leetcode.com/problems/longest-ideal-subsequence/)
**Thoughts : LIS variation**
You can check [here](https://web.ntnu.edu.tw/~algo/Subsequence.html) if you are not familiar with LIS.
We only have `a ~ z` for our characters. So we can update the subsequence ends with `s[i]` with subsequences ends in `(s[i] - k) ~ (s[i] + k)`, we do at most 26 updates in every iteration.
Time complexity is O(26 * N)

**Solution during contest**
```cpp=
class Solution {
public:
    int longestIdealString(string s, int k) {
        int n = s.size();
        int len[26] = {0};
        for(int i = 0;i<n;++i) {
            int c = s[i] - 'a';
            ++len[c];
            for(int j = max(0,c-k); j <= min(25,c+k);++j) {
                if(c == j) continue;
                len[c] = max(len[c],len[j] + 1);
            }
            
        }
        int res = 0;
        for(int i = 0;i<26;++i) {
            res = max(res,len[i]);
        }
        return res;
    }
};
```

