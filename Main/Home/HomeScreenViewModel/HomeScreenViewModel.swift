//
//  HomeScreenViewModel.swift
//  MovieFy
//
//  Created by Efekan Güvendik on 25.09.2024.
//

import SwiftUI

class HomeScreenViewModel: ObservableObject {
    
    private let networkService: NetworkCallRequest
    
    init(networkService: NetworkCallRequest) {
        self.networkService = networkService
    }
    
    @Published var movies: [Result] = []

    func getData() {
        networkService.leadGetData { movieList in
            print("Fetched movies: \(movieList.count)")
            
            DispatchQueue.main.async {
                self.movies = movieList
            }
        }
    }
    func getPoster(for movie: Result)-> URL?{
        let posterUrl = MovieServiceApiConstant.posterImage
        return URL(string: posterUrl + movie.posterPath)
    }
}
