//
//  CoreDataManager.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 08/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    func create(_ title:String,
                _ overview:String,
                _ poster:String,
                _ releasedate: String,
                completion: @escaping (Result<String, Error>) -> ()){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "MovieDatabase", in: managedContext)
        
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(title, forKey: "title")
        insert.setValue(overview, forKey: "overview")
        insert.setValue(releasedate, forKey: "releasedate")
        insert.setValue(poster, forKey: "poster")
        
        do {
            try managedContext.save()
            completion(.success("Success"))
        } catch let err {
            print (err)
            completion(.failure(err))
        }
        
    }
    
    func retrieve() -> [Movies] {
        var movieList = [Movies]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDatabase")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach{ movie in
                movieList.append(
                    Movies(title: movie.value(forKey: "title") as! String,
                           overview: movie.value(forKey: "overview") as! String,
                           release_date: movie.value(forKey: "releasedate") as! String,
                           poster_path: movie.value(forKey: "poster") as! String)
                )
            }
        }catch let err{
            print(err)
        }
        return movieList
    }
    
    func search(title: String, completion: @escaping (Result<String, Error>) -> ())  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDatabase")
        
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            guard let objects = results, objects.count > 0 else {
                completion(.success("Not Exist"))
                return
            }
            completion(.success("Exist"))
//            print("Found Title : \(objects[0].value(forKey: "title") ?? "")")
//            print("Found Overview : \(objects[0].value(forKey: "overview") ?? "")")
//            print("Found Poster : \(objects[0].value(forKey: "poster") ?? "")")
        }catch let err{
            completion(.failure(err))
        }
    }
    
    func delete(_ title:String, completion: @escaping (Result<String, Error>) -> ()){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MovieDatabase")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do{
            let dataToDelete = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            guard let objects = dataToDelete, objects.count > 0 else { return }
            for object in objects {
                managedContext.delete(object)
            }
            try managedContext.save()
            completion(.success("Deleted"))
        }catch let err{
            completion(.failure(err))
        }
        
    }
    
}
