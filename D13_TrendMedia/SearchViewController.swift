//
//  SearchViewController.swift
//  D13_TrendMedia
//
//  Created by OHSEUNGMIN on 2021/10/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func exitButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShow.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let row = tvShow[indexPath.row]
        cell.titleLabel.text = row.title
        //url에 정확한 이미지 url 주소를 넣는다.
        let url = URL(string: row.backdropImage)
        //DispatchQueue를 쓰는 이유 -> 이미지가 클 경우 이미지를 다운로드 받기 까지 잠깐의 멈춤이 생길수 있다. (이유 : 싱글 쓰레드로 작동되기때문에)
        //DispatchQueue를 쓰면 멀티 쓰레드로 이미지가 클경우에도 멈춤이 생기지 않는다.
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.previewImageView.image = UIImage(data: data!)
            }
        }
        cell.detailLabel.text = "\(row.releaseDate) | \(row.region)"
        cell.overviewLabel.text = row.overview
        cell.backgroundColor = UIColor(named: "serachViewBackground")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return (UIScreen.main.bounds.height - 51) / 7
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "serachViewBackground")
    }
}
