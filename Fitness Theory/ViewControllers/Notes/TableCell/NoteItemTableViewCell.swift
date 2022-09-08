//
//  NoteItemTableViewCell.swift
//  Fitness Theory
//
//  Created by Jay Borania on 24/07/22.
//

import UIKit

protocol NoteItemTableViewCellDelegate {
    func openNoteAt(index: IndexPath?)
    func deleteNoteAt(index: IndexPath?)
}

class NoteItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNoteTitle: UILabel!
    @IBOutlet weak var imgExpandCollapseNote: UIImageView!
    
    @IBOutlet weak var stackActionButtons: UIStackView!
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var cellIndex: IndexPath?
    var delegate: NoteItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnOpen.setTitle("open".localized, for: .normal)
        btnDelete.setTitle("delete".localized, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - UIBUTTON CLICK METHODS
    
    @IBAction func onClickOpen(_ sender: UIButton) {
        delegate?.openNoteAt(index: cellIndex)
    }
    
    @IBAction func onClickDelete(_ sender: UIButton) {
        delegate?.deleteNoteAt(index: cellIndex)
    }
}
