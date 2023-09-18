## 함수
import random


def seqSearch(ary, fData):
    pos = -1
    for i in range(len(ary)):
        if ary[i] == fData:
            pos = i
            break
    return pos


## 변수
dataAry = [random.randint(30, 200) for _ in range(8)]
findData = random.choice(dataAry)

## 메인
print("배역 -->", dataAry)
position = seqSearch(dataAry, findData)
# dataAry에서 findData 찾아서 알려줘

if position == -1:
    print(findData, "는 없어요. ㅠㅠ")
else:
    print(findData, "는", position, "번째에 있어요!")
