## 함수
import random


def findMinIndex(ary):
    minIdx = 0
    for i in range(1, len(ary)):
        if ary[minIdx] > ary[i]:
            minIdx = i
    return minIdx


## 변수
before = [random.randint(30, 200) for _ in range(10)]
after = []  # 정렬 후


## 메인
print("정렬 전 -->", before)
for _ in range(len(before)):
    minPos = findMinIndex(before)
    after.append(before[minPos])
    del before[minPos]
print("정렬 후 -->", after)

