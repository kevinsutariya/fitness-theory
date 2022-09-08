//
//  MainMenuVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 23/07/22.
//

import UIKit
import AdColony

class MainMenuVC: UIViewController {
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var tblMainMenu: UITableView!
    
    var arrMainMenu: [MainMenuItem] = {
        return [MainMenuItem(id: 0,
                             item_name: "Main".localized,
                             items: [MenuItem(description: "main_content_1".localized,
                                              image_name: ""),
                                     MenuItem(description: "main_content_2".localized,
                                              image_name: "menu-item-2")]),
                MainMenuItem(id: 1,
                             item_name: "Organization".localized,
                             items: [MenuItem(description: "organization_content_1".localized,
                                              image_name: ""),
                                     MenuItem(description: "organization_content_2".localized,
                                                      image_name: "organization-item-2"),
                                     MenuItem(description: "organization_content_3".localized,
                                                      image_name: "organization-item-3"),
                                     MenuItem(description: "organization_content_4".localized,
                                                      image_name: "organization-item-4"),
                                     MenuItem(description: "organization_content_5".localized,
                                                      image_name: "organization-item-5"),
                                     MenuItem(description: "organization_content_6".localized,
                                                      image_name: "organization-item-6")]),
                MainMenuItem(id: 2,
                             item_name: "Details".localized,
                             items: [MenuItem(description: "details_content_1".localized,
                                              image_name: ""),
                                     MenuItem(description: "details_content_2".localized,
                                              image_name: "details-item-2"),
                                     MenuItem(description: "details_content_3".localized,
                                              image_name: "details-item-3"),
                                     MenuItem(description: "details_content_4".localized,
                                              image_name: "details-item-4"),
                                     MenuItem(description: "details_content_5".localized,
                                              image_name: "details-item-5"),
                                     MenuItem(description: "details_content_6".localized,
                                              image_name: "details-item-6")]),
                MainMenuItem(id: 3,
                             item_name: "Common mistakes".localized,
                             items: [MenuItem(description: "common_mistakes_content_1".localized,
                                              image_name: ""),
                                     MenuItem(description: "common_mistakes_content_2".localized,
                                                      image_name: "common-mistakes-item-2"),
                                     MenuItem(description: "common_mistakes_content_3".localized,
                                                      image_name: "common-mistakes-item-3"),
                                     MenuItem(description: "common_mistakes_content_4".localized,
                                                      image_name: "common-mistakes-item-4"),
                                     MenuItem(description: "common_mistakes_content_5".localized,
                                                      image_name: "common-mistakes-item-5"),
                                     MenuItem(description: "common_mistakes_content_6".localized,
                                                      image_name: "common-mistakes-item-6"),
                                     MenuItem(description: "common_mistakes_content_7".localized,
                                                      image_name: "common-mistakes-item-7")]),
                MainMenuItem(id: 4,
                             item_name: "Tips".localized,
                             items: [MenuItem(description: "tips_content_1".localized,
                                              image_name: ""),
                                     MenuItem(description: "tips_content_2".localized,
                                                      image_name: "tips-item-2"),
                                     MenuItem(description: "tips_content_3".localized,
                                                      image_name: "tips-item-3"),
                                     MenuItem(description: "tips_content_4".localized,
                                                      image_name: "tips-item-4"),
                                     MenuItem(description: "tips_content_5".localized,
                                                      image_name: "tips-item-5"),
                                     MenuItem(description: "".localized,
                                                      image_name: "tips-item-6")]),
                MainMenuItem(id: 5,
                             item_name: "Notes".localized,
                             items: [MenuItem]()),
                MainMenuItem(id: 6,
                             item_name: "Shop".localized,
                             items: [MenuItem]()),
                MainMenuItem(id: 7,
                             item_name: "Settings".localized,
                             items: [MenuItem]()),
                MainMenuItem(id: 8,
                             item_name: "Calculating".localized,
                             items: [MenuItem]())
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHeaderTitle.text = "MENU".localized
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !StoreManager.shared.isProductPurchased(ProductType.disableads.rawValue) else { return }
        
        if AdColonyModel.shared.interstitial != nil && !(AdColonyModel.shared.interstitial?.expired ?? false) {
            AdColonyModel.shared.interstitial?.show(withPresenting: self)
        }
        else {
            AdColonyModel.shared.requestInterstitial()
        }
    }
}

