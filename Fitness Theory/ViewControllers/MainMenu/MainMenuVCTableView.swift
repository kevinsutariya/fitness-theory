//
//  MainMenuVCTableView.swift
//  Fitness Theory
//
//  Created by Jay Borania on 23/07/22.
//

import Foundation
import UIKit

extension MainMenuVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITABLEVIEW DELEGATE & DATASOURCE METHODS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMainMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuTableViewCell") as? MainMenuTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.lblItemTitle.text = arrMainMenu[indexPath.row].item_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppSounds.shared.playClickSound()
        if arrMainMenu[indexPath.row].item_name == "Notes".localized {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesVC") as? NotesVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if arrMainMenu[indexPath.row].item_name == "Shop".localized {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShopVC") as? ShopVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if arrMainMenu[indexPath.row].item_name == "Settings".localized {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if arrMainMenu[indexPath.row].item_name == "Calculating".localized {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "BMICalculatorVC") as? BMICalculatorVC {
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuItemDetailVC") as? MenuItemDetailVC {
                vc.mainMenuItem = arrMainMenu[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
