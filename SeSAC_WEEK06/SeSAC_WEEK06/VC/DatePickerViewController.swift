//
//  DatePickerViewController.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .wheels
    }
}
