//: [Previous](@previous)

import Foundation

func checkDateFormat(text: String) -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    return format.date(from: text) == nil ? false : true
}

func validateUserInput(text: String) -> Bool {
    // 입력한 값이 빈 값인 경우를 확인
    guard !(text.isEmpty) else {
        print("빈 값입니다.")
        return false
    }
    
    // 입력한 값이 숫자인지 확인
    guard Int(text) != nil else {
        print("숫자가 아닙니다.")
        return false
    }
    
    // 입력한 값이 날짜 형태로 변환이 가능한지 확인
    guard checkDateFormat(text: text) else {
        print("날짜 형태가 올바르지 않습니다.")
        return false
    }
    
    return true
}

if validateUserInput(text: "20220000") {
    print("검색을 할 수 있음")
} else {
    print("검색을 할 수 없음")
}

// --------------------------------------
// 오류 처리 패턴 : {do try catch} & Error Protocol
enum ValidationError: Error {
    case emptyString
    case invalidInt
    case invalidDate
}

func validateUserInputError(text: String) throws -> Bool {
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        throw ValidationError.invalidInt
    }
    
    guard checkDateFormat(text: text) else {
        throw ValidationError.invalidDate
    }
    return true
    
}

do {
    let result = try validateUserInputError(text: "20201100")
    print(result, "성공")
} catch ValidationError.emptyString {
    print("값이 비어 있습니다.")
} catch ValidationError.invalidInt {
    print("숫자 값이 아닙니다.")
} catch ValidationError.invalidDate {
    print("날짜 값이 아닙니다.")
}
//: [Next](@next)
