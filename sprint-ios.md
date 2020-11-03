## **`Sprint #2 - Day2`**

### Modern Collection List View

* Reference : WWDC 2020 Advances in UICollectionView [LINK](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views#see-also)


#### Swipe
* UICollectionLayoutListConfiguration
    * trailingSwipeAction 기능을 이용하여 액션 추가
        * clese, delete Action 추가
        * 이후 handler을 추가하여 기능 구현할 예정
    * 기존에 있는 layout 변경
        * CompositionalLayout.list에 위의 configure 추가
        * 사용하고 있던 CollectionView의 collectionViewLayout를 변경
        * delegate 채택

#### Accessory Items(Multiselect)
* UICellAccessory 중 multiselect를 통해 다중선택 화면 구현
* 기존의 cell을 옆으로 변경하기 위해서 cell의 separatorLayoutGuide에게 constraint를 줌
* isEditing property를 오버라이딩하여 현재 모드를 관찰하여(didSet) 적절하게 화면 구성을 바꿈
    * Title, Navigation bar button item, Button

### 결과화면

| Swipe Cell  | Multiselect Accessory |
| -------- | -------- |
| <img width = 380, src = "https://i.imgur.com/NPt1c1q.gif"> | ![](https://user-images.githubusercontent.com/34840140/97972024-44a1f080-1e07-11eb-8b14-9288a4db47e6.gif) |


## **`Sprint #2 - Day1`**

### 이슈 목록 화면 완성

* UIColor를 extension하여 hex string 값으로 데이터를 받아오면 label의 배경 색이 바뀝니다.
    * 또한, (redValue * 0.299 + greenValue * 0.587 + blueValue * 0.114) / 255 값이 0.5보다 작을 시에는 label의 글자 색상이 흰색, 0.5보다 크면 검은색으로 표기 됩니다.
* Floating button은 custom class를 통해 제작했습니다.
* 추후에 cell이 재사용 될 때 문제가 생기지 않는지 확인해보아야 합니다. 


### Router를 통한 Data 전달
* Issue Controller에서 Filter Controller로 Data 전달을 위해 사용
    1. ViewController에서 프로토콜 채택
    ```swift
    // IssueListViewController
    var router: (NSObjectProtocol & IssueListRoutingLogic & IssueListDataPassing)?
    
    ...
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    ```
    2. DestinationVC를 설정하여 Data 전달
    ```swift
    // IssueListRouter
    // IssueListViewController
    @objc protocol IssueListRoutingLogic {
        func routeTo\(scene)(segue: UIStoryboardSegue?)
    }

    protocol IssueListDataPassing {
        var Data: Data? { get }
    }
    
    func routeTo\(scene)(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ViewController
            destinationVC.router?.Data? = Data!
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "") as! ViewController
            destinationVC.router?.Data? = Data!
        }
    }
    ```
    3. 받는 Controller에도 해당 Router 형식에 맞춰 제작



### URLSession으로 데이터 받아오기
* 현재 어플은 API를 통해 계속해서 목록을 서버로부터 받아오는 일을 하므로 NetworkService class를 만들었습니다.
    * dataTask를 통해 데이터를 받아옵니다.
    * 추후에 사용자 프로필 사진처럼 용량이 큰 파일들이 오간다면 caching을 구현할 예정입니다.
* 각 Scene의 DataManager들이 NetworkService를 사용하여 필요한 데이터를 받아와 decoding을 진행합니다.
* Decoding 이후에는 알맞은 모델에 저장하여 collection view / table viewd에 표현되도록 했습니다.

![](https://i.imgur.com/NpzFKAz.png)

### 결과화면

| 이슈 목록 화면  | Interactive Bottom Card View |
| -------- | -------- |
| <img width = 250 src = "https://user-images.githubusercontent.com/34840140/97856567-d1817700-1d3f-11eb-9488-d4b5fecc5919.png">     | ![](https://i.imgur.com/1aV8Y0b.gif)


## **`Sprint #1 - Day4`**

### VIP 패턴을 적용한 IssueListViewController  

<img width = 800, src = "https://user-images.githubusercontent.com/34840140/97575352-ef916380-1a2f-11eb-9641-95295258a1e3.jpeg">

* 계층 구조화
    * ![](https://i.imgur.com/53D6m4P.png)
    * Scene 별로 계층을 구조화 했으며 Scene들을 추가하여 구현할 때마다 추가할 예정입니다.
    * DataManager 역할의 확장성을 고려해 보았을 때 Services 폴더는 Scenes 밖으로 뺄 수 있습니다.
* 흐름

    1. IssueListViewController 는 interactor에게 **Issue목록을 request**
    ```swift
    // IssueListViewController
    class IssueListViewController: UIViewController {
       var interactor: IssueListBusinessLogic?
       ...
       override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          fetchIssues()
       }
       ...
       func fetchIssues() {
            let request = ListIssues.FetchLists.Request()
            interactor?.fetchIssues(request: request)
        }
    }
    ```
    2. IssueListInteractor는 worker에게 Issue목록을 request
    3. Worker는 DataManager를 통해 데이터를 받아온 후 decode한 후 interactor [Issue] 의 형태로 전달 (서버와 통신할 시 worker와 DataManager 로직은 변경 될 예정)
    4. Interactor는 presenter에게 fetch 해온 [Issue]를 전달
    ```swift
    // IssueListViewController
    class IssueListInteractor: IssueListBusinessLogic {
       var presenter: IssueListPresentationLogic?
       var issueWorker = IssueListWorker(dataManager: IssueDataManager())
       ...
       func fetchIssues(request: ListIssues.FetchLists.Request) {
          issueWorker.fetchIssues(completion: { (issues) -> Void in
             self.issues = issues
             let response = ListIssues.FetchLists.Response(issues: issues)
             self.presenter?.presentFetchedIssues(response: response)
          })
        }
    }
    ```
    5. Presenter는 interactor로 부터 받아온 데이터를 ViewModel로 변경하여 viewController에게 전달
     ```swift
    // IssueListViewController
    class IssueListPresenter: IssueListPresentationLogic {
       weak var viewController: IssueListDisplayLogic?
       ...
       func presentFetchedIssues(response: ListIssues.FetchLists.Response) {
          var displayedIssues: [ListIssues.FetchLists.ViewModel.DisplayedIssue] = []
          for issue in response.issues {
             // [ViewModel] 로 formatting 하는 작업
          }
          viewController?.displayFetchedOrders(viewModel: viewModel)
        }
    }
    ```
    6. IssueListViewController는 받은 ViewModel들로 `dataReload()`



* VIP 참고 링크  [Clean-Swift/CleanStore](https://github.com/Clean-Swift/CleanStore)

### IssueList View 작업
* Cell 내의 UI 제약조건 및 레이아웃을 수정하였습니다.
    * Issue 내 UI의 모든 Top Vertical를 증가시켰습니다.
    * 셀 마다 아래 Border를 추가하였습니다.
    * 설명 레이블 조건을 추가하였습니다.
        * Linebreak를 이용해 2줄만 표시해주도록 구현
    * milestone border를 추가하였고 문자 길이에 따라 Label Width를 조율하였습니다.


### Bottom Popup View 제작
* 이전에 작업했던 Popup View를 바탕으로 아래에서 불러오는 Popup View 제작
    * Filter 내의 세부 메뉴 기능에 이용할 예정입니다.
    * 현재 임의의 값을 넣어 동일한 Controller를 불러오도록 제작

```swift
let popupController = STPopupController(rootViewController: pushVC!)
popupController.style = .bottomSheet // bottom Animation
popupController.present(in: self) // 현재 자신의 controller을 불러옴
```

### 결과화면

| IssueList CollectionView | Bottom Popup View | 
| -------- | -------- | 
| <img width = 300, src = "https://i.imgur.com/590DHDq.png"> | ![](https://i.imgur.com/qBDfBa7.gif)     | 



### Git branch conflict

* upstream/feat-issue branch를 merge 도중 conflict 발생
    * 같은 파일을 건드리는 것 외에도 서로 다른 폴더 내의 다른 파일들을 넣으면서 생기게 되었습니다.
    * xcodeproj 내의 pbxproj 충돌이 생겨 해당 프로젝트를 열 수 없었습니다.
    
    
* 'cannot be opened because the project file cannot be parsed' 메세지가 나타난다면 다음과 같이 해결하시면 됩니다.
    1. .xcodeproj 파일 우클릭 > `Show Packages Contents` > text editor로 파일 열기
    2. <<<<HEAD === 와 같이 conflict 난 부분을 해결해주시면 됩니다.



| 문제 상황 | Conflict 발생 예시 |
| -------- | -------- | 
| ![](https://i.imgur.com/YlPQjVh.png)     |  ![](https://i.imgur.com/qeKCe4i.png)   | 

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
