import Foundation
import Combine
import Alamofire

protocol ServiceProtocol {
    func response<Request>(from request: Request) -> AnyPublisher<DataResponse<Request.Response, NetworkError>, Never> where Request: APIRequestType
}


class APIService {
    static let shared: ServiceProtocol = APIService()
    
    private var baseURL: URL?
    private var baseString: String
    
    init() {
        self.baseString = "https://api.weatherapi.com/"
        self.baseURL = URL(string: baseString)
    }
}

extension APIService: ServiceProtocol {
    
    func response<Request>(from request: Request) -> AnyPublisher<DataResponse<Request.Response, NetworkError>, Never> where Request: APIRequestType{
        
        if let pathURL = URL(string: request.path, relativeTo: self.baseURL),
           let urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true),
           let url: URL = urlComponents.url {

            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            
            let urlStr = url.absoluteString

            return AF.request(urlStr, method: request.method, parameters: request.params)
                .publishDecodable(type: Request.Response.self, decoder: decorder)
                .map { response in
                    response.mapError { error in
                        let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                        return NetworkError(initialError: error, backendError: backendError)
                    }
                }
                
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
       
        return Empty().eraseToAnyPublisher()
    }
}

