# 기술면접 플래시 카드, TEKA(Technical Card)
## Description
> 2022-06-13 ~ 2022-07-29
## Contents
:paperclip: 국비지원학원 수료 팀 프로젝트

## Tech
&#128076;&#128076;&#128076;<br/>
<img src="https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white"/>
<img src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white"/>
<img src="https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white"/>
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=white"/>
<img src="https://img.shields.io/badge/Java-007396?style=flat-square&logo=oracle&logoColor=white"/>
<img src="https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=spring&logoColor=white"/>
<img src="https://img.shields.io/badge/Eclipse-2C2255?style=flat-square&logo=eclipse&logoColor=white"/>
<img src="https://img.shields.io/badge/Amazon RDS-527FFF?style=flat-square&logo=amazonrds&logoColor=white"/>
<img src="https://img.shields.io/badge/Amazon EC2-FF9900?style=flat-square&logo=amazonec2&logoColor=white"/>
<br/>
<img src="https://img.shields.io/badge/jQuery-0769AD?style=flat-square&logo=jquery&logoColor=white"/>
<img src="https://img.shields.io/badge/mariaDB-003545?style=flat-square&logo=mariadb&logoColor=white"/>

## Summaary
기술면접을 대비하여 주요 CS지식을 학습할 수 있는 웹 플래시 카드 제작하기
로그인한 사용자가 직접 카드를 생성해서 학습 가능 
다른 사람이 만든 학습세트를 나만의 학습 카드로 수정해서 학습 가능


## Role
* 공통 : DB모델링(ERD), UML(유즈케이스다이어그램), 페이지 레이아웃 
* 김병국: 로그인, 카드 플립 및 슬라이드, 카드 학습(낱말카드, 시험보기, 관심질문), 메일인증
* 류다희: 회원가입, 헤더, AWS 서버 구축 및 DB호스팅, 출석체크, 회원정보 관리
* 김다정: 튜토리얼, 헤더, 카드 플립 및 슬라이드, 카드 만들기 및 미리보기, 카드 학습(시험보기)

## Function
👇 <h3>로그인</h3>
1. OAuth2.0 기술을 사용한 네이버와 구글 소셜 로그인 및 회원가입 기능
2. 일반 회원가입을 진행한 사용자가 입력한 아이디 비밀번호는 RSA알고리즘을 사용하여 암호화 후에 서버로 전송
![image](https://user-images.githubusercontent.com/87313203/181677954-46f81db6-4299-477b-b797-4113f46415de.png)

👇 <h3>회원가입</h3>
1. 입력한 데이터를 ajax통신을 사용하여 실시간으로 중복 체크
2. 중복값이 없는 경우에만 가입하기 버튼 활성화</br>
![image](https://user-images.githubusercontent.com/87313203/181678428-33e95bcf-6628-4911-a4d6-e250df7d3ed0.png)


👇 <h3>이메일 인증</h3>
1. 난수를 생성하여 사용자의 이메일로 인증번호를 전송
2. 인증번호를 정확하게 입력할 경우 비밀번호 찾기 & 수정 가능</br>
![image](https://user-images.githubusercontent.com/87313203/181678237-ec327ab4-150d-46f7-a0ba-8dce101af56d.png)


👇 <h3>전체 카드 모아보기</h3>
1. 카드 제목과 소개글
2. 페이징 처리 
3. 토글 방식의 추천
4. 미리보기를 통해 카드에 내장된 전체 질문 & 답변 미리보기 
5. 내 학습세트에 추가하여 학습하기</br> 
![image](https://user-images.githubusercontent.com/87313203/181678565-915c4027-5d4b-49ec-bd76-d8af2546c64a.png)

👇 <h3>학습세트 직접 만들기</h3>
1. 주제 선택 
2. 제목 & 소개글 작성
3. 카드에 포함될 질문&답변 작성 -> 동적으로 행 추가  </br>
![image](https://user-images.githubusercontent.com/87313203/181678784-f9e9bcd7-7336-463b-8eea-7d6be1e73bc1.png)


👇 <h3>나의 학습 세트</h3>
1. 카드 학습 공간으로 이동해서 카드를 학습할 수 있다. 
2. 학습이 끝난 카드는 나의 학습세트에서 삭제 
3. 내가 만든 카드는 수정가능 -> 기존 질문 내용 수정 및 새로운 질문 추가 가능 
4. 타인이 만든 카드는 커스터마이징 가능 -> 기존 질문 내용 수정 및 새로운 질문 추가 가능</br>
![image](https://user-images.githubusercontent.com/87313203/181679153-49471271-7414-40a1-bc83-c1b5e67da065.png)

👇 <h3>카드 학습하기(Main)</h3>
1. 학습 방법 선택 -> 낱말카드 암기, 카드 시험보기, 틀린 질문 or 관심 질문만 모아서 보기 
2. 카드 슬라이드 및 플립 기능 
3. 학습전 전체 내용 확인하기(미리보기와 같은 기능)</br>
![image](https://user-images.githubusercontent.com/87313203/181679387-6bc698be-3bb5-4e74-acd8-08468a189c88.png)

👇 <h3>카드 학습하기(Word)</h3>
1. 토글 방식의 즐겨찾기 기능 
2. 학습 진행을 나타내는 프로그래스 바
3. 자동 슬라이드 기능 
4. 질문의 순서 셔플 기능</br>
![image](https://user-images.githubusercontent.com/87313203/181679556-b087c52d-4b1f-4c11-b879-f502db692830.png)

👇 <h3>카드 학습하기(Test)</h3>
1. 3지 선다의 보기 
2. 정답시 슬라이드 이동 
3. 오답시 해당 질문을 틀린 문제로 자동 추가하고 슬라이드 이동</br>

정답
![image](https://user-images.githubusercontent.com/87313203/181681270-e26ac481-71d5-4e47-a919-29c375b288b7.png)

오답
![image](https://user-images.githubusercontent.com/87313203/181679718-eb592386-58cc-46cb-9ac3-1d83363fdd4f.png)

👇 <h3>마이페이지</h3>
1. 캘린더 라이브러리를 사용한 출석체크 기능 
2. 회원정보 수정
3. 관리자 문의 기능</br>
![image](https://user-images.githubusercontent.com/87313203/181680071-c536ca02-879d-4196-90cc-abd426d78d5f.png)
