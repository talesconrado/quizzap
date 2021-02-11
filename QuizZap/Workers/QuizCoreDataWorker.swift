//
//  QuizCoreDataWorker.swift
//  QuizZap
//
//  Created by Tales Conrado on 05/02/21.
//

import UIKit
import CoreData

class QuizCoreDataWorker {
    
    var scores: [Score] = []
    
    var appDelegate: AppDelegate {
      UIApplication.shared.delegate as! AppDelegate
    }
    
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    
    func save(points: Int, total: Int) {
        let entity =
        NSEntityDescription.entity(forEntityName: "Score",
                                   in: managedContext)!
      
        let score = Score(entity: entity,
                         insertInto: managedContext)
        
        score.setValue(points, forKeyPath: "points")
        score.setValue(total, forKey: "total")

        do {
            try managedContext.save()
            scores.append(score)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func loadScores() {
        let fetchRequest =
          NSFetchRequest<Score>(entityName: "Score")
        
        //3
        do {
          scores = try managedContext.fetch(fetchRequest)
            if !scores.isEmpty {
                rankScores()
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func rankScores() {
        scores.sort { (first, second) -> Bool in
            let firstValue = Double( (Double(first.points) / Double(first.total)) * 100)
            let secondValue = Double( (Double(second.points) / Double(second.total)) * 100)
            
            return firstValue > secondValue
        }
        
        scores = scores.filter({ $0.points != 0 })
    }
}
