//
//  MenuItemDetailTableCell.swift
//  Hockey World
//
//  Created by Jay Borania on 08/07/22.
//

import UIKit

class MenuItemDetailTableCell: UITableViewCell {

    @IBOutlet weak var imgMenuItem: UIImageView!
    @IBOutlet weak var lblMenuItemDescription: UILabel!
    @IBOutlet weak var heightImgMenuItem: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setMenuItemData(menuItem: MenuItem) {
        imgMenuItem.image = UIImage(named: menuItem.item_image_name)
        imgMenuItem.isHidden = menuItem.item_image_name.count > 0 ? false : true
        heightImgMenuItem.constant = menuItem.item_image_name.count > 0 ? imgMenuItem.contentClippingRect.height : 0
        
        lblMenuItemDescription.text = menuItem.item_description        
    }
}
