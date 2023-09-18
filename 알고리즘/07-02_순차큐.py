## 함수
def isQueueFull():
    global SIZE, queue, front, rear
    if rear >= SIZE - 1:
        return True  # 큐가 다 찼어.
    else:
        return False  # 큐가 다 차지 않았어.


def isQueueEmpty():
    global SIZE, queue, front, rear
    if rear == front:
        return True  # 큐는 텅 비었다.
    else:
        return False


def enQueue(data):
    global SIZE, queue, front, rear

    if isQueueFull():
        print("큐 꽉 찼어.")
        return

    rear += 1
    queue[rear] = data


def deQueue():
    global SIZE, queue, front, rear

    if isQueueEmpty():
        print("큐는 텅 ~비었어요")
        return
    front += 1
    data = queue[front]
    queue[front] = None
    return data


def peek():
    global SIZE, queue, front, rear
    if isQueueEmpty():
        print("큐는 텅 ~비었어요")
        return

    return queue[front + 1]


## 변수
SIZE = 5
# 스택, 큐는 '내가 이걸 어떻게 조작하는가'에 따라 달라지는 것
queue = [None for _ in range(SIZE)]
front = rear = -1


# 메인

enQueue("화사")
enQueue("솔라")
# enQueue("문별")
# enQueue("휘인")
# enQueue("선미")

# print(f"출구<--{queue}<--입구")


# enQueue("재남")
print(f"출구<--{queue}<--입구")

retData = deQueue()
print("**식사 손님: ", retData)
print("곧 들어가요. 준비하세요-->", peek())


retData = deQueue()
print("**식사 손님: ", retData)

print(f"출구<--{queue}<--입구")

retData = deQueue()
print("**식사 손님: ", retData)
