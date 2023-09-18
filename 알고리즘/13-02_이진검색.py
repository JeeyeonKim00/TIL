## 함수
import random


def binSearch(ary, fData):
    global count
    pos = -1  # 데이터 없다는 의미
    start = 0
    end = len(ary) - 1

    while start <= end:  # 시작> 끝: 데이터 없다는 것
        count += 1
        mid = (start + end) // 2
        if ary[mid] == fData:
            pos = mid
            break
        elif ary[mid] < fData:
            start = mid + 1
        else:  # ary[mid]>fData
            end = mid - 1

    return pos


## 변수
count = 0
dataAry = [random.randint(30, 10000000) for _ in range(1000000)]
findData = random.choice(dataAry)
dataAry.sort()

## 메인
print("배열 -->", dataAry)
position = binSearch(dataAry, findData)
if position == -1:
    print(findData, "는 없어요.ㅠㅠ")
else:
    print(findData, "는", position, "번째 있어요.", count)
