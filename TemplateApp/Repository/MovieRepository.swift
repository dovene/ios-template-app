//
//  MovieRepository.swift
//  TemplateApp
//
//  Created by Dov on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import Moya
import SwiftyBeaver

protocol Networkable {
    var provider: MoyaProvider<MovieApi> {get}
    func getMovies(completion: @escaping([Movie]?, ErrorModel?)->())
}

struct MovieRepository: Networkable {
    var provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose:true)])
    func getMovies(completion: @escaping ([Movie]?, ErrorModel?) -> ()) {
        provider.request(.trending) {result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: response.data)
                    completion(results.results, nil)
                } catch let err {
                    print("err \(err)")
                    completion(nil, ErrorModel())
                }
              print("network success \(response)")
            case let .failure(error):
                print("network error \(error)")
                completion(nil, ErrorModel())
            }
        }
    }
}
