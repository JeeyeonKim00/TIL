## 함수
class Node:
    def __init__(self):
        self.data = None
        self.link = None


def printNodes(start):
    current = start
    print(current.data, end=" ")
    while current.link != None:
        current = current.link
        print(current.data, end=" ")
    print()


def insertNode(findData, insertData):
    global memory, head, pre, current
    # Case1. 헤드 앞에 삽입 (다현 앞에 화사)
    if head.data == findData:
        node = Node()
        node.data = insertData
        node.link = head
        head = node
        memory.append(node)
        return  # 함수 그만~이라는 뜻

    # Case2. 중간 노드 앞에 삽입(사나 앞에 솔라 넣어줘)
    current = head
    while current.link != None:  # 마지막 노드가 아닐때까지 찾아바
        pre = current
        current = current.link
        if current.data == findData:
            node = Node()
            node.data = insertData
            node.link = current
            pre.link = node
            memory.append(node)
            return

    # Case3. 없는 노드 앞에 삽입(재남 앞에 문별)
    node = Node()
    node.data = insertData
    current.link = node
    memory.append(node)
    return  # 안써도 됨


def deleteNodes(deleteData):
    global memory, head, pre, current

    # case 1: 헤드를 삭제(다현)
    if deleteData == head.data:
        current = head
        head = head.link
        del current
        return

    # case 2: 중간 노드를 삭제(쯔위)
    current = head
    while current.link != None: # = 마지막 데이터가 아니라면
        pre = current
        current = current.link
        if current.data == deleteData:
            pre.link = current.link
            del current
            return
        
    # case 3: 없는 노드 지우기(재남)
    return

def findNode(findData):
    global memory, head, pre, current
    current = head
    if current.data == findData: # head가 내가 찾는 데이터일때
        return current
    while (current.link !=None): 
        current = current.link
        if (current.data == findData):
            return current
    return Node()

## 전역
memory = []
head, pre, current = None, None, None
dataAry = ["다현", "정연", "쯔위", "사나", "지효"]

## 메인
node = Node()
node.data = dataAry[0]  # 다현
head = node
memory.append(node)  # 중요치 X


for data in dataAry[1:]:
    pre = node
    node = Node()
    node.data = data
    pre.link = node
    memory.append(node)
printNodes(head)

# # insertNode('다현','화사') # 다현 찾아서 그 앞에 화사 삽입해
# # printNodes(head)

# insertNode("사나", "솔라")
# printNodes(head)


# insertNode('재남','문별')
# printNodes(head)

# deleteNodes("쯔위")
# printNodes(head)

retNode = findNode('지효')
print(retNode.data, '뮤비가 나옵니다. 쿵짝쿵짝~~')
