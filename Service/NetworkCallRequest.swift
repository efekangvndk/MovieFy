//
//  NetworkCallRequest.swift
//  MovieFy
//
//  Created by Efekan Güvendik on 25.09.2024.
//

import Foundation

class NetworkCallRequest: ObservableObject {
    
    ///ObservableObject: Bu da bir protocol'dür ve amacı class içerisinde olan veri değişikliği olduğunda bunu dışarıya bildirebileceği anlamına gelir.
    
    let networkService : NetworkCallProtocol
    
    init(networkService: NetworkCallProtocol = UrlSessionApiService()){
        self.networkService = networkService
    }
    ///Bu bir initilaizerdır yani başlatıcı diyebiliriz NetworkCallRequest sınıfı sınıfından bir nesne oluşturduğunuzda, bu kod çalışır. bu init networkService NetworkCallProtocol türünden bir değer alır ancak NetworkCallProtocol bir değer dönmesse
    ///default olarak UrlSessionApiService değerden bir değer alır. bu da bize bağımlılık seviyesini minmuma çekmek için yardım eder.
    
    func leadGetData(completion: @escaping ([Result]) -> Void) {
        guard let url = URL(string: MovieServiceApiConstant.movieURL) else {
            print("Invalid URL")
            return
        }
        
        networkService.fetchData(from: url) { (result: NetworkResult<MovieResponseData>) in
            switch result {
            case .success(let response):
                completion(response.results) // Movie listesi döndürülüyor
            case .failure(let error):
                print("Error fetching data: \(error)")
                completion([]) // Hata durumunda boş dizi döndür
            }
        }
    }

}
