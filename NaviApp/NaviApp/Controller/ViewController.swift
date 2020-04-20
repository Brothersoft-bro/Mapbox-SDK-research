//
//  ViewController.swift
//  NaviApp
//
//  Created by Brothersoft
//  Copyright © 2020 Brothersoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainItemsTableView: UITableView!
    
    var mainMenuItems: [MainTableViewCellData] = []
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainItemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let basicMapCellData = MainTableViewCellData(cellType: MainTableViewCellType.basicMapCellType, cellTitle: "Basic Map with current position")
        let mapStylesCellData = MainTableViewCellData(cellType: MainTableViewCellType.mapStylesCellType, cellTitle: "Map Styles")
        let navigationCellData = MainTableViewCellData(cellType: MainTableViewCellType.navigationCellType, cellTitle: "Navigation")

        let otherMapCellData = MainTableViewCellData(cellType: MainTableViewCellType.other, cellTitle: "Other")

        self.mainMenuItems = [basicMapCellData, mapStylesCellData, navigationCellData, otherMapCellData]
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource, UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCellData.mainTableViewCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.mainMenuItems[indexPath.row]
        
        let cell = self.mainItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = cellData.cellTitle
        cell.selectionStyle = .none
        cell.backgroundColor = .systemTeal
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = self.mainMenuItems[indexPath.row]
        
        switch cellData.cellType {
        case MainTableViewCellType.basicMapCellType:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BasicMapViewController") as? BasicMapViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        case MainTableViewCellType.mapStylesCellType:
             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapStylesViewController") as? MapStylesViewController
             self.navigationController?.pushViewController(vc!, animated: true)
        case MainTableViewCellType.navigationCellType:
             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BasicNavigationViewController") as? BasicNavigationViewController
             self.navigationController?.pushViewController(vc!, animated: true)
        default:
            break
        }
    }
}
