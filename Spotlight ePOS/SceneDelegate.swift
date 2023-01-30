//
//  SceneDelegate.swift
//  Spotlight ePOS
//
//  Created by Lu on 17/1/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var payload = "ewogICJvcmRlcklkIjogIjQ2N2VlY2M2LWUzYWMtNGRjNy05NDE4LWUwMzhkMzQ5MWY3OSIsCiAgImFtb3VudCI6IDEwMCwKICAic3RvcmVJZCI6ICI0MDAxIiwKICAia2V5IjogIlZlcnlTZWNyZXQiLAogICJjdXJyZW5jeSI6ICJBRUQiCn0="
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        print("SceneDelegate ....")
        // Determine who sent the URL.
        if let urlContext = connectionOptions.urlContexts.first {
            
            let sendingAppID = urlContext.options.sourceApplication
            let url = urlContext.url
            print("source application = \(sendingAppID ?? "Unknown")")
            print("url = \(url)")
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("openURLContexts")
        
        if let url = URLContexts.first?.url{
            
            print("openURLContexts: \(url.absoluteString)")
            guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                  let _ = components.path,
                  let _ = components.queryItems else {
                print("Invalid URL or album path missing")
                return
            }
            
            payload = url.valueOf("payload") ?? ""
            openIntroController(payload)
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func openIntroController(_ payload: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController: UIViewController
        
        let introVC = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
        introVC.payload = payload
        initialViewController = introVC
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    
}

