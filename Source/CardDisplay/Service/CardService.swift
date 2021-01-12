//
//  CardService.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//
import Foundation

class CardService {
    static var instance = CardService()
    let endpoint = "https://ringtones-kodi.s3.amazonaws.com/data/top_ringtones.json"
    
    static func shareInstance() -> CardService {
        return instance
    }
    
    func getCardData(completion: @escaping(Bool) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(false)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let cards = try decoder.decode(FailableCodableArray<Card>.self, from: data!)
                SharedVariable.shareInstance().cardArray = cards.elements
                completion(true)
            } catch {
            }
        }
        task.resume()

    }
}
