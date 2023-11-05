//
//  DataSource.swift
//  plusMinusOne-Case-Study
//
//  Created by MUSTACIC on 2.11.2023.
//

import Foundation

final class MockService {
    static let shared = MockService()
    func fetchProduct(completion: @escaping (Result<Product, Error>) -> Void) {
           DispatchQueue.global().asyncAfter(deadline: .now() + Double.random(in: 1.0...2.5)) {
               let randomValue = Int.random(in: 0...10)
               
               if randomValue < 0 {
                   completion(.failure(MockServiceError.serviceUnavailable))
               } else {
                   if let product = self.jsonFileDecoder(JsonFileNames.product.rawValue, decoderModel: Product.self) {
                       completion(.success(product))
                   } else {
                       completion(.failure(MockServiceError.jsonConverterError))
                   }
               }
           }
    }
    
    func fetchSocial(completion: @escaping (Result<Social, Error>) -> Void) {
           DispatchQueue.global().asyncAfter(deadline: .now() + Double.random(in: 1.0...2.5)) {
               let randomValue = Int.random(in: 0...10)
               
               if randomValue < 3 {
                   completion(.failure(MockServiceError.serviceUnavailable))
               } else {
                   if let social = self.jsonFileDecoder(JsonFileNames.social.rawValue, decoderModel: Social.self) {
                       completion(.success(social))
                   } else {
                       completion(.failure(MockServiceError.jsonConverterError))
                   }
               }
           }
    }
}

// MARK: Json Decoder.
private extension MockService {
    func jsonFileDecoder<T: Codable>(_ jsonFileName: String, decoderModel: T.Type) -> T? {
        guard let sourceURL = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
            print("Json file decoder bundle error")
            return nil
        }
        guard let data = try? Data(contentsOf: sourceURL) else { print("data cast error"); return nil }
        
        let decoder = JSONDecoder()
        guard let decodedModel = try? decoder.decode(T.self, from: data) else {
            print("Decoding problem."); return nil }
        
        return decodedModel
    }
}

enum JsonFileNames: String {
    case product
    case social
}
