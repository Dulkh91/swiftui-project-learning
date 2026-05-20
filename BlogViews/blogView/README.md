# Services
### Code បែប combine


```swift
// Services.swift
import Foundation
import Combine

struct BlogViewsModel: Codable {
    let title: String
    let description: String
    let body: String
    let createdAt: Date
}

struct BlogResponse: Codable {
    let articles: [BlogViewsModel]
}

class Services {
    static let shared = Services()
    private init() {}
    
    private let api_blogview = "https://realworld.habsida.net/api/articles"
    private let token = "Bearer eyJhbGciOiJIUzI1NiJ9..."
    
    func getBlogViews() -> AnyPublisher<[BlogViewsModel], Error> {
        guard let url = URL(string: api_blogview) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: BlogResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .eraseToAnyPublisher()
    }
}

```


# Image method
<details><summary>Show code </summary>

```swift
        
        if let imageUrl = author.image,
           let url = URL(string: imageUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80,height: 80)
                        .clipShape(Circle())
                case .failure(_):
                    Image(systemName: "person.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image(systemName: "person.slash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .foregroundColor(.gray)
        }
```
</details>

