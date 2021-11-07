//
//  Date+Extension.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/06.
//

import Foundation

// 수업시간에 만든 데이터포멧 익스텐션 활용법
extension DateFormatter {
    static var customFormat: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyy년 MM월 dd일"
        return date
    }
}
