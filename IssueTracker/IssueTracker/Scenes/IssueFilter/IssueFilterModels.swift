//
//  IssueFilterModels.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/02.
//

import Foundation

enum ListFilter {
    struct SetupFilter {
        let titleForHeader = ["다음 중에 조건을 고르세요", "세부 조건"]
        let filterForList = [
            ["열린 이슈들", "내가 작성한 이슈들", "내게 할당된 이슈들", "내가 댓글을 남긴 이슈들", "닫힌 이슈들"],
            ["작성자", "레이블", "마일스톤", "담당자"]
        ]
    }
    
    struct IssueFilterData {
        var filterCondition: String
        var issueWriter: [String]
        var label: [String]
        var milestone: String
        var assign: [String]
    
        init() {
            filterCondition = "열린 이슈들"
            issueWriter = []
            label = []
            milestone = ""
            assign = []
        }
    }
}
