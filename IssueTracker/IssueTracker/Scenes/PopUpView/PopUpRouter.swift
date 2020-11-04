//
//  PopUpRouter.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/04.
//

import Foundation
import UIKit

protocol PopUpDataPassing {
    var coordinator: String { get set }
}

class PopUpRouter: PopUpDataPassing {
    var coordinator: String = ""
    weak var viewController: PopUpViewController?
}
