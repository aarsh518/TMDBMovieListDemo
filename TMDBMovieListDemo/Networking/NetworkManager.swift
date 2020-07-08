
//
//  NetworkManager.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 08/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import Foundation

class NetworkManager {
    
    enum NetworkResult<T> {
        case success(T)
        case failure(String?)
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum BodyType {
        case formEncoded, queryParameters
    }
    
    static func fetchApiData<T: NetworkRequestable>(withRequest request: T, completionHandler: @escaping (NetworkResult<T.ResultType>) -> Void) {
        guard let baseURL = request.baseUrl else { completionHandler(NetworkResult.failure("Could not compose network request"))
            return
        }
        let url = baseURL.appendingPathComponent(request.endpoint)
        let urlRequest = prepareRequest(for: url, req: request)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                
                if let urlError = error as? URLError, urlError.code == URLError.cancelled {
                    completionHandler(NetworkResult.failure(urlError.localizedDescription))
                } else {
                    completionHandler(NetworkResult.failure(err.localizedDescription))
                }
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                DispatchQueue.main.async {
                    do {
                        let object = try decoder.decode(T.ResultType.self, from: data)
                        completionHandler(NetworkResult.success(object))
                    } catch let error {
                        completionHandler(NetworkResult.failure(error.localizedDescription))
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    private static func prepareRequest<T: NetworkRequestable>(for url: URL, req: T) -> URLRequest {
        
        var request : URLRequest? = nil
        
        switch req.query {
        case .formEncoded:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy,
                                 timeoutInterval: req.timeout)
            if let params = req.parameters {
                do {
                    let body = try JSONSerialization.data(withJSONObject: params, options: [])
                    request!.httpBody = body
                } catch {
                    assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
                }
            }
        case .queryParameters:
            var query = ""
            
            req.parameters?.forEach { key, value in
                query = query + "\(key)=\(value)&"
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.query = query
            request = URLRequest(url: components.url!, cachePolicy: req.cachePolicy, timeoutInterval: req.timeout)
        }
        
        request!.allHTTPHeaderFields = req.headers
        request!.httpMethod = req.method.rawValue
        
        return request!
    }
}
