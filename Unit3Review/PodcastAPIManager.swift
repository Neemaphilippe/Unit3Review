//
//  PodcastAPIManager.swift
//  Unit3Review
//
//  Created by Pursuit on 9/18/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import Foundation

class PodcastAPIManager{
    private init(){}
    
    static let shared = PodcastAPIManager()
    
    func getPodcasts(searchWord: String, completionHandler: @escaping (Result<[Podcast], AppError>) -> Void) {
        
        let urlStr = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchWord)"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get){(result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let podcastInfo = try JSONDecoder().decode(PodcastInfo.self, from: data)
                    completionHandler(.success(podcastInfo.results))
                }catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
            
            
        }
        
        
        
        
    }
        
    
    
    
    func postPodcast(podcast: FavoritePodcast, completionHandler: @escaping (Result<Data, AppError>) -> Void){
        guard let encodedData = try? JSONEncoder().encode(podcast) else {
            fatalError("encoder failed")
        }
        let urlStr = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andHTTPBody: encodedData, andMethod: .post) {(result) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    

}
