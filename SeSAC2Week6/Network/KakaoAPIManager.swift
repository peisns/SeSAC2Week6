//
//  KakaoAPIManager.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class kakaoAPIManager {
    static let shared = kakaoAPIManager()
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
       
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
