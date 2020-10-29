# :memo: Sprint
## :books: Sprint Backlog
[Google Spreadsheet :link:](https://docs.google.com/spreadsheets/d/19wkM--KlfBSZAe7_RBzZKZ5Rq0YNnLkuxhtWNhTGxDA/edit?usp=sharing)

## 👩‍💻👨‍💻 개발자
#### 🐳 : [권예지](https://github.com/Yejikwon)
#### 🐹 : [김도연](https://github.com/do02reen24)
#### 🐕 : [윤영우](https://github.com/yoonwoo123)

-----
# Back end
## :computer: **`Sprint #1 - Day3`**
### 📌 [BE] 코딩 컨벤션 작성
* [코딩컨벤션 작업 결과 :link:](https://github.com/boostcamp-2020/IssueTracker-08/wiki/Javascript-%EC%BD%94%EB%94%A9-%EC%BB%A8%EB%B2%A4%EC%85%98)
* TOAST와 Google의 코딩 컨벤션을 기반으로 코딩 컨벤션을 결정하였다.

### 📌 [BE] issue CRUD API, query문 틀 구성 
* 관련 PR : `#81`
* 작업 스타일을 맞추기 위해 첫 API는 화면을 공유하며 팀원 전원이 참여하여 개발하였다.


### 📌 [BE] Datebase 스키마 변경
* 관련 issue : `#15`
- user 테이블`email` 컬럼 추가
  - 기존에 user 테이블에서 사용자 로그인 정보에서 `name` 만 저장하도록 했는데, API를 구현하면서 `email`정보도 추가로 필요함을 느껴 추가하였다. 
- milestone 테이블 컬럼 일부 수정
    - 이슈 open, close 관리하던 컬럼을 삭제하였다.
    - 매 issue 변경 시마다 트리거로 관리하는 횟수보다, milestone 페이지에 사용자가 들어왔을 때 issue 개수를 확인하는 횟수가 적을 것으로 판단해서 변경하였다.
- issue_label table 수정
    - 연결이 user table에 잘못 연결 되어 있어서 올바르게 수정

### 📌 [BE] VSCode 확장 파일 설정

- eslint, prettier의 설정을 팀원 모두 동일하게 설정하였다.
    - eslint 스페이스 2칸, ; 생성

## :computer: **`Sprint #1 - Day4`**
### 📌 [BE] issue return 형식
~~~
[
  {
    "issueId": 1,
    "username": "lala", 
    "userEmail": "lala@github.io",
    "title": "view create",
    "content": "",
    "isOpen": true,
    "milestone": "IOS",
    "label": ["IOS", "Swift"],
    "assign": ["why"],
    "createAt": "2020-10-28T10:01:49.000Z",
    "closeAt": "2020-10-28T10:01:49.000Z"
    },
]
~~~
### 📌 [BE] content not null 조건을 null로 변경

- 화면에서 content가 비어있을 경우 `no description provided` 메세지를 다른 글씨로 띄워주기 위해서 `null`로 content로 설정가능하게 하였다.
    - NOT NULL 제거
