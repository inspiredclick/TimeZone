//
//  TimeZoneAPI.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 InspiredClick. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

struct TimeZoneAPI {
    static let baseUrl: String = "http://api.geonames.org/"
}

extension TimeZoneAPI {
    static let path = "searchJSON"
    
    struct SearchRequest {
        
        enum Style: String {
            case short = "SHORT"
            case medium = "MEDIUM"
            case long = "LONG"
            case full = "FULL"
        }
        
        enum FeatureCode: String {
            case ppl = "PPL"
            case pplc = "PPLC"
        }
        
        enum Params: String {
            case q
            case style
            case maxRows
            case username
            case featureCode
            case orderby
        }
        
        let requestUrl: URL?
        
        init(queryString: String,
             style: Style = .short,
             maxRows: Int = 8,
             apiKey: String = Keys.geoNamesApiKey,
             featureCodes: [FeatureCode] = [.ppl, .pplc],
             orderBy: String = "relevance") {
            
            var urlComponents = URLComponents(string: baseUrl+path)
            
            var queryItems = [
                URLQueryItem(name: Params.q.rawValue, value: queryString),
                URLQueryItem(name: Params.style.rawValue, value: style.rawValue),
                URLQueryItem(name: Params.maxRows.rawValue, value: "\(maxRows)"),
                URLQueryItem(name: Params.username.rawValue, value: apiKey),
                URLQueryItem(name: Params.orderby.rawValue, value: orderBy)
            ]
            
            for featureCode in featureCodes {
                queryItems.append(URLQueryItem(name: Params.featureCode.rawValue, value: featureCode.rawValue))
            }
            
            urlComponents?.queryItems = queryItems
            
            self.requestUrl = urlComponents?.url
        }
        
        func get() -> Promise<Any> {
            return Promise { promise in
                guard let requestUrl = self.requestUrl else {
                    promise.reject(SearchRequestError(code: -100, errorText: "Request url not set"))
                    return
                }

                Alamofire.request(requestUrl).responseJSON { (response) in
                    if let error = response.error {
                        promise.reject(
                            SearchRequestError(code: response.response?.statusCode ?? -200,
                                               errorText: error.localizedDescription)
                        )
                        return
                    }
                    
                    guard let data = response.data else {
                        promise.reject(SearchRequestError(code: -300, errorText: "No data returned"))
                        return
                    }
                    
                    do {
                        let jsonData = try JSON(data: data)
                        promise.fulfill(
                            SearchRequestResponse(response: response,
                                                  data: jsonData)
                        )
                    }
                    catch let error {
                        promise.reject(SearchRequestError(code: -400, errorText: error.localizedDescription))
                    }
                }
            }
        }
    }
}

extension TimeZoneAPI {
    struct SearchRequestResponse {
        var response: Any?
        var data: JSON?
    }
}

extension TimeZoneAPI {
    struct SearchRequestError: Error {
        var code: Int
        var errorText: String
    }
}
