//
//  AppDelegate.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 10.11.23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let firstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")

        if !firstLaunch {
            UserDefaults.standard.set(true, forKey: "FirstLaunch")

            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            let settings = AppSettings(context: context)
            settings.backgroundActive = false
            settings.backgroundColor = "systemGray6"
            settings.checkAnswear = false
            settings.letterSize = 15
            settings.timeGame = 120
            settings.wordChangeSpeed = 1
            try? context.save()
        }
        return true
    }

        // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameStorage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

        // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

