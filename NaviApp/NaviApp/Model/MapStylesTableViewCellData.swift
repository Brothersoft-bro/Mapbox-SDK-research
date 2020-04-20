//
//  MapStylesTableViewCellData.swift
//  NaviApp
//
//  Created by Brothersoft
//  Copyright © 2020 Brothersoft. All rights reserved.
//

import Foundation
import UIKit

enum MapStylesTableViewCellType {
    case satelliteStyleCellType, streetsStyleCellType, satelliteStreetStyleCellType, outdoorStyleCellType, lightStyleURLCellType
}

struct MapStylesTableViewCellData {
    static let mapStylesTableViewCellHeight: CGFloat = 80.0

    var cellType: MapStylesTableViewCellType
    var cellTitle: String
    
    init(cellType: MapStylesTableViewCellType, cellTitle: String) {
        self.cellType = cellType
        self.cellTitle = cellTitle
    }
}
