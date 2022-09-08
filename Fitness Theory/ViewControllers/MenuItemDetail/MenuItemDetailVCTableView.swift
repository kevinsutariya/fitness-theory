//
//  MenuItemDetailVCTableView.swift
//  Fitness Theory
//
//  Created by Jay Borania on 23/07/22.
//

import UIKit

extension MenuItemDetailVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITABLEVIEW DELEGATE & DATASOURCE METHODS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenuItem.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemDetailTableCell") as? MenuItemDetailTableCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setMenuItemData(menuItem: mainMenuItem.items[indexPath.row])
        return cell
    }
}
