//
//  QuizCoreDataWorker.swift
//  QuizZap
//
//  Created by Tales Conrado on 05/02/21.
//

import UIKit
import CoreData

class QuizCoreDataWorker {
    
    var scores: [Score] = [] {
        didSet {
            rankScores()
        }
    }
    
    var appDelegate: AppDelegate {
      UIApplication.shared.delegate as! AppDelegate
    }
    
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    
    func save(points: Int ) {
        let entity =
        NSEntityDescription.entity(forEntityName: "Person",
                                   in: managedContext)!
      
        let score = Score(entity: entity,
                         insertInto: managedContext)

        score.setValue(points, forKeyPath: "points")

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
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func rankScores() {
        scores.sort(by: { $0.points > $1.points })
    }
}
