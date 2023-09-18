## 함수
def isStackFull():
    global SIZE, stack, top
    if top == SIZE - 1:  # top >= SIZE -1 도 괜츈
        return True
    else:
        return False


def push(data):
    global SIZE, stack, top
    if isStackFull() == True:
        print("스택 full!")
        return
    top += 1
    stack[top] = data


def isStackEmpty():
    global SIZE, stack, top
    if top <= -1:  # top <= -1 을 더 많이 씀.
        return True
    else:
        return False


def pop():
    global SIZE, stack, top
    if isStackEmpty():  # == True: 를 굳이 쓸 필욘없음.
        print("스택이 비었습니다.")
        return
    data = stack[top]
    stack[top] = None
    top -= 1
    return data


def peek():
    global SIZE, stack, top
    if isStackEmpty():
        print("스택이 비었!!습니다.")
        return
    return stack[top]


## 변수
SIZE = 5
stack = [None for _ in range(SIZE)]
top = -1

## 메인

push("커피")
push("녹차")
# push("꿀물")
# push("콜라")
# push("환타")
# print("바닥: ", stack)

# push("게토레이")
print("바닥: ", stack)

retData = pop()
print("팝한 것-->", retData)

print("다음후보-->", peek())
retData = pop()

print("팝한 것-->", retData)
retData = pop()
print("팝한 것-->", retData)
print("바닥:", stack)
