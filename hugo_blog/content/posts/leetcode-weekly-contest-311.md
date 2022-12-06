---
title: "Leetcode Weekly Contest 311 writeup"
date: 2022-09-19T01:05:42+08:00
draft: false
toc: false
images:
tags:
  - leetcode
  - solution
---

Didn't participate in this one. But tried virtual contest.

## [Q1 Smallest Even Multiple](https://leetcode.com/problems/smallest-even-multiple/)
**Thoughts : Logic**

Basically asking for LCM(n,2)

**Solution during contest**
```cpp=
class Solution {
public:
    int smallestEvenMultiple(int n) {
        return n&1 ? n * 2 : n;
    }
};
```

## [Q2 Length of the Longest Alphabetical Continuous Substring](https://leetcode.com/problems/length-of-the-longest-alphabetical-continuous-substring/)
**Thoughts : Greedy**

We want to find the longest alphabetical continuous. So we start from index 0, we check the what should the next alphabet letter should be. If the current one is not the expecting letter. We change the beginning to this one and continue check the rest of the string. Otherwise, we increase the length and check next letter.

**Solution during contest**
```cpp=
class Solution {
public:
    int longestContinuousSubstring(string s) {
        int cur = 1;
        int res = 1;

        for(int i = 1;i<s.size();++i) {
            if(s[i] == s[i-1] + 1) {
                ++cur;
                res = max(res,cur);
            }
            else {
                cur = 1;
            }
            if(res == 26) return res;
        }
        return res;
    }
};
```
## [Q3 Reverse Odd Levels of Binary Tree](https://leetcode.com/problems/reverse-odd-levels-of-binary-tree/)
**Thoughts : BFS**

We want to reverse the odd levels. We keep a number that tracking the current level. If the level is odd. We pop everything out of the queue and reverse the values. The rest of it is just basic BFS.

**Solution during contest**
```cpp=
class Solution {
public:
    TreeNode* reverseOddLevels(TreeNode* root) {
        queue<TreeNode*> q;
        q.push(root);
        int l = 0;
        while(!q.empty()) {
            int n = q.size();
            if(l & 1) {
                vector<TreeNode*> v(n);
                while(n--) {
                    auto f = q.front();q.pop();
                    v[n] = f;
                    if(f->left) q.push(f->left);
                    if(f->right)q.push(f->right);
                }
                int li = 0,ri = v.size()-1;
                while(li < ri) {
                    int tmp = v[li]->val;
                    v[li]->val = v[ri]->val;
                    v[ri]->val = tmp;
                    ++li;
                    --ri;
                }
            }
            else {
                while(n--) {
                    auto f = q.front();q.pop();
                    if(f->left) q.push(f->left);
                    if(f->right) q.push(f->right);
                }
            }
            ++l;
        }
        
        return root;
    }
};
```

## [Q4 Sum of Prefix Scores of Strings](https://leetcode.com/problems/sum-of-prefix-scores-of-strings/)
**Thoughts : Trie**

For every string, the score of it is the sum of all prefix string include itself. When we insert a word into trie. Add one score for each node in the path. After every word is added. We can calculate the score for each word by add all the score in the search path.

**Solution during contest**
```cpp=
class Node {
public:
    Node* next[26];
    int val = 0;
    Node() = default;
};
class Solution {
public:
    Node* root = new Node();
    void insert(string &s) {
        int n = s.size();
        auto cur = root;
        for(int i = 0;i<n;++i) {
            int c = s[i] - 'a';
            if(cur->next[c] == nullptr) {
                cur->next[c] = new Node();
            }
            cur->next[c]->val++;
            cur = cur->next[c];
        }
    }
    int sum(string &s) {
        int n = s.size();
        int res = 0;
        auto cur = root;
        for(int i = 0;i<n;++i) {
            int c = s[i] - 'a';
            res += cur->next[c]->val;
            cur = cur->next[c];
        }
        return res;
    }
    vector<int> sumPrefixScores(vector<string>& words) {
        int n = words.size();
        unordered_map<string,int> mp;
        vector<int> res(n,0);
        for(int i = 0;i<n;++i) {
            insert(words[i]);
        }
        for(int i = 0;i<n;++i) {
            string &s = words[i];
            res[i] = sum(s);
        }
        return res;
    }
};
```
