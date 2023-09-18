# 범용적 코드


## 함수
def add_data(friend):
    katok.append(None)  # 1단계: 빈칸 추가
    kLen = len(katok)  # 배열의 길이 파악
    katok[kLen - 1] = friend


def insert_data(position, friend):
    katok.append(None)
    kLen = len(katok)

    # 2단계; 한칸씩 오른쪽으로 이동
    for i in range(kLen - 1, position, -1):  # 어려움!
        katok[i] = katok[i - 1]
        katok[i - 1] = None
    # 3단
    katok[position] = friend


def delete_data(position):
    katok[position] = None
    kLen = len(katok)
    for i in range(position + 1, kLen):
        katok[i - 1] = katok[i]
        katok[i] = None
    # 3단계: 마지막 칸 삭제
    del katok[kLen - 1]


## 변수
katok = []

## 메인
add_data("다현")
add_data("정연")
add_data("쯔위")
add_data("사나")
add_data("지효")
print(katok)
add_data("모모")
print(katok)

insert_data(3, "미나")
print(katok)

delete_data(4)
print(katok)
