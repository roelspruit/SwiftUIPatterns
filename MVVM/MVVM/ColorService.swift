//
//  ColorService.swift
//  MVVM
//
//  Created by Roel Spruit on 16/06/2021.
//

import SwiftUI

protocol ColorServiceProtocol {
    func getContent() async throws -> [ColorModel]
}

final class ColorService: ColorServiceProtocol {
    
    private let network: NetworkProtocol

    internal init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    @MainActor
    func getContent() async throws -> [ColorModel] {
        guard let url = URL(string: "https://www.colourlovers.com/api/colors&format=json") else {
            return []
        }
        return try await network.decode([ColorModel].self, from: url)
    }
}

struct ColorModel: Decodable {
    let id: Int
    let title: String
    let rgb: RGBModel
    
    struct RGBModel: Decodable {
        let red: Double
        let green: Double
        let blue: Double
    }
}

extension ColorModel {
    var color: Color {
        Color(red: rgb.red/255, green: rgb.green/255, blue: rgb.blue/255, opacity: 1)
    }
}
