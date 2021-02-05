//  
//  QuizAPIWorker.swift
//  QuizZap
//
//  Created by Tales Conrado on 02/02/21.
//

import Foundation

struct APIResponse: Codable {
    let responseCode: Int
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case questions = "results"
    }
}

class QuizAPIWorker {
    
    let apiURL = "https://opentdb.com/api.php"
    
    func fetchQuestions(quantity: Int, completionHandler: @escaping ([Question]) -> Void) {
        
        guard let builtURL = buildQuestionsQuery(quantity: quantity) else { return }
        
        let task = URLSession.shared.dataTask(with: builtURL, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching questions: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            if let data = data,
             let filmSummary = try? JSONDecoder().decode(APIResponse.self, from: data) {
                completionHandler(filmSummary.questions)
            }
        })
        task.resume()
    }
    
    private func buildQuestionsQuery(quantity: Int) -> URL? {
        var url = URLComponents(string: apiURL)!
        url.queryItems = [ URLQueryItem(name: "amount",
                                        value: String(quantity)),
                           URLQueryItem(name: "difficulty",
                                        value: "easy")
        ]
        
        guard let builtURL = url.url else { return nil }
        
        return builtURL
    }
}
