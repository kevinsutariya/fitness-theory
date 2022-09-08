//
//  HelperClass.swift
//  Hockey World
//
//  Created by Jay Borania on 07/07/22.
//

import Foundation
import UIKit
import AVFoundation

struct AppSounds {
    static let shared = AppSounds()
    let PressingTheButton = "Pressing-the-button"
    var audioPlayer = AVAudioPlayer()
    
    init() {
        // address of the music file.
        let music = Bundle.main.path(forResource: PressingTheButton, ofType: "mp3")
        // copy this syntax, it tells the compiler what to do when action is received
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music! ))
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("error AppSounds: \(error)")
        }
        
    }
    
    func playClickSound() {
        guard UserDefaults.standard.bool(forKey: "IS_SOUND_ON") != false else { return }
        audioPlayer.play()
    }
}

struct AppColors {
    static let accentGreenColor = UIColor(hexString: "00835D")
    static let yellowColor = UIColor(hexString: "E29800")
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var trimmedString: String {
        return self.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r", with: "")
    }
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width + 8, height: size.height + 8)
    }
}

// MARK: - ADD REMOVE POPUP METHOD

func addPopup(view: UIView, viewController: UIViewController) {
    view.frame = UIApplication.shared.delegate?.window??.frame ?? view.frame
    view.alpha = 0
    viewController.view.addSubview(view)
    UIView.animate(withDuration: 0.2) {
        view.alpha = 1
    }
}

func removePopup(view: UIView) {
    UIView.animate(withDuration: 0.2, animations: {
        view.alpha = 0
    }) { (success) in
        view.removeFromSuperview()
    }
}
