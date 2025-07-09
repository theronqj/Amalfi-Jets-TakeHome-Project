//
//  AirportSearchViewModel.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import Foundation
import Combine

// MARK: - AirportSearchViewModel

/// A view model for handling airport searches.
class AirportSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var airports: [Airport] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var searchCancellable: AnyCancellable?
    private var debounceCancellable: AnyCancellable?

    init() {
        debounceCancellable = $query
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                self?.performSearch(query: value)
            }
    }

    private func performSearch(query: String) {
        guard !query.isEmpty else {
            self.airports = []
            self.errorMessage = nil
            self.isLoading = false
            return
        }
        self.isLoading = true
        self.errorMessage = nil

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "https://api.aviowiki.com/free/airports/search?query=\(encodedQuery)"
        guard let url = URL(string: urlStr) else {
            self.isLoading = false
            self.errorMessage = "Invalid URL."
            return
        }
        searchCancellable?.cancel()
        searchCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: AviowikiSearchResponse.self, decoder: JSONDecoder())
            .map { (response: AviowikiSearchResponse) -> [Airport] in
                response.content.compactMap { apiResult in
                    guard apiResult.icao != nil || apiResult.iata != nil else { return nil }
                    return Airport(
                        id: apiResult.id,
                        name: apiResult.name,
                        icao: apiResult.icao,
                        iata: apiResult.iata,
                        servedCity: apiResult.servedCity,
                        countryName: apiResult.country.name
                    )
                }
            }
            .tryCatch { error -> Just<[Airport]> in
                    if error is DecodingError {
                        return Just([])
                    } else {
                        return Just([])
                    }
                }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    if let urlError = error as? URLError {
                        self.errorMessage = "Network Error: \(urlError.localizedDescription)"
                    } else if error is DecodingError {
                        self.errorMessage = "Data Decoding Error: \(error.localizedDescription)"
                    } else {
                        self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
                    }
                }
            }, receiveValue: { [weak self] airports in
                guard let self else { return }
                self.airports = airports
            })
    }
}
