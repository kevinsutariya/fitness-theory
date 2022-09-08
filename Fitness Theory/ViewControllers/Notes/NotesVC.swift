//
//  NotesVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 24/07/22.
//

import UIKit

class NotesVC: UIViewController {
    
    @IBOutlet weak var lblMenuItemName: UILabel!
    @IBOutlet weak var tblNotes: UITableView!
    
    @IBOutlet weak var popupNoteDeleteAlert: UIView!
    @IBOutlet weak var lblPopupNoteDeleteTitle: UILabel!
    @IBOutlet weak var btnPopupNoteDeleteYes: UIButton!
    @IBOutlet weak var btnPopupNoteDeleteNo: UIButton!
    
    var deleteNoteIndex: Int!
    var arrNotes: [NoteItem] = {
        return [NoteItem(note_id: 0,
                         note_title: "Note 1 title",
                         note_description: "description 1"),
                NoteItem(note_id: 1,
                         note_title: "Note 2 title",
                         note_description: "description 2"),
                NoteItem(note_id: 2,
                         note_title: "Note 3 title",
                         note_description: "description 3")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMenuItemName.text = "Notes".localized
        
        lblPopupNoteDeleteTitle.text = "You really want to do this?".localized
        btnPopupNoteDeleteYes.setTitle("Yes".localized, for: .normal)
        btnPopupNoteDeleteNo.setTitle("No".localized, for: .normal)
    }
    
    // MARK: - UIBUTTON CLICK METHODS
    @IBAction func onClickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - POPUP DELETE NOTE ALERT - UIBUTTON CLICK METHODS
    @IBAction func onClickYesDeleteNote(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        removePopup(view: popupNoteDeleteAlert)
        if deleteNoteIndex != nil {
            arrNotes.remove(at: deleteNoteIndex)
            tblNotes.reloadData()
        }
    }
    
    @IBAction func onClickNoDeleteNote(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        removePopup(view: popupNoteDeleteAlert)
        deleteNoteIndex = nil
    }
    
}
