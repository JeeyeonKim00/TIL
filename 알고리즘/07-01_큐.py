## 함수


## 변수
SIZE = 5
# 스택, 큐는 '내가 이걸 어떻게 조작하는가'에 따라 달라지는 것
queue = [None for _ in range(SIZE)]
front = rear = -1


## 메인


## enQueue()
rear += 1
queue[rear] = "화사"

rear += 1
queue[rear] = "솔라"

rear += 1
queue[rear] = "문별"


print(f"출구 <--{queue} <-- 입구")


## deQueue()
front += 1
data = queue[front]
queue[front] = None
print(f"식사손님 : {data}")
print(queue)

front += 1
data = queue[front]
queue[front] = None
print(f"식사손님 : {data}")
print(queue)

front += 1
data = queue[front]
queue[front] = None
print(f"식사손님 : {data}")
print(queue)
