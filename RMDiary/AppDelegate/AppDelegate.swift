//
//  AppDelegate.swift
//  RMDiary
//
//  Created by Renat Murtazin on 03.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let dataService: IDataService = DataService()
    let viewController = NoteListModuleBuilder(dataService: dataService).build()
    let navigationController = UINavigationController(rootViewController: viewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }
}
