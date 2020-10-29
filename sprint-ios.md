## **`Sprint #1 - Day3`**
### [iOS] Git branch 재설정
* 관련 ISSUE : -
* Day2 초기 작업 환경을 구축할 당시 gitignore 파일을 잘 확인하지 못해 xcuserstate 등의 바이너리 파일들이 계속해서 충돌을 발생시켰습니다.
* 이에 branch 들을 재구성하는 등 추후 협업 시 충돌을 최소화하기 위해 꼼꼼히 살피는 작업을 한번 더 진행했습니다.

### [iOS] 스토리보드 작업 (WIP)
* 관련 ISSUE : `#9` `#14` `#55` `#61` `#65` `#67`
* Pair programming으로 scene 별로 번갈아가며 진행
* 화면 구성을 우선적으로 하며 각 화면에 필요한 component들을 정리해보았습니다. (constraint 설정은 아직 안됨)
* 정리하는 과정에서 일부 Scene을 추려내는 작업을 하였습니다. (Filter는 논의가 덜 된 상태)
    * Scene : IssueList, LabelList, MilestoneList, ShowIssue, CreateIssue, Createlabel, CreateMilestone
* Label과 Milestone 생성 및 수정 시 사용 될 controller는 [STPopupController](http://github.com/kevin0571/STPopup)를 사용합니다. 

| Sign In | Issue |
| -------- | -------- |
| <img width = 500 src = "https://user-images.githubusercontent.com/34840140/97448594-2a35c600-1974-11eb-844a-dc958b73f58d.png"> | <img width = 500 src = "https://user-images.githubusercontent.com/34840140/97448239-c7442f00-1973-11eb-9b79-4f543a16e2a4.png"> |


| Label & Milestone | STPopupController |
| -------- | -------- |
| <img width = 400 src = "https://user-images.githubusercontent.com/34840140/97448240-c90df280-1973-11eb-93c4-353d10191783.png">     | ![](https://i.imgur.com/Y4BxA7K.gif)     | 

### [iOS] Mock Data 생성
* Web-server 팀과 데이터 구조를 논의하여 json Data 형식 제작
    * milestone은 join을 통해 name 값 출력
    * 현재 Label 데이터는 의견 조율중


| Json Mock Data |
| -------------- |
| <img width = 400 src = "https://i.imgur.com/giRR7i4.png">|
