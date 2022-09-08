//
//  MenuItemDetailVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 23/07/22.
//

import UIKit

class MenuItemDetailVC: UIViewController {

    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblMenuItemName: UILabel!
    @IBOutlet weak var tblMenuItems: UITableView!
    
    var mainMenuItem: MainMenuItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMenuItemData()
    }
    
    // MARK: - SET MENU ITEM DATA
    
    func setMenuItemData() {
        lblMenuItemName.text = mainMenuItem.item_name
    }

    // MARK: - UIBUTTON CLICK METHOD
    @IBAction func onClickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
