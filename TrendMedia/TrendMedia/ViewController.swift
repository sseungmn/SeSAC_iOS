//
//  ViewController.swift
//  D13_TrendMedia
//
//  Created by OHSEUNGMIN on 2021/10/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mediaTypeContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaTypeContainer.layer.cornerRadius = CGFloat(10)
        mediaTypeContainer.layer.shadowRadius = CGFloat(10)
        mediaTypeContainer.layer.shadowColor = UIColor.systemGray2.cgColor
        mediaTypeContainer.layer.shadowOpacity = 0.8
        
    }
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        // 1. 스토리보드 특정
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 내 여러 뷰컨트롤러 중 전환하고 싶은 뷰컨트롤러 가져오기
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        // 2.5. 화면 전환시 Transition Style 추가 가능
        vc.modalPresentationStyle = .fullScreen
        
        // 3. 화면 전환 방법을 선택해서 present
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaPreviewCell.identifier) as? MediaPreviewCell else {
            return UITableViewCell()
        }
        let row = tvShow[indexPath.row]
        cell.contentGenreLabel.text = "#\(row.genre)"
        cell.contentTitleLabel.text = row.title
        //url에 정확한 이미지 url 주소를 넣는다.
        let url = URL(string: row.backdropImage)
        //DispatchQueue를 쓰는 이유 -> 이미지가 클 경우 이미지를 다운로드 받기 까지 잠깐의 멈춤이 생길수 있다. (이유 : 싱글 쓰레드로 작동되기때문에)
        //DispatchQueue를 쓰면 멀티 쓰레드로 이미지가 클경우에도 멈춤이 생기지 않는다.
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.previewImage.image = UIImage(data: data!)
            }
        }
        cell.contentStarringLabel.text = row.starring
        cell.contentReleaseDateLabel.text = row.releaseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    

}

