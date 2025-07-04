import SwiftUI
import ContentLauncher

@main
struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor
    var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    var window: UIWindow?
    var launcherWindow: UIWindow? = nil
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let windowScene = scene as! UIWindowScene
        window = UIWindow(windowScene: windowScene)
        launcherWindow = LauncherHostingWindow(
            windowScene: windowScene,
            content: LauncherContentView()
        )
    }
}
