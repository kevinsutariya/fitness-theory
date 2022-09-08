//
//  NotesVCTableView.swift
//  Fitness Theory
//
//  Created by Jay Borania on 24/07/22.
//

import Foundation
import UIKit

extension NotesVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITABLEVIEW DELEGATE & DATASOURCE METHODS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == arrNotes.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteItemTableViewCell") as? NoteItemTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.lblNoteTitle.text = "new_note".localized
            cell.stackActionButtons.isHidden = true
            cell.imgExpandCollapseNote.image = UIImage(named: "add-note")
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteItemTableViewCell") as? NoteItemTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.cellIndex = indexPath
        cell.delegate = self
        cell.lblNoteTitle.text = arrNotes[indexPath.row].note_title
        cell.stackActionButtons.isHidden = !arrNotes[indexPath.row].is_open
        cell.imgExpandCollapseNote.image = arrNotes[indexPath.row].is_open ? UIImage(named: "down-arrow") : UIImage(named: "right-arrow")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppSounds.shared.playClickSound()
        if indexPath.row == arrNotes.count {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as? NoteDetailsVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return
        }
        arrNotes[indexPath.row].is_open = !arrNotes[indexPath.row].is_open
        tblNotes.reloadData()
    }
}

extension NotesVC: NoteItemTableViewCellDelegate {
    // MARK: - NOTE ITEM DELEGATE METHODS
    
    func openNoteAt(index: IndexPath?) {
        AppSounds.shared.playClickSound()
        guard let index = index else { return }
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as? NoteDetailsVC {
            vc.is_edit_note = true
            vc.note_item = arrNotes[index.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func deleteNoteAt(index: IndexPath?) {
        AppSounds.shared.playClickSound()
        guard let index = index else { return }
        deleteNoteIndex = index.row
        addPopup(view: popupNoteDeleteAlert, viewController: self)
    }
}
