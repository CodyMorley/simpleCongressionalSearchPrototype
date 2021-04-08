//
//  NetworkingController.swift
//  RePublicSimple
//
//  Created by Cody Morley on 4/1/21.
//

import Foundation

class NetworkingController {
    var members: [Member] {
        senators + representatives
    }
    
    private var senators = [Senator]()
    private var representatives = [Representative]()
    private let baseURL = URL(string: "https://api.propublica.org/congress/v1")!
    private let apiKey = "So3Q00p6VavTMgoUviyfrq6OSrWpNfPhvDyzHhcw"
    
    func refresh() {
        getAll(for: .house)
        getAll(for: .senate)
    }
    
    private func getAll(for chamber: Chamber) {
        let requestURL = makeURL(for: chamber)
        let request = makeRequest(forURL: requestURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Something happened while fetching information from the \(chamber.rawValue) database. Here's what happened: \(error) :: \(error.localizedDescription)")
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                NSLog("Bad or no response from ProPublica API.")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from ProPublica API.")
                return
            }
            
            switch chamber {
            case .house:
                do {
                    let houseResult = try JSONDecoder().decode([Representative].self, from: data)
                    self.representatives = houseResult
                } catch {
                    NSLog("Error Decoding \(chamber.rawValue) data from API")
                    return
                }
            case .senate:
                do {
                    let senateResult = try JSONDecoder().decode([Senator].self, from: data)
                    self.senators = senateResult
                } catch {
                    NSLog("Error Decoding \(chamber.rawValue) data from API")
                    return
                }
            }
        }
    }

    
    private func makeRequest(forURL url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-Key")
        return request
    }
    
    private func makeURL(for chamber: Chamber) -> URL {
        let url = baseURL.appendingPathComponent("/117/\(chamber.rawValue)/members").appendingPathExtension("json")
        return url
    }
}
