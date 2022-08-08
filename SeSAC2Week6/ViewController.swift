//
//  ViewController.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/08.
//

import UIKit

/*
 1. html tag <> </> 기능 활용
 2. 문자열 대체 메서드
 */

/*
 TableView automaticDimension
 - 컨텐츠 양에 따라서 셀 높이가 자유롭게
 - 조건: 레이블의 numberOfLines = 0
 - 조건: tableView height를 automaticDimension
 - 조건: 레이아웃은 네가지의 여백을 잡는 것으로 설정
 */

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    var blogList: [String] = []
    var cafeList: [String] = []
    
    var isExpanded = false // false 2줄, true 0줄
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션과 모든 셀에 대해서 유동적으로 잡겠따는 의미
        
        searchBlog()
    }
    
    func searchBlog() {
        kakaoAPIManager.shared.callRequest(type: .blog, query: "고래밥") { json in
            
            self.blogList = json["documents"].arrayValue.map { $0["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            self.searchCafe()
        }
    }
    
    func searchCafe() {
        kakaoAPIManager.shared.callRequest(type: .cafe, query: "고래밥") { json in
            
            self.cafeList = json["documents"].arrayValue.map { $0["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func expandCell(_ sender: UIBarButtonItem) {
        isExpanded = !isExpanded
        tableView.reloadData()
    }
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as? kakaoCell else { return UITableViewCell() }
        
        cell.testLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        cell.testLabel.numberOfLines = isExpanded ? 0 : 2
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색결과" : "카페 검색결과"
    }
}

class kakaoCell: UITableViewCell {
    
    @IBOutlet weak var testLabel:UILabel!
    
}
