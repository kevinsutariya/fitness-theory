//
//  SettingsVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 24/07/22.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblSoundOnOff: UILabel!
    @IBOutlet weak var btnMute: UIButton!
    @IBOutlet weak var btnUnmute: UIButton!
    
    @IBOutlet weak var lblChangeLanguage: UILabel!
    @IBOutlet weak var btnRussianLanguage: UIButton!
    @IBOutlet weak var btnEnglishLanguage: UIButton!
    
    @IBOutlet weak var lblScreenLight: UILabel!
    @IBOutlet weak var sliderScreenLight: UISlider!
    @IBOutlet weak var btnBackToMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblHeaderTitle.text = "Settings".localized
        lblSoundOnOff.text = "Mute on/off".localized
        lblChangeLanguage.text = "Changing Language".localized
        lblScreenLight.text = "Screen light".localized
        btnBackToMenu.setTitle("Back to menu".localized, for: .normal)
        
        sliderScreenLight.setThumbImage(#imageLiteral(resourceName: "slider-thumb"), for: .normal)
        sliderScreenLight.setMinimumTrackImage(UIImage(named: "slider-bg"), for: .normal)
        sliderScreenLight.setMaximumTrackImage(UIImage(named: "slider-bg"), for: .normal)
        sliderScreenLight.setValue(Float(UIScreen.main.brightness), animated: true)

        if let selectedLanguage = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
            if selectedLanguage.contains("en") {
                btnRussianLanguage.isSelected = false
                btnEnglishLanguage.isSelected = true
            } else if selectedLanguage.contains("ru") {
                btnRussianLanguage.isSelected = true
                btnEnglishLanguage.isSelected = false
            }
        }
        
        if let isSoundOn = UserDefaults.standard.value(forKey: "IS_SOUND_ON") as? Bool {
            let btn = UIButton()
            btn.tag = isSoundOn ? 1 : 0
            onClickTurnSoundOnOFF(btn)
        }
    }
    
    // MARK: - UIBUTTON CLICK METHODS
    @IBAction func onClickBack(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickTurnSoundOnOFF(_ sender: UIButton) {
        if sender.tag == 1 {
            btnMute.setBackgroundImage(nil, for: .normal)
            btnUnmute.setBackgroundImage(UIImage(named: "button-selected-bg"), for: .normal)
            
            btnMute.tintColor = AppColors.yellowColor
            btnUnmute.tintColor = .black
            
            btnMute.borderColor = AppColors.yellowColor
            btnUnmute.borderColor = .clear
            
            UserDefaults.standard.set(true, forKey: "IS_SOUND_ON")
        } else {
            btnMute.setBackgroundImage(UIImage(named: "button-selected-bg"), for: .normal)
            btnUnmute.setBackgroundImage(nil, for: .normal)
            
            btnMute.tintColor = .black
            btnUnmute.tintColor = AppColors.yellowColor
            
            btnMute.borderColor = .clear
            btnUnmute.borderColor = AppColors.yellowColor
            
            UserDefaults.standard.set(false, forKey: "IS_SOUND_ON")
        }
    }
    
    @IBAction func onClickChangeLanguageToRussian(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        btnRussianLanguage.isSelected = true
        btnEnglishLanguage.isSelected = false
        
        UserDefaults.standard.set(["ru"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.setLanguage("ru")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navSplashVC")
            (UIApplication.shared.delegate as? AppDelegate)?.setRootViewController(vc: vc)
        }
    }
    
    @IBAction func onClickChangeLanguageToEnglish(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        btnRussianLanguage.isSelected = false
        btnEnglishLanguage.isSelected = true
        
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.setLanguage("en")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navSplashVC")
            (UIApplication.shared.delegate as? AppDelegate)?.setRootViewController(vc: vc)
        }
    }
    
    // MARK: - UISLIDER METHODS
    @IBAction func sliderDidSlide(_ sender: UISlider) {
        UIScreen.main.brightness = CGFloat(sliderScreenLight.value)
    }
}
