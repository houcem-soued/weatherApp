import Foundation

public struct OpenWeatherClient {
    
    static private(set) var apiKey: String = ""

    public static func start(apiKey key: String) {
        apiKey = key
    }
    
    static public func getCityWeather(cityName city: String?, completion: @escaping (Result<CityWeather? , NSError >)->()) {

        let endPoint = OpenWeatherEndPoint(type: .fetchCityWeather(city))
        guard let url = endPoint.type.url else {
            completion(.failure(NSError(domain: "OpenWeatherClient", code: 530)))//invalidParameters
            return
        }
        let networkService = NetworkDataFetcher(session: URLSession.cityWeatherSession)
        networkService.performRequest(url: url) { (result) in
            switch result {
            case .success(let data):
                do{
                    let weatherResult = try JSONDecoder().decode(CityWeather.self, from: data)
                    completion(.success(weatherResult))
                } catch {
                    //ERROR: if json decoder fails
                    completion(.failure(NSError(domain: "OpenWeatherClient", code: 540)))//invalidResponse
                }
            case .failure(let error):
                //ERROR: if request fails
                completion(.failure(error))
                break
            }
        }
    }
}
