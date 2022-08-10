//
//  TMDBAPIManager.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON
import SwiftUI

/*
 TMDB API
 https://developers.themoviedb.org/3/tv-seasons/get-tv-season-details
 */

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    private init() { }
    
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    func callRequest(query: Int, completionHandler: @escaping ([String]) -> () ) {
        let seasonURL = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.TMDB)&language=ko-KR"
        
        AF.request(seasonURL, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //json
                let stillArray = json["episodes"].arrayValue.map { $0["still_path"].stringValue }
                
                completionHandler(stillArray)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestEpisodeimage(completionHandler:@escaping ([[String]]) -> ()) {
        //어떤 문제가 생길 수 있을까?
        //1. 순서 보장 X, 2. 언제 끝날지 모름 3. API Limit (1초에 5번 오면 Block)
//        for item in tvList {
//            TMDBAPIManager.shared.callRequest(query: item.1) { stillPath in
//                print(stillPath)
//            }
//        }
        
        
        var posterList: [[String]] = []
        
        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)
                   
                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)
                     
                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)
                           
                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
