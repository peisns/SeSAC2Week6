//
//  URL+Extension.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/08.
//

import Foundation

extension URL {
    static let kakaoAPIBaseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointString(_ endpoint:String) -> String {
        return kakaoAPIBaseURL + endpoint
    }
}
