//
//  NetworkProvider.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import RxSwift
import Foundation

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}

class NetworkProvider: NetworkProtocol {
    func get(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .get, urlString: url, bodyParams: bodyParams, header: header)
    }
    
    func post(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .post, urlString: url, bodyParams: bodyParams, header: header)
    }
    
    func put(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .put, urlString: url, bodyParams: bodyParams, header: header)
    }
    
    func delete(url: String, bodyParams: [String: Any], header: [String: String]) -> Observable<Data> {
        return requestMethod(method: .delete, urlString: url, bodyParams: bodyParams, header: header)
    }
    
    private func requestMethod(method: HTTPMethod,
                               urlString: String,
                               bodyParams: [String: Any],
                               header: [String: String]) -> Observable<Data> {
        return Observable<Data>.create { [weak self] observer in
            if Connectivity.isConnectedToInternet == false {
                observer.on(.error(ResponseErrorModel(title: "Error", detail: "No Internet Connection", errorImageUrl: "", status: 0, code: "")))            } else {
                guard let _ = self,
                      let url = URL(string: urlString) else {
                    return Disposables.create {}
                }
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                header.forEach { (key, value) in
                    urlRequest.setValue(key, forHTTPHeaderField: value)
                }
                
                if !bodyParams.isEmpty,
                   let bodyData = try? JSONSerialization.data(withJSONObject: bodyParams, options: []) {
                    print("BODY: \(bodyParams))")
                    urlRequest.httpBody = bodyData
                }
                
                let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let error = error {
                        observer.on(.error(error))
                    } else if let data = data {
                        print("HEADER: \(String(describing: urlRequest.allHTTPHeaderFields))")
                        
                        print("URL: \(urlString)")
                        
                        if let debugPrint = String(data: data, encoding: .utf8) {
                            print("RESPONSE: \(debugPrint)")
                        }
                        
                        let responseError = try? JSONDecoder().decode(ResponseErrorArrayModel.self, from: data)
                        let httpResponse = response as? HTTPURLResponse
                        let statusCode = httpResponse?.statusCode
                        print("Status Code: \(statusCode ?? 0)")
                        
                        if statusCode == 200 {
                            observer.on(.next(data))
                        } else {
                            if let singleError = responseError {
                                let error = ResponseErrorModel(detail: singleError.statusMessage, status: NSNumber(value: httpResponse?.statusCode ?? 0))
                                observer.on(.error(error))
                            }
                            observer.on(.error(ResponseErrorModel(title: "", detail: "", errorImageUrl: "", status: 0, code: "")))
                        }
                    }
                }
                
                task.resume()
                
                return Disposables.create {
                    task.cancel()
                }
            }
            return Disposables.create()
        }
        
    }
}

