//
//  FilterMdoel.swift
//  IssueTracker
//
//  Created by Sue Cho on 2020/11/11.
//

import Foundation

enum FilterCategory: String, CaseIterable {
    case All // 전체 이슈 (open / close)
    case Created // 내가작성한 이슈
    case Assigned // 내게 할당된 이슈
    case Mentioned // 내가 댓글을 남긴 이슈
}
