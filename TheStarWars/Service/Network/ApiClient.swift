//
//  StarWarsAPI.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/3/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    
    private let baseUrl = "https://swapi.co/api/"
    
    private init() {}
    
    static let shared = ApiClient()
    
    typealias Completion = (_ response: Any?, _ error: Error?) -> ()
    
    private func request( _ url: URLConvertible,
                  method: HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  completion: @escaping Completion) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding)
            .responseJSON { (response) in
                if 200...299 ~= response.response?.statusCode ?? 0 {
                    completion(response.result.value, nil)
                } else {
                    completion(nil, response.error)
                }
        }
    }
    
    func search(person: String, page: Int = 0, complition: @escaping Completion) {
        let url = baseUrl + "people/"
        let parameters = ["search": person]
        self.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, completion: complition)
    }
    
    func open(url: String, complition: @escaping Completion) {
        self.request(url, method: .get, encoding: URLEncoding.default, completion: complition)
    }    
}

