//
//  CalendarViewController.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/02.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var allCountLabel: UILabel!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        
//        let allCount = localRealm.objects(UserDiary.self).count
        let allCount = getAllDiaryCountFromUserDiary()
        allCountLabel.text = String(allCount)
        
//        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: false).first?.diaryTitle
//
//        let full = localRealm.objects(UserDiary.self).filter("content != ni").count
//
//        let favorite = localRealm.objects(UserDiary.self).filter("favorite = false")
//
//        // String -> ' '안에 써줘야한다 , AND OR
//        let search = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAIN[c] '일기' AND content CONTAIN[c] '살아와'")
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "_Title_"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "_Subtitle_"
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star")
//    }
//
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // 11//2 3개의 일기라면 3개를, 없다면 X. 1개라면 1개
        return tasks.filter("writeDate = %@", date).count
    }
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        <#code#>
//    }
}
