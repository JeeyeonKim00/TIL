## 함수
def addNumber(num):
    if num == 1:
        return 1
    return num + addNumber(num - 1)


## 메인
print(addNumber(100))

# -> 100 + addNumber(99)
# -> 100 + 99 + addNumber(98)
# -> 100 + 99 + 98 + addNumber(97)....
# ...
# -> 100 + 99+ 98+ ... + 3+num(2) = > num =3
# -> 100 + 99 + 98 + ... + 3 + 2 + addNumber(1) -> num =2
# -> 100 + 99 + 98 + ... + 3 + 2 + 1 + addNumber(0) => num = 1
