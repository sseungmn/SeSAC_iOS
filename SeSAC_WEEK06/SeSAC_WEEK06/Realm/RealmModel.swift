//
//  RealmModel.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/02.
//

import Foundation
import RealmSwift

// UserDiary: 테이블 이름
// @Persisted : 칼럼

class UserDiary: Object {
    @Persisted var diaryTitle: String  // 제목 (필수)
    @Persisted var content: String? // 내용 (옵션)
    @Persisted var writeDate = Date() // 작성 날짜 (필수)
    @Persisted var regDate = Date() // 등록일 (필수)
    
    // PK(필수): Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, content: String?, writeDate: Date, regDate: Date) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
    }
}
