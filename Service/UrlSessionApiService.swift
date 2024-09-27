//
//  NetworkCallProtocol.swift
//  MovieFy
//
//  Created by Efekan Güvendik on 25.09.2024.
//

import Foundation

// Yeni Result enum
enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}
///Bu enum yapısı ile kod  başarılı kodu T şeklinde Succes içinde yer aldırıyoruz eğer başarısız olursa da Erro şeklinde failure altına işleme alıyoruz bu şekilde daha okunaklı bir kod ortaya koymuş olduk.

protocol NetworkCallProtocol {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (NetworkResult<T>) -> Void)
}
///Belirli bir işlevsellik katmak için protocol kullanıyoruz. Burda bir class'a işlev kattık yani get isteği atmak için bu şekilde class'a bir görev atadık.
///ve bu işlem tamamlandığında bir closur olan tamamlama completion'ı çağırılacak.
//////<T>: Bu kısım, fonksiyonumuzun generic olduğunu belirtir. Generic, bir fonksiyon veya türün, belirli bir tür ile değil, farklı türlerle çalışabilmesine olanak tanır.
///T başarılı bir sonuç durumunu, Error ise bir hata durumunu temsil eder. Yani, ağdan veri çekme işlemi başarılı olursa T türünde veri dönecek.
///URLResponse:  İstemci, sunucudan gelen yanıtı alır.

class UrlSessionApiService: NetworkCallProtocol {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (NetworkResult<T>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(MovieServiceApiConstant.bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            ///domain: Hatanın hangi alan veya kategori ile ilgili olduğunu belirtmek için kullanılır. Genellikle, bu alanı belirlemek için bir dize (string) kullanılır. Duruma göre boş bıraklılabilir bu hatanın
            ///katagorisine göre yazılır biz ise şimdilik networkError verdik zaten amacımız network'e get isteği atmak eğer olmassa networkError denebilir.
            ///Code ise hata'nın kimliğdir genel tabi ile 200 dönerse Succses 400 veya 404 dönerse Hata.
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
///URLSession.shared.dataTask(with: url, completionHandler: completion): Bu kısım, URLSession adlı yerleşik bir nesneyi kullanarak belirtilen URL'den veri almak için bir görev (task) başlatır.
///shared: Bu birim singleton yapıyı temsil eder ve tekil bir örnek olarak uygulamanın her yerinden erişim sağlanan bir nesne yaratır.
///.resume(): Görevi başlatır. Bu aşamadan önce görev, hazırlanmış ama çalışmaya başlamamıştır. .resume() ile başlatılır.
