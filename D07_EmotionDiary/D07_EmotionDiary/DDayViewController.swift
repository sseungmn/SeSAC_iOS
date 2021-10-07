//
//  DDayViewController.swift
//  D07_EmotionDiary
//
//  Created by OHSEUNGMIN on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        print(datePicker.date)
        print(sender.date)
        
        // DateFormatter: 1. DateFormat 설정 2. Location 지정
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd"
        
        let value = format.string(from: sender.date)
        print(value)
        
        // 100일 뒤 : TimeInterval, Calendar로 구현 가능
        let afterDate = Date(timeInterval: 86400 * 100 , since: sender.date)
        print(afterDate)
    }
    
}
