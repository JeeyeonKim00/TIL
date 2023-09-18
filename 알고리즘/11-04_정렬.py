## 함수
import random

# def selectSort(ary):
#     n = len(ary)
#     for i in range(0, n-1): # 사이클 3번
#         minIdx = 0
#         for k in range(1,n):
#             if ary[minIdx]>ary[k]:
#                 minIdx = k # 해피 찾은 것임
#         ary[0],ary[minIdx] = ary[minIdx], ary[0] # 서로 자리 바꿔줌
#     return ary            


def selectSort(ary): # 어렵다면 외워도 괜찮음.
    n = len(ary)
    for i in range(0, n-1): # 사이클 3번
        minIdx = i
        for k in range(i+1,n):
            if ary[minIdx]>ary[k]:
                minIdx = k # 해피 찾은 것임
        ary[i],ary[minIdx] = ary[minIdx], ary[i] # 서로 자리 바꿔줌
    return ary      




## 변수
dataAry = [random.randint(30, 200) for _ in range(10)]


## 메인
print("정렬 전 -->", dataAry)
dataAry = selectSort(dataAry)
print("정렬 후 -->", dataAry)