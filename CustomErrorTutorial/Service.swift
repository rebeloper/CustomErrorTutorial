//
//  Service.swift
//  CustomErrorTutorial
//
//  Created by Alex Nagy on 12/04/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import UIKit

struct FetchError {
    static let noData = CustomError(title: "Fetch Error", description: "The data downloaded is nil", code: 0)
    static let noImage = CustomError(title: "Fetch Error", description: "Could not create UIImage from data downloaded", code: 1)
}

struct Service {
    
    static func fetchImage(completion: @escaping (Result<UIImage, Error>) -> ()) {
        fetchDataFromServer { (data, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let data = data else {
                let err = FetchError.noData
                completion(.failure(err))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(FetchError.noImage))
            }
        }
    }
    
    fileprivate static func fetchDataFromServer(completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        DispatchQueueHelper.delay(bySeconds: 5) {
            let data = #imageLiteral(resourceName: "Dog.png").pngData()
            completion(nil, nil)
        }
    }
    
}
