//
//  Backup&Restore.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/11/05.
//

import Foundation
import Zip
import MobileCoreServices
import UIKit
import UniformTypeIdentifiers
import MBProgressHUD

extension BackupViewController: UIDocumentPickerDelegate {
    
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
    
    func presentActivityViewController() {
        // 압축파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func backup() {
        
        var urlPaths = [URL]()
        // 1. 도큐먼트 폴더 위치
        if let path = documentDirectoryPath() {
            // 2. 백업하고자 하는 파일 URL 확인
            let realm = (path as NSString).appendingPathComponent("default.realm")
            // 3. 백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다.")
            }
        }
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive")
            print("압축 경로 : \(zipFilePath)")
            presentActivityViewController()
        } catch {
            print("Something went wrong while Zip")
        }
        
    }
    
    func restore() {
        // 복구 1. 파일앱 열기 + 확장자
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        // 복구 - 2. 선택한 파일에 대한 경로를 가져온다.
        guard let selectedFileURL = urls.first else { return }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        print("sandboxFileURL : \(sandboxFileURL)")
        
        // 복구 - 3. 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("==>복구하고자 하는 zip파일을 도큐먼트에 갖고있음")
            // 기존에 복구하고자 하는 zip파일을 도큐먼트에 갖고있을 경우, 도큐먼트에 위치한 zip을 압축해제 하면 됨
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                try Zip.unzipFile(fileURL,
                                  destination: documentDirectory,
                                  overwrite: true,
                                  password: nil,
                                  progress: { progress in
                                        print("progress: \(progress)")
                                  },
                                  fileOutputHandler: { unzippedFile in
                                        print("unzippedFile: \(unzippedFile)")
                                        MBProgressHUD.hide(for: self.view, animated: true)
                                        exit(0)
                                  })
            } catch {
                print("ERROR")
            }
        } else {
            print("==>파일앱의 zip을 도큐먼트에 복사")
            // 파일 앱의 zip -> Document 폴더에 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL,
                                  destination: documentDirectory,
                                  overwrite: true,
                                  password: nil,
                                  progress: { progress in
                                        print("progress: \(progress)")
                                    },
                                  fileOutputHandler: { unzippedFile in
                                        print("unzippedFile: \(unzippedFile)")
                                        MBProgressHUD.hide(for: self.view, animated: true)
                                        exit(0)
                                    })
            } catch {
                print("ERROR")
            }
        }
    }
}
