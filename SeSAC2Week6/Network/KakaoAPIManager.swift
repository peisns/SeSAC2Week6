//
//  KakaoAPIManager.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

struct User {
    fileprivate let name = "고래밥" // 같은 스위프트 파일에서 다른 클래스, 구조체 사용 가능. 다른 스위프트 파일에서는 X
    private let age = 11 // 같은 스위프트 파일 내에서 같은 타입
}

extension User {
    func example() {
        print(self.name, self.age)
    }
}

struct Person {
    func example() {
        let user = User()
        user.name
//        user.age // X
    }
}


class kakaoAPIManager {
    static let shared = kakaoAPIManager()
    private init() { }
    
    private let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
       
    func callRequest(type:Endpoint, query: String, completionHandler: @escaping (JSON) -> () ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
        
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
