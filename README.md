# IssueTracker-8

<div align="center">


<img width = 900 src = "https://user-images.githubusercontent.com/34840140/97556676-1eeaa500-1a1d-11eb-8fe7-6b9420af20f7.png">

![Swift](https://img.shields.io/badge/swift-v5.1-orange?logo=swift)
![Xcode](https://img.shields.io/badge/xcode-v12.1-blue?logo=xcode)
![Javascript](https://img.shields.io/badge/javascript-ES6+-yellow?logo=javascript)
![react](https://img.shields.io/badge/react-16.13-1cf?logo=react)
![NodeJS](https://img.shields.io/badge/node.js-v12.18.3-green?logo=node.js)
![MySQL](https://img.shields.io/badge/mysql-v5.7.32-blue?logo=mysql)

[![GitHub Open Issues](https://img.shields.io/github/issues-raw/boostcamp-2020/IssueTracker-8?color=green)](https://github.com/boostcamp-2020/IssueTracker-8/issues)
[![GitHub Closed Issues](https://img.shields.io/github/issues-closed-raw/boostcamp-2020/IssueTracker-8?color=red)](https://github.com/boostcamp-2020/IssueTracker-8/issues)
[![GitHub Open PR](https://img.shields.io/github/issues-pr-raw/boostcamp-2020/IssueTracker-8?color=green)](https://github.com/boostcamp-2020/IssueTracker-8/issues)
[![GitHub Closed PR](https://img.shields.io/github/issues-pr-closed-raw/boostcamp-2020/IssueTracker-8?color=red)](https://github.com/boostcamp-2020/IssueTracker-8/issues)

<H1></H1>

[WEB](https://github.com/boostcamp-2020/IssueTracker-08/blob/master/sprint-web.md)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[IOS](https://github.com/boostcamp-2020/IssueTracker-08/blob/master/sprint-ios.md)

[Split Backlog](https://docs.google.com/spreadsheets/d/19wkM--KlfBSZAe7_RBzZKZ5Rq0YNnLkuxhtWNhTGxDA/edit#gid=0)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Wiki](https://github.com/boostcamp-2020/IssueTracker-08/wiki)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Team Ground Rules](https://github.com/boostcamp-2020/IssueTracker-08/wiki/Team-Ground-Rules)

</div>

## :link: IssueTracker-8

WEB RELEASE : http://118.67.131.96:8000/  <br>
iOS RELEASE : https://kr.object.ncloudstorage.com/release-server/Web/index.html

## 👨‍👩‍👧‍👦 모쨍이 팀원들 (순서대로)

![image](https://user-images.githubusercontent.com/50297117/97560815-8d7e3180-1a22-11eb-8682-21d00cfe1a65.png)

| 🐳 권예지 [@Yejikwon](https://github.com/Yejikwon) | 🐹 김도연 [@do02reen24](https://github.com/do02reen24) | 🐼 김영렬 [@rile1036](https://github.com/rile1036) | 🐶 윤영우 [@yoonwoo123](https://github.com/yoonwoo123) | 🐲 조수정 [@Sueaty](https://github.com/Sueaty) |
| ------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------- | ----------------------------------------------------- | --------------------------------------------- |
| 재밌게 살기!                                      | 개발을 사랑(?)하자                                    | 햄버거가 식었어요..                               | JS 어서오고~                                          | 스위리 발은 🐶발                               |
| **대전에서 판교까지 슝 =3**                       | **맛있는 밥만 있으면 충분^^**                         | **귀염뽀짝 iOS 개발자**                           | **마스크로 숨길 수 없는 미남**                        | **스위리 쏘 쓰윗**                            |



## Sprint Backlog

[Google Spreadsheet](https://docs.google.com/spreadsheets/d/19wkM--KlfBSZAe7_RBzZKZ5Rq0YNnLkuxhtWNhTGxDA/edit?usp=sharing)

## 📚 API 문서

[Issue & Comment API 문서](https://documenter.getpostman.com/view/10085882/TVYNYF44#b5e26198-7c6d-4148-830b-19552dc47f41) <br/>
[Label API 문서](https://documenter.getpostman.com/view/7326919/TVYNYvFB) <br/>
[Milestone API 문서](https://documenter.getpostman.com/view/13282124/TVYJ7HM9) <br/>
[Login API 문서](https://documenter.getpostman.com/view/7326919/TVemB9H7) <br/>

-----

## 💻 Web

> 모든 페이지의 동작은 새로고침 없이 동적으로 작동합니다.

* 메인 페이지는 로그인한 유저의 경우 Issue 목록이 나타나고, 로그인하지 않은 유저의 경우 로그인 페이지가 나타남
* 로그인하지 않은 유저는 issue와 label, milestone의 생성, 수정, 삭제 작업을 진행할 수 없음

### 로그인 페이지

![image](https://user-images.githubusercontent.com/50297117/99023911-ed3f1580-25a8-11eb-8fea-5a0d070bdc58.png)

* 로그인을 하지 않은 유저의 경우 로그인 페이지를 보여줌
* 로그인 회원가입 기능은 개발하지 않았으며 Github 로그인를 통하여 로그인 가능

### Issue 목록 페이지

* 상단의 `🐼ISSUES` 버튼을 통해 모든 페이지에서 홈(Issue 목록)으로 이동가능
* 로그인을 한 유저의 경우 이슈 목록 페이지를 보여줌



### Issue 생성 페이지

![이슈생성](https://user-images.githubusercontent.com/45933675/99026309-0b5b4480-25ae-11eb-9102-90bf7c42fa75.PNG)

- 

### Issue 상세 페이지

![이슈디테일3](https://user-images.githubusercontent.com/45933675/99026307-0a2a1780-25ae-11eb-9c21-a5e9e4028229.PNG)

- 이슈 클릭 시 상세 화면입니다.
- 본인이 쓴 글이 아닐 시 Edit 버튼이 보이지 않습니다.



![클로즈이슈](https://user-images.githubusercontent.com/45933675/99026312-0bf3db00-25ae-11eb-879d-c6c66a03b5d4.PNG)

- Close issue 버튼 클릭 시 이슈가 닫히고 Reopen issue 시  다시 열립니다.



![디테일코멘트](https://user-images.githubusercontent.com/45933675/99026310-0b5b4480-25ae-11eb-855f-26e2bdbf5526.PNG)

- 이슈 코멘트를 적지 않을 시 Comment 버튼이 비활성화 상태이고, 글을 적으면 생성 버튼이 활성화됩니다.



### Label 페이지

![image](https://user-images.githubusercontent.com/50297117/99023950-034cd600-25a9-11eb-854d-b3062ea4ad4f.png)

* New Label 버튼을 클릭시 새로운 라벨을 추가할 수 있는 탭이 펼쳐짐
  * 라벨 이름을 입력하지 않으면 Label preview로 라벨이 보여지고, 이름을 입력할 경우 해당 이름으로 preview를 제공함
  * 라벨 이름을 작성하지 않으면 오류 팝업과 함께 등록되지 않음
  * 유효하지 않은 색상값을 입력할 경우 오류 팝업과 함께 등록되지 않음
  * color 버튼을 통해 랜덤으로 색깔을 받아올 수 있음

![image](https://user-images.githubusercontent.com/50297117/99023982-12cc1f00-25a9-11eb-88fd-63d0da0d2c04.png)

* Edit 버튼을 클릭하여 기존의 라벨을 수정할 수 있음

![image](https://user-images.githubusercontent.com/50297117/99024009-2081a480-25a9-11eb-887a-16ce12078938.png)

* Delete 버튼 클릭시 삭제를 묻는 팝업이 뜨고 확인시 라벨이 삭제됨

![image](https://user-images.githubusercontent.com/50297117/99024428-eb298680-25a9-11eb-9e23-3cb7eaefbf8c.png)

### Milestone 페이지

* 상단 메뉴를 통해 라벨 페이지로 이동가능함
* 상단의 Open, Closed 를 통해 열린(또는 닫힌) 마일스톤 목록을 볼 수 있음
* Close, ReOpen 버튼을 통해 마일스톤을 열고 닫을 수 있음

![image](https://user-images.githubusercontent.com/50297117/99024218-70606b80-25a9-11eb-92dc-7fba58ee9493.png) 

* Delete 버튼 클릭 시 해당 마일스톤의 삭제를 묻는 팝업이 뜨고 확인시 마일스톤이 삭제됨

![image](https://user-images.githubusercontent.com/50297117/99024755-9b978a80-25aa-11eb-998c-6eed83b51da3.png)

* New milestone 버튼을 통해 마일스톤 생성 페이지로 이동이 가능함.
  * Title을 작성하지 않은 경우 Create milestone 버튼이 비활성화됨.

![image](https://user-images.githubusercontent.com/50297117/99024237-7b1b0080-25a9-11eb-9dd5-06474640720c.png)

* Edit 버튼을 통해 해당 마일스톤의 수정 페이지로 이동이 가능함.
* 기존 마일스톤 정보가 화면에 불러와짐
* Cancel 버튼을 통해 수정을 반영하지 않고 이전 페이지로 돌아갈 수 있음

![image](https://user-images.githubusercontent.com/50297117/99024181-5f175f00-25a9-11eb-993a-c2ee0bfe570c.png)
