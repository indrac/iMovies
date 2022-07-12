//
//  Utility.swift
//  KitaMovies
//
//  Created by Indra Cahyadi on 08/07/20.
//  Copyright © 2020 Indra Cahyadi. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension UIViewController {
    
    func dateFormat(get: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterGet.date(from: get) {
            print(dateFormatterPrint.string(from: date))
            return dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
            return ""
        }
    }
    
}


extension NSManagedObjectContext {
    
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
