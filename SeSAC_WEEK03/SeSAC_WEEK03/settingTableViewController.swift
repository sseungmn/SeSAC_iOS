//
//  settingTableViewController.swift
//  SeSAC_03Week
//
//  Created by OHSEUNGMIN on 2021/10/13.
//

import UIKit

class settingTableViewController: UITableViewController {
    let settings: [ [String]] = [
        ["전체 설정", "공지사항", "실험실" ,"버전 정보"],
        ["개인 설정", "개인/보안", "알림", "채팅", "멀티프로필"],
        ["기타", "고객센터/도움말"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .systemGray2
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count - 1;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else { return UITableViewCell() }
        cell.textLabel?.text = settings[indexPath.section][indexPath.row + 1]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section][0];
    }
}
