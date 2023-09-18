## 함수 선언부


## 전역 선언부
katok = ["다현", "정연", "쯔위", "사나", "지효"]

## 메인 코드부
print(katok)
## 데이터 추가 (모모가 카톡 1회)
# 1단계: 빈칸 확보
katok.append(None)
katok[5] = "모모"
print(katok)

## 데이터 삽입(미나가 카톡 연속 48회)
# 1단계: 빈칸확보
katok.append(None)
# 2단계: 한칸씩 뒤로 이동(3등자리까지)
katok[6] = katok[5]
katok[5] = None
katok[5] = katok[4]
katok[4] = None
katok[4] = katok[3]
katok[3] = None
# 3단계: 사나를 빈자리에 넣기
katok[3] = "미나"
print(katok)


## 데이터 삭제 (사나가 카톡 차단)
# 1단계: 지우기
katok[4] = None
print(katok)
# 2단계: 한칸씩 앞으로 이동
katok[4] = katok[5]
katok[5] = None
katok[5] = katok[6]
katok[6] = None
print(katok)
# 3단계: 빈칸 제거
del katok[6]
print(katok)
