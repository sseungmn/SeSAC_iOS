//
//  KakaoTalk.swift
//  SeSAC_WEEK12
//
//  Created by SEUNGMIN OH on 2021/12/15.
//

import UIKit
import SnapKit

class KakaoTalkViewController: UIViewController {
    // MARK: TopMenuContainer
    let topMenuContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    let cancelButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "xmark"), for: .normal)
        tmp.tintColor = .systemGray
        return tmp
    }()
    
    let TopHstackView: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .horizontal
        tmp.distribution = .fillEqually
        tmp.alignment = .fill
        return tmp
    }()
    
    let giftButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.tintColor = .systemGray2
        tmp.setImage(UIImage(systemName: "gift"), for: .normal)
        return tmp
    }()
    
    let QRButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.tintColor = .systemGray2
        tmp.setImage(UIImage(systemName: "qrcode"), for: .normal)
        return tmp
    }()
    
    let settingButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.tintColor = .systemGray2
        tmp.setImage(UIImage(systemName: "gearshape"), for: .normal)
        return tmp
    }()
    
    func setTopMenuContainerConstraint() {
        view.addSubview(topMenuContainer)
        topMenuContainer.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(13)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(13)
            make.height.equalTo(25)
        }
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.top.equalTo(topMenuContainer)
            make.size.equalTo(25)
        }
        
        view.addSubview(TopHstackView)
        TopHstackView.snp.makeConstraints { make in
            make.right.top.equalTo(topMenuContainer)
            make.height.equalTo(25)
            make.width.equalTo(110)
        }
        
        [giftButton, QRButton, settingButton].forEach { button in
            button.imageView?.bounds.size.height = 10
        }
        TopHstackView.addArrangedSubview(giftButton)
        TopHstackView.addArrangedSubview(QRButton)
        TopHstackView.addArrangedSubview(settingButton)
    }
    
    // MARK: ProfileContainer
    let profileContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    let ProfileVStackView: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .vertical
        tmp.alignment = .center
        tmp.spacing = 5
        return tmp
    }()
    
    let profileImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.image = UIImage(named: "profile")
        tmp.layer.cornerRadius = 40
        tmp.layer.masksToBounds = true
        return tmp
    }()
    
    let profileNameLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "Minios"
        tmp.font = .boldSystemFont(ofSize: 16)
        tmp.textColor = .white
        return tmp
    }()
    
    let profileStatusMessageLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "배고파서 배고프다. 졸려서 졸립다."
        tmp.font = .systemFont(ofSize: 12)
        tmp.textColor = .systemGray2
        return tmp
    }()
    
    func setProfileContainerConstraint() {
        view.addSubview(profileContainer)
        profileContainer.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.height.equalTo(150)
            make.left.right.equalTo(view)
            make.bottom.equalTo(divisionLineView.snp.top).inset(-20)
        }
        
        profileContainer.addSubview(ProfileVStackView)
        ProfileVStackView.snp.makeConstraints { make in
            make.center.equalTo(profileContainer)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        ProfileVStackView.addArrangedSubview(profileImageView)
        ProfileVStackView.addArrangedSubview(profileNameLabel)
        ProfileVStackView.addArrangedSubview(profileStatusMessageLabel)
    }
    
    // MARK: DivisionLineView
    let divisionLineView: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = .systemGray2
        return tmp
    }()
    
    func setDivisionLineViewConstraint() {
        view.addSubview(divisionLineView)
        divisionLineView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.height.equalTo(1)
            make.bottom.equalTo(bottomMenuContainer.snp.top).inset(-20)
        }
    }
    
    // MARK: BottomMenuContainer
    let bottomMenuContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    let bottomHStack: UIStackView = {
        let tmp = UIStackView()
        tmp.axis = .horizontal
        tmp.alignment = .fill
        tmp.distribution = .fill
        return tmp
    }()
    
    let selfChatButton: KakaoButton = {
        let tmp = KakaoButton(type: .system)
        tmp.setImage(UIImage(systemName: "message.fill"), for: .normal)
        tmp.setTitle("나와의 채팅", for: .normal)
        return tmp
    }()
    
    let editProfileButton: KakaoButton = {
        let tmp = KakaoButton(type: .system)
        tmp.setImage(UIImage(systemName: "pencil.tip"), for: .normal)
        tmp.setTitle("프로필 편집", for: .normal)
        return tmp
    }()
    
    let kakaoStoryButton: KakaoButton = {
        let tmp = KakaoButton(type: .system)
        tmp.setImage(UIImage(systemName: "quote.closing"), for: .normal)
        tmp.setTitle("카카오스토리", for: .normal)
        return tmp
    }()
    
    func setbottomMenuContainerConstraint() {
        view.addSubview(bottomMenuContainer)
        bottomMenuContainer.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.height.equalTo(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        bottomMenuContainer.addSubview(bottomHStack)
        bottomHStack.snp.makeConstraints { make in
            make.center.equalTo(bottomMenuContainer)
        }
        
        bottomHStack.addArrangedSubview(selfChatButton)
        bottomHStack.addArrangedSubview(editProfileButton)
        bottomHStack.addArrangedSubview(kakaoStoryButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(frame: view.bounds)
        bg.image = UIImage(named: "kakaotalk_backgorund")
        view.addSubview(bg)
        
        setTopMenuContainerConstraint()
        
        setbottomMenuContainerConstraint()
        setDivisionLineViewConstraint()
        setProfileContainerConstraint()
        
    }
}
