# :memo: Sprint
## :books: Sprint Backlog
[Google Spreadsheet :link:](https://docs.google.com/spreadsheets/d/19wkM--KlfBSZAe7_RBzZKZ5Rq0YNnLkuxhtWNhTGxDA/edit?usp=sharing)

## 👩‍💻👨‍💻 개발자
#### 🐳 : [권예지](https://github.com/Yejikwon)
#### 🐹 : [김도연](https://github.com/do02reen24)
#### 🐕 : [윤영우](https://github.com/yoonwoo123)

-----
# Back end
## :computer: **`Sprint #1 - Day5`**
### 📌 [BE] Sprint 1에서 개발한 feature branch -> Dev-Server로 Merge 진행
- [dev-server <- feat-issue-api merge](https://github.com/boostcamp-2020/IssueTracker-08/pull/97)
- [dev-server <- feat-milestone-api merge](https://github.com/boostcamp-2020/IssueTracker-08/pull/98)
- [dev-server <- Feat signin api Merge](https://github.com/boostcamp-2020/IssueTracker-08/pull/101)

> 충돌을 어떻게 해결하는 게 가장 좋을까?
- 팀원들이 같이 있으면서 코드를 본다.
- `fork` 등의 github GUI 툴을 사용하여 브랜치와 저장소 관리의 도움을 받으면 더 쉽다.
- 충돌이 크지 않다면 github web 편집으로 쉽게 merge할 수 있다.

> sub query
```mysql
GET_OPEN_ISSUES:
  `SELECT issue.id as issueId, < 3번 : issue.id를 가져와서 issueID라 정의
  
  (SELECT user.email FROM user WHERE user.id = issue.userId) as email, < 4번 : where이 성립할 때 유저의 email 가져와서 email이라 정의 이하 동문
  
  (SELECT user.name FROM user WHERE user.id = issue.userId) as name,
  
  (SELECT milestone.title FROM milestone WHERE issue.milestoneID = milestone.id) as milestone,
  
  issue.title, issue.content, issue.isOpen, issue.createAt, issue.closeAt
  
  FROM issue < 1번 : 이슈로부터
  
  WHERE issue.isOpen = 1`, < 2번 : issue의 isOpen이 true일 때
```

### 📌 [BE] 자주 사용되는 부분은 template로 관리
~~~JSON
  makeIssueTemplate: async (results) => {
    const issueList = [...results.data[0]];

    for (let issue of issueList) {
      const labelList = await requestQuery(query.GET_LABELS_BY_ISSUE_ID, [
        issue.issueId,
      ]);
      const assigneeResults = await requestQuery(
        query.GET_ASSIGNEES_BY_ISSUE_ID,
        [issue.issueId]
      );
      const assigneeList = [];

      for (let assign of assigneeResults.data[0]) {
        assigneeList.push(assign.name);
      }

      issue.label = labelList.data[0];
      issue.assign = assigneeList;
    }

    return issueList;
  },
~~~

## :computer: **`Sprint #1 - Day4`**

### 📌 [BE] issue return 형식
~~~
{
    "status": "success",
    "data": [
        {
            "issueId": 1,
            "email": "test@github.com",
            "name": "test",
            "milestone": "FE",
            "title": "ViewCreate",
            "content": "we develop",
            "isOpen": 1,
            "createAt": "2020-01-02T15:00:00.000Z",
            "closeAt": "2020-01-02T15:00:00.000Z",
            "label": [
                {
                    "labelName": "web",
                    "labelColor": "#121212",
                    "labelDescription": "fighting"
                },
                {
                    "labelName": "FE",
                    "labelColor": "#243412",
                    "labelDescription": "fighting"
                }
            ],
            "assign": [
                "test",
                "reality"
            ]
        },
    ]
}
~~~

### 📌 [BE] content not null 조건을 null로 변경

- 화면에서 content가 비어있을 경우 `no description provided` 메세지를 다른 글씨로 띄워주기 위해서 `null`로 content로 설정가능하게 하였다.
    - NOT NULL 제거
    
    ```mysql
    ALTER TABLE issue modify content text NULL;
    ```
    
* 쿼리문의 DDL, DML은 대문자로 나머지는 소문자로, 마지막에는 세미콜론 안붙이기
* 라우터 코드 순서
    * get -> post -> put -> delete 별로 코드를 띄워쓰기로 하였다.
    * 함수명은 각 get, create, update, delete 의 단어를 써서 작성하기로 결정하였다.
* put과 patch 중 put 사용으로 통일하기로 결정하였다.

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
