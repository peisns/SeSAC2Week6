//
//  Endpoint.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/08.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    
    //저장 프로퍼티를 못쓰는 이유? enum은 인스턴스 생성 불가능하기 때문에...
    //연산 프로퍼티는 메서드처럼 동작하기때문에 사용가능함
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
    ////////////////////////////////////////////////////////위 구조 다시 공부해볼 것
    
    static let kakaoBlog = URL.kakaoAPIBaseURL + "blog"
    static let kakaoCafe = "https://dapi.kakao.com/v2/search/cafe"
}
