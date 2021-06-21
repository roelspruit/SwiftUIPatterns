//
//  Network.swift
//  MVVM
//
//  Created by Roel Spruit on 17/06/2021.
//

import Foundation

protocol NetworkProtocol {
    func decode<T: Decodable>(_ type: T.Type, from url: URL) async throws  -> T
}

final class Network: NetworkProtocol {
    
    func decode<T: Decodable>(_ type: T.Type = T.self, from url: URL) async throws  -> T {
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.dataDecodingStrategy = .deferredToData
        decoder.dateDecodingStrategy = .deferredToDate

        return try decoder.decode(T.self, from: data)
    }
}
