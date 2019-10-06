//
//  MockNetwork.swift
//  NotificationDemoAppTests
//
//  Created by Margarita Blanc on 04/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import NotificationDemoApp
import Foundation

final class MockNetwork: NetworkType {
    
    var access: String? = nil
    
    var url1: URL?
    
    func authenticate(callback: @escaping ((String) -> Void)) {
        guard let accessToken = access else {return}
            callback(accessToken)
    }
    
    func requestTwitter<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        do {
            guard let dataURL = url1 else {return}
            let data = try Data(contentsOf: dataURL)
            
            let jsonDecoder = JSONDecoder()
            guard let decodedData = try? jsonDecoder.decode(type.self, from: data ) else { return }
            completion(.success(value: decodedData))
        }
        catch {
            print(error)
        }
    }
}
