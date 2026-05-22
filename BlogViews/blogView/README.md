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


## service with async await

<details><summary>Show Detail</summary>

```swift
class Services{
    static var shared = Services()
    init() {}
    
    private let my_token = Secrets.blogAPIKey
    private let url_api = "https://realworld.habsida.net/api/articles"
    
    private var cancellables = Set<AnyCancellable>()
    
    func getBlogViews() async throws -> [BlogViewsModel]{
        guard let url = URL(string: url_api) else{
            throw URLError(.badURL)
        }
        
        // បង្កើត URLRequest ជំនួស URL ធម្មតា
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // បន្ថែម Token នៅ Header
        request.setValue("Bearer \(my_token)", forHTTPHeaderField: "Authorization")
        
        // ប្រើ request ជំនួស url
        let (data, responce) = try await URLSession.shared.data(for: request)
        
        guard let htpResponce = responce as? HTTPURLResponse,
              (200..<300).contains(htpResponce.statusCode) else{
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
//        let decode = try JSONDecoder().decode(BlogResponse.self, from: data)
        let decode = try decoder.decode(BlogResponse.self, from: data)
        return decode.articles
    }
}
```
</detail>

## Data realtime with api fetch

### Auto Refresh 
<details><summary>Show code auto refresh </summary>

```swift
// property
    @State private var cancellables = Set<AnyCancellable>()
```


```swift
// at view
    .navigationTitle("Blog view list")
    .onAppear{
        Task{await vm.getArtiles()}
        
        Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                Task{ await vm.getArtiles()}
            }
            .store(in: &cancellables)
    }
    .onDisappear{
        cancellables.removeAll()
    }
    
}// - Navigation
```
</details>

### Pull-to-refresh
នេះ data មិន auto update View ទេ

<details><summary>Show code Pull to refresh </summary>

```swift
    .refreshable {
        await vm.getArtiles()
    }
    .task {
        await vm.getArtiles()
    }
```
</details>



