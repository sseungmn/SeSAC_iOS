//
//  PersonViewModel.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/28.
//

import Foundation

class PersonViewModel {
  
  var person: Observable<Person> = Observable(Person(page: 0, results: [], totalPages: 0, totalResults: 0))
  
  func fetchPerson(query: String, page: Int) {
    
    APIService.person(query, page: page) { person, error in
      guard let person = person else {
        return
      }
      
      self.person.value = person

    }
  }
}

extension PersonViewModel {
  var numberOfRowInSection: Int {
    return person.value.results.count
  }
  
  func cellForRowAt(at indexPath: IndexPath) -> Result {
    return person.value.results[indexPath.row]
  }
}
