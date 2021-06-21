//
//  ContentView.swift
//  MVVM
//
//  Created by Roel Spruit on 16/06/2021.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var listItems: [ColorModel] = []
    
    private let colorService: ColorServiceProtocol
    
    init(colorService: ColorServiceProtocol = ColorService()) {
        self.colorService = colorService
    }
    
    // MARK: - Events
    
    func onAppear() async {
        await refresh()
    }
    
    func onRefresh() async {
        await refresh()
    }
    
    // MARK: - Private
    
    private func refresh() async {
        do {
            listItems = try await colorService.getContent()
        } catch {
            listItems = []
        }
    }
}

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel
    @Environment(\.refresh) private var refresh
    
    var body: some View {
        List {
            ForEach(viewModel.listItems, id: \.id) { item in
                HStack(spacing: 20) {
                    Circle()
                        .foregroundColor(item.color)
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 20)
                        
                    Text(item.title.capitalized)
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle("MVVM")
        .task(viewModel.onAppear)
        .refreshable(action: viewModel.onRefresh)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
