//
//  mainTableViewCellData.swift
//  NaviApp
//
//  Created by Brothersoft
//  Copyright © 2020 Brothersoft. All rights reserved.
//

import Foundation
import UIKit

enum MainTableViewCellType {
    case basicMapCellType, mapStylesCellType, navigationCellType, other
}

struct MainTableViewCellData {
    static let mainTableViewCellHeight: CGFloat = 100.0

    var cellType: MainTableViewCellType
    var cellTitle: String

    init(cellType: MainTableViewCellType, cellTitle: String) {
        self.cellType = cellType
        self.cellTitle = cellTitle
    }
}
