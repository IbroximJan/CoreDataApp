//
//  GetStartedVC.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 24/01/2022.
//

import UIKit
import SnapKit

class GetStartedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func initViews() {
        view.backgroundColor = .appWhite
        
        let noteButton = Button(title: "Notes", fontSize: 20, weight: .semibold, titleColor: .appWhite)
        noteButton.tag = 0
        noteButton.addTarget(self, action: #selector(goToNextVC(sender:)), for: .touchUpInside)
        noteButton.backgroundColor = .appOrange
        view.addSubview(noteButton)
        noteButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(45)
        }
        
        let netButton = Button(title: "Save from Net", fontSize: 20, weight: .semibold, titleColor: .appWhite)
        netButton.tag = 1
        netButton.addTarget(self, action: #selector(goToNextVC(sender:)), for: .touchUpInside)

        netButton.backgroundColor = .appDarkBlue
        view.addSubview(netButton)
        netButton.snp.makeConstraints { make in
            make.top.equalTo(noteButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(45)

        }
        
    }
    
    
    
    @objc func goToNextVC(sender: UIButton) {
        switch sender.tag{
        case 0:
            let vc = NoteVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            break;
        case 1:
            let vc = SavingFromNet()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            break
        default:
            return
        }
        
    }
    

 

}
