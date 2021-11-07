//
//  SearchViewController.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = localRealm.objects(UserDiary.self)
        print("Realm is located at : \n", localRealm.configuration.fileURL)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            print("Failed")
            return UITableViewCell()
        }
        let task = tasks[indexPath.row]
//        cell.img.image = loadImageFromDocumentDirectory(imageName: "\(task._id).jpg")
//        cell.img.image = loadImageFromDocumentDirectory(imageName: "\(task._id).jpg")
        cell.titleLabel.text = task.diaryTitle
        cell.dateLabel.text = task.writeDate.toCustomFormattedString()
        cell.contentLabel.text = task.content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    // 본래는 화면 전환 + 값 전달 후 새로운 화면에서 수정이 적합
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskToUpdate = tasks[indexPath.row]
        // 1. 수정 - 레코드에 대한 값 수정
        try! localRealm.write {
            taskToUpdate.diaryTitle = "새롭게 수정해봅시다.."
            taskToUpdate.content = "현대차는 첫 전용 전기차인 아이오닉 5의 인기에 힘입어 지난달까지 전기차 판매량에서 테슬라를 앞질렀고 4분기 역시 그럴것같네요."
            tableView.reloadData()
        }
        
        // 2. 일괄 수정
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "writeDate")
//            tasks.setValue("쌜롭게 일기쓰기", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
//
//        // 3. 수정: pk 기준으로 수정할 때 사용(권장 x)
//        try! localRealm.write {
//            let update = UserDiary(value: [ "_id" : taskToUpdate._id, "diaryTitle": "애마ㅏㄴ 바꾸고 싶어"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        // 4.
//        try! localRealm.write {
//            localRealm.create(UserDiary.self,  value: [ "_id": taskToUpdate._id, "diaryTitle" : "얘만 바꾸고 싶어"], update:.modified)
//            tableView.reloadData()
//        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        deleteImageToDocumentDirectory(imageName: "\(tasks[indexPath.row]._id).jpg")
        try! localRealm.write {
            localRealm.delete( tasks[indexPath.row] )
            tableView.reloadData()
        }
    }
    
    // 도큐먼트 폴더 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first  {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
    
    func deleteImageToDocumentDirectory(imageName: String) {
        // 1. 이미지 저장 경로 설정: 도큐먼트 폴더(.documentDirectory), FileManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        // 4 - 1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            // 4 - 2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
    }
}
