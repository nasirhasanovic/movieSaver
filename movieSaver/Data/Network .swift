//  Network.swift
//  FetchHomeTest
//
//  Created by NasirHasanovic on 10. 12. 2021..
//

import Foundation

enum Method {
    case get
    case post
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

enum API {
    case getCategories
    case searchMovie(String)
    case fetchMovie(Int)
    
    
    
    private var apiUrl: String{
        let apiKey = "5e93e2eec20cf31971792d733ac51406"
        switch self {
        case .getCategories:
            return "categories.php"
        case .searchMovie(let name):
            return "search/movie?api_key=\(apiKey)&query=\(name)&include_adult=false"
        case .fetchMovie(let movieID):
            return "movie/\(movieID)?api_key=\(apiKey)"
        }
    }
    //https://api.themoviedb.org/3/movie/268?api_key=5e93e2eec20cf31971792d733ac51406&language=en-US
    //search/movie?api_key=5e93e2eec20cf31971792d733ac51406&query=batman
    
    var baseURL: URL? {
        let serverURL = "https://api.themoviedb.org/3/"
        return URL(string: serverURL + self.apiUrl )
        print(serverURL + self.apiUrl)
    }
}


extension URLSession {
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }
    
    func request<T: Codable>(
        api: API,
        expecting: T.Type,
        parameters: [String: Any]?,
        method: Method,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = api.baseURL else {
            completionHandler(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        var jsonData: Data? = nil
        if let params = parameters {
            jsonData = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = jsonData
        }
        
        request.httpMethod = method.name
        
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let task = dataTask(with: request) { data, resp, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(CustomError.invalidData))
                    }
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(result))
                }
            }
            catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

