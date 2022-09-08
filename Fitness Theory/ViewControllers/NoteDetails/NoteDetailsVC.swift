//
//  NoteDetailsVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 24/07/22.
//

import UIKit

class NoteDetailsVC: UIViewController {

    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var txtNoteTitle: UITextView!
    @IBOutlet weak var txtNoteDescription: UITextView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var is_edit_note = false
    var note_item: NoteItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtNoteTitle.isEditable = !is_edit_note
        txtNoteDescription.isEditable = !is_edit_note
        
        lblHeaderTitle.text = "Notes".localized
        btnEdit.setTitle("edit".localized, for: .normal)
        btnSave.setTitle("save".localized, for: .normal)
        
        btnEdit.alpha = is_edit_note ? 1.0 : 0.5
        btnEdit.isUserInteractionEnabled = is_edit_note
        
        if is_edit_note {
            txtNoteTitle.text = note_item.note_title
            txtNoteDescription.text = note_item.note_description
            
            txtNoteTitle.alpha = 0.75
            txtNoteDescription.alpha = 0.75
        } else {
            txtNoteTitle.text = "New note team:".localized
            txtNoteTitle.textColor = .white.withAlphaComponent(0.5)
            
            txtNoteDescription.text = "New note text:".localized
            txtNoteDescription.textColor = .white.withAlphaComponent(0.5)
        }
    }
    
    // MARK: - UIBUTTON CLICK METHODS
    @IBAction func onClickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickEdit(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        txtNoteTitle.isEditable = is_edit_note
        txtNoteDescription.isEditable = is_edit_note
        
        txtNoteTitle.alpha = 1.0
        txtNoteDescription.alpha = 1.0
        
        btnEdit.alpha = 0.5
        btnEdit.isUserInteractionEnabled = false
    }
    
    @IBAction func onClickSave(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        let alert = UIAlertController(title: "Success", message: "Note saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension NoteDetailsVC: UITextViewDelegate {
    // MARK: - UITEXTVIEW DELEGATE METHODS
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .white.withAlphaComponent(0.5) {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == txtNoteTitle {
            if textView.text == "" {
                textView.text = "New note team:".localized
                textView.textColor = .white.withAlphaComponent(0.5)
            }
        } else if textView == txtNoteDescription {
            if textView.text == "" {
                textView.text = "New note text:".localized
                textView.textColor = .white.withAlphaComponent(0.5)
            }
        }
    }
}
