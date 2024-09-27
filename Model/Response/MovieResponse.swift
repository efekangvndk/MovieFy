//
//  MovieResponse.swift
//  MovieFy
//
//  Created by Efekan Güvendik on 25.09.2024.
//

import Foundation


//MARK: GeneralResponse

struct MovieResponse: Codable, Hashable{
    let movieList : [MovieResponseData]
}
// MARK: - PlatformResponse
struct MovieResponseData: Codable , Hashable{
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
///Codable: Bu birim yapının JSON verilerine dönüştürülebilir olduğunu söyler.  Yani, JSON'dan bu yapıya veya bu yapıdan JSON'a dönüştürülebilir.
///CodingKeys: CodingKeys yapısını kullanarak JSON'daki anahtar isimlerini Swift kodundaki daha anlamlı ve uyumlu isimlerle eşleştiririz.

// MARK: - Result
struct Result: Codable ,Hashable{
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
///CodingKeys: CodingKeys yapısını kullanarak JSON'daki anahtar isimlerini Swift kodundaki daha anlamlı ve uyumlu isimlerle eşleştiririz.

enum OriginalLanguage: String, Codable {
    case cn = "cn"
    case en = "en"
    case ko = "ko"
    case pt = "pt"
}
