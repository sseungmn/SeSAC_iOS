//
//  SettingViewController.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/02.
//

import UIKit
import Zip
import MobileCoreServices

/*
 백업하기
 - 사용자의 아이폰 저장 공간 확인
    - 부족 : 백업 불가
 - 백업 진행
    - 어떤 데이터도 없는ㄱ경우라면 백업할 데이터가 없다고 안내
    - 백업 가능한 파일 여부 확인 realm, folder
    - Progress + UI 인터렉션 금지
 - zip
    - 백업 완료 시점에
    - Progress + UI 인터렉션 허용
 */
/*
 복구하기
 - 사용자의 아이폰 저장 공간 확인
 - 파일 앱
    - zip 파일만 소팅
    - zip 파일 선택
 - zip -> unzip
    - 백업 파일 이름 확인
    - 압축 해제
        - 백업 파일 확인 : 폴더, 파일 이름
        - 정상적인 파일 인가
 - 백업 당시 데이터랑 지금 현재 앱에서 사용중인 데이터를 어떻게 합칠건지에 대한 고려
     - 백업 데이터 선택
 */

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 1. 도큐먼트 폴더 위치
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    @IBAction func activityButtonClicked(_ sender: UIButton) {
        presentActivityViewController()
    }
    
    // 7. 공유
    func presentActivityViewController() {
        // 압축파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        var urlPaths = [URL]()
        // 1. 도큐먼트 폴더 위치
        if let path = documentDirectoryPath() {
            // 2. 백업하고자 하는 파일 URL 확인
            // 이미지 같은 경우 백업 편의성을 위해 폴더를 생성하고, 폴더 내에 이미지를 저장하는것이 효율적이다.
            let realm = (path as NSString).appendingPathComponent("default.realm")
            // 3. 백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. URL배열에 백업 파일 URL 추가
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다.")
            }
        }
        
        // 4번 배열에 대해서 압축 파일 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
            print("압축 경로 : \(zipFilePath)")
            presentActivityViewController()
        } catch {
            print("Something went wrong")
        }
    }
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
       // 복구 1. 파일앱 열기 + 확장자
        // import MobileCoreServices
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
//        let documentPicker = UIDocumentPickerViewController.init(forOpeningContentTypes: [UTType.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
       
        print(#function)
        // 복구 - 2. 선택한 파일에 대한 경로를 가져온다.
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 복구 - 3. 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            // 기존에 복구하고자 하는 zip파일을 도큐먼트에 가지고 있을 경우, 도큐먼트에 위치한 zip을 압축 해제 하면 됨
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                print("ERROR")
            }
            
        } else {
            
            // 파일 앱의 zip -> Document 폴더에 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                print("ERROR")
            }
            
        }
    }
}
