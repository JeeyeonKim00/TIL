## 함수
import random


def findMinIndex(ary):
    minIdx = 0
    for i in range(1, len(ary)):
        if ary[minIdx] > ary[i]:
            minIdx = i
    return minIdx


## 전역
testAry = [random.randint(30, 200) for _ in range(20)]

## 메인
minPos = findMinIndex(testAry)
print(testAry)
print("최솟값-->", testAry[minPos])
