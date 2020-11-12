# :memo: Sprint
## :books: Sprint Backlog
[Google Spreadsheet :link:](https://docs.google.com/spreadsheets/d/19wkM--KlfBSZAe7_RBzZKZ5Rq0YNnLkuxhtWNhTGxDA/edit?usp=sharing)

## 👩‍💻👨‍💻 개발자
#### 🐳 : [권예지](https://github.com/Yejikwon)
#### 🐹 : [김도연](https://github.com/do02reen24)
#### 🐕 : [윤영우](https://github.com/yoonwoo123)

-----

## `💻 Sprint #2 - Day4`
### 📌 [FE] 로그인 여부에 따른 이동 페이지 설정 ✨
- 참고 코드: `/shared/App.jsx`
<br/>

### 📌 [FE] Prettier Formatter 설정 ✨
- 내 vscode에서 prettier가 안될 경우 아래 사이트를 참고해주세요
    - [Prettier로 Default Formatter 설정 방법](https://pusha.tistory.com/entry/Prettier-%EC%A0%80%EC%9E%A5%EC%8B%9C-%EC%97%90%EB%9F%AC-%EC%BD%94%EB%93%9C%EA%B0%80-%EA%B0%84%ED%97%90%EC%A0%81%EC%9C%BC%EB%A1%9C-%EB%82%98%ED%83%80%EB%8A%94-%EC%97%90%EB%9F%AC-settingjson-vscode)
    - **`vscode -> [파일] -> [기본설정] -> [설정] -> editor.default formatter 변경`**
<br/>

### 📌 [FE] config.js 파일 ✨
- src 디렉토리 밑에 파일 생성해주기
~~~js
export const BASE_URL = 'http://118.67.131.96:3000/';
~~~
<br/>

### 📌 [BE] API enhancement ✨
> 구현 내용 및 작업 했던 내역

- [x] [Backend] 이슈에 할당된 Assignee 이름 외에 추가 정보 반환해주기
    -  userId, imageUrl 정보를 추가해줬습니다.
- [x] [Backend] 이슈에 Comment 사용자의 이름 외에 이미지 url, id 추가 반환해주기
- [x] [Backend] 모든 사용자(Assignee) 반환해주는 API 제작하기
- [x] [Backend] milestone get API 수정하기
- [X] [Backend] status -> fail인 경우 status 값만 넘기기
    - 모든 API 전부 다 고치기
- [x] [Backend] 이슈 삭제하기
- [x] [Backend] Github 가입시 새로운 user 생성시 imageURL 문제 고치기
- [x] [Backend] 로그인 여부 반환하는 API 만들기
- [x] [Backend] label get API 만들기
<br/>

### 📌 [BE] Cors 설정 추가 ✨
- fetch 요청 시, cors 옵션 추가해줬음
- Backend app.js cors 설정 추가해줬음
-----
<br/>

## `💻 Sprint #2 - Day3`
### 📌 [FE] React-router를 적용하여 프로젝트 구조 변경
* `react-router-dom`은 웹에서 쓰이는 컴포넌트이고, `react-router-native`는 react-native를 활용한 앱개발에 쓰이는 컴포넌트를 포함하고 있다. `react-router`는 이 둘을 합친 패키지이다.
* https://velopert.com/3417 를 참고하여 진행하였다.
* `react-router-dom`만 설치하기로 했다.
```bash
npm install -d react-router-dom
```
* 디렉토리 구조 설계
    * 기존
        * src/components: 컴포넌트들이 위치하는 디렉토리
        * src/pages: 각 라우트들이 위치하는 디렉토리

    * 추가된 디렉토리
        * src/utils: 자주 사용되는 함수들을 모아놓은 디렉토리
        * src/shared: 서버와 클라이언트에서 공용으로 사용되는 컴포넌트 App.js 가 여기에 위치함
        * src/client: 브라우저 측에서 사용할 최상위 컴포넌트
* url로 직접 router에 접근하니 동작하지 않고 404 error가 발생했다.😥
    * 버튼(Link)을 클릭해서 넘어가는 라우팅 이벤트는 무사히 동작하였다.
* pages라는 디렉토리 네이밍도 아직 와닿지 않고(views 많이 썼었는데,,) shared도,, client도.. 진짜 생소한 게 많아서 리액트에 아직 정이 안갑니다 ^^7

### 📌 [FE] CSS-in-JS 적용하기
* 과제 요구사항을 읽어보니 CSS-in-JS를 적용해야함을 알게 되어 수정하였다.
```bash
npm install -d styled-components
```
* SCSS로 적용하고 싶었는데 너무 아쉽네요 8ㅅ8😂

### 📌 [BE] 로그인 callback...
* 구현한 OAuth Login의 결과 값을 어떻게 FE와 iOS에 전달할 수 있을지 많은 고민을 하였다. 🤔
* [redirect의 url로 token을 넘겨주는 방법](https://stackoverflow.com/questions/47599087/how-to-send-jwt-to-react-client-from-a-callback)은 아닌 것 같고...
* githubOAuth로 로그인하면 발급되는 code와 client_id, client_secret을 이용하여 post요청으로 access_token을 발급하려고 할 수 있는 모든 방법을 시도해 보았으나 무슨 이유에서인지 에러가 발생했다.. 나중에 다시 시도해야겠다.
  [참조링크](https://devhyun.com/blog/post/15)
<br/>

## `💻 Sprint #2 - Day2`
### 📌 [BE] npm 명령어 실종...!
* 서버에서 npm 명령어를 쳤을 때 command not found 조차 뜨지 않았다.
* 서버를 재부팅했다. 재부팅하니까 npm 명령어가 안되던 오류가 해결되었다.
* 새로 clone하고 npm과 node, pm2를 재설치했다.
* 말을 안듣는 서버...

### 📌 [FE] 프론트엔드 환경변수 설정 및 scss 색깔 규칙 설정
* 프론트에서는 .env 대신 src 아래에 config.js 파일을 생성하여 환경변수를 설정하였다.
  [참조링크](https://hello-bryan.tistory.com/134)
* scss파일 재사용을 위해 Client 아래에 scss폴더를 만들고 _color.js 와 같이 만들어서
  다른 scss에서 import해서 사용 하기로 결정하였다.
  [참조링크](https://heropy.blog/2018/01/31/sass/)
* _color.js에서 자주 쓰는 색깔은 변수처럼 네이밍하여 사용하기로 하였다.
  ```css
  $gray-100: #f8f9fa !default;
  // $색깔-숫자값: #색상값
  // 기본 색상은 블루는 500을 갖는다.
  // 낮은 숫자일수록 연한 색이고 높은 숫자일수록 어두운 색을 의미한다. 
  ```
  * 100 ~ 999 사이의 숫자를 색깔 뒤에 붙여 사용하기로 했다.
<br/>

## `💻 Sprint #2 - Day1`
### 📌 [FE] Client 프로젝트 생성
* create react app 없이 프로젝트를 생성했다.
* react에 능숙한 사람이 없어 팀원 모두 zoom에 접속하여 함께 찾아보며 결정하였다.
* js와 jsx는 기능은 동일하지만 React에서 권장하는 jsx를 사용하기로 하였다.
* React 프로젝트의 폴더 구조를 설계하였다. 👍👍
    * ex) Routes.jsx 가 모든 경로를 갖고있다.
        ```bash
        ㄴ /Client
            App.jsx
            App.scss
            ㄴ /src
                ㄴ /components
                    ㄴ Routes.jsx
                    ㄴ /navbar
                        ㄴ Navbar.jsx
                        ㄴ Navbar.scss
                    ㄴ /form
                        ㄴ IssueAddForm.jsx
                        ㄴ IssueAddForm.scss

                ㄴ /pages
                    ㄴ /login
                        ㄴ LoginPage.jsx
                        ㄴ LoginPage.scss 
        ```
<br/>

### 📌 [FE] webpack 버전 관리
* 최신 버전의 webpack-dev-server/webpack-cli를 사용하니
  webpack-dev-server를 실행 시 에러가 발생했다.
* 의존성이 확인된 버전을 찾아 변경 후, 재실행을 진행했더니 에러를 해결할 수 있었다.
* 버전 관리의 중요성을 다시 한 번 느꼈다.

-----

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
~~~javascript
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
