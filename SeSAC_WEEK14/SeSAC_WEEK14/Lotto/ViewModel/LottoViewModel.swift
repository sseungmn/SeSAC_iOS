//
//  LottoViewModel.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/28.
//

import Foundation

class LottoViewModel {
  
  var lotto1 = Observable<Int>(3)
  var lotto2 = Observable<Int>(10)
  var lotto3 = Observable<Int>(21)
  var lotto4 = Observable<Int>(41)
  var lotto5 = Observable<Int>(22)
  var lotto6 = Observable<Int>(8)
  var lotto7 = Observable<Int>(39)
  var lottoMoney: Observable<String> = Observable("")
  
  func fetchLottoAPI(_ number: Int) {
    APIService.lotto(number) { lotto, error in
      
      guard let lotto = lotto else {
        return
      }

      self.lotto1.value = lotto.drwtNo1
      self.lotto2.value = lotto.drwtNo2
      self.lotto3.value = lotto.drwtNo3
      self.lotto4.value = lotto.drwtNo4
      self.lotto5.value = lotto.drwtNo5
      self.lotto6.value = lotto.drwtNo6
      self.lotto7.value = lotto.bnusNo
      self.lottoMoney.value = self.format(for: lotto.firstWinamnt)
    }
  }
  
  func format(for number: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    let result = numberFormatter.string(for: number)!
    return result
  }
}
