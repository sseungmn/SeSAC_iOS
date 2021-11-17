//
//  ViewController.swift
//  D05_newlyCoinedWord
//
//  Created by OHSEUNGMIN on 2021/10/05.
//

import UIKit

var wordDict: [String: String] = ["윰차": "유명인과 무명인을 차별한다는 뜻",
                                  "실매": "유튜브 라이브 방송에서 원활한 소통을 위해 실시간으로 시청자들을 응대하고 기본 정보를 제공하는 실시간 매니저를 말함.",
                                  "만반잘부": "만나서 반가워 잘부탁해",
                                  "꾸안꾸": "꾸민듯 안꾸민듯",
                                  "설참": "설명참고",
                                  "삼귀자": "연애를 시작하기 전 썸 단계!",
                                  "구취": "구독취소"
]

class ViewController: UIViewController {

    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var tagFirstButton: UIButton!
    @IBOutlet var tagSecondButton: UIButton!
    @IBOutlet var tagThirdButton: UIButton!
    @IBOutlet var tagFourthButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        setTagTitle()
        for button in [tagFirstButton, tagSecondButton, tagThirdButton, tagFourthButton]{
            button!.contentMode = .scaleAspectFit
            button!.setTitleColor(.black, for: .normal)
            button!.layer.borderWidth = 1
            button!.layer.borderColor = UIColor.black.cgColor
            button!.layer.cornerRadius = 10
        }
        
        resultLabel.numberOfLines = 0
    }
    
    @IBAction func tagButtonClicked(_ sender: UIButton) {
        userTextField.text = sender.currentTitle
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setTagTitle() {
        let dictKey = Array(wordDict.keys.shuffled())
        for (index, button) in [tagFirstButton, tagSecondButton, tagThirdButton, tagFourthButton].enumerated() {
            button?.setTitle(dictKey[index], for: .normal)
        }
    }
    
    // MARK: Search
    @IBAction func serachButtonClicked(_ sender: UIButton) {
        searchTag()
        setTagTitle()
    }
    @IBAction func returnKeyEntered(_ sender: UITextField) {
        searchTag()
        setTagTitle()
    }
    
    func searchTag() {
        // userTextField.text 초기화는 구현하지 않음.
        // -> 어떤 단어가 검색됐는지 알아야 하기 때문에.
        
        guard let text = userTextField.text else {
            alertError(error: .inputError)
            return
        }
        
        if let meaning = wordDict[text] {
            resultLabel.text = meaning
        }else {
            alertError(error: .keywordError)
        }
        view.endEditing(true)
    }
    
    // MARK: Error
    func alertError(error: Error) {
        let okAction = UIAlertAction(title: "확인", style: .default) {_ in }
        let alert: UIAlertController
        switch error {
        case .inputError:
            alert = UIAlertController(title: "입력 오류", message: "입력이 존재하지 않습니다.", preferredStyle: .alert)
        case .keywordError:
            alert =  UIAlertController(title: "키워드 오류", message: "해당 단어를 사전에서 찾을 수 없습니다.", preferredStyle: .alert)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    enum Error  {
        case keywordError, inputError
    }
}


