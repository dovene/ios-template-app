//
//  MovieApi.swift
//  TemplateApp
//
//  Created by Dov on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case trending
}

extension MovieApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/")!
    }
    
    var path: String {
        switch self {
        case .trending: return "3/trending/all/day"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .trending: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .trending: return stubbedResponse("Trendings")
        }
    }
    
    var task: Task {
        switch self {
        case .trending:
                return .requestParameters(parameters: ["api_key":"0675d2721647d913c9b1329c8823a3cb"], encoding: URLEncoding.queryString)
       /* default:
            if let parameters = parameters {
                if let params = parameters as? Encodable {
                    return .requestJSONEncodable(params)
                } else if let params = parameters as? [String: Any] {
                    return .requestParameters(parameters: params,
                                              encoding: URLEncoding.default)
                }
            }
            return .requestPlain*/
        }
    }
    
    var parameters: Any? {
        switch self {
        default: return nil
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    // MARK: - Provider support
    
    private func stubbedResponse(_ filename: String) -> Data! {
        // swiftlint:disable nesting
        @objc class TestClass: NSObject {}
        // swiftlint:enable nesting
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        
        //        logger.verbose("Stub file used: \(String(describing: path))")
        
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}

