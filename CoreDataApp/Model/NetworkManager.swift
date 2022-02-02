//
//  NetworkManager.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 31/01/2022.
//

import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getQuote(completion: @escaping(Kanye) -> (Void)) {
        let url = URL(string: "https://api.kanye.rest/")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("Error 1")
                return
            }
            
            guard response != nil else {
                print("Error 2")

                return
            }
            guard let data = data else {
                print("Error 3")
                return
            }
            
            do {
                let kanye = try JSONDecoder().decode(Kanye.self, from: data)
                completion(kanye)
            }catch {
                print("Error catch")
                
            }

            
        }
        dataTask.resume()
        
        
    }
    
    
    
    
}
