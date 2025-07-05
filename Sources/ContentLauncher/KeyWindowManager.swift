import UIKit

@MainActor
final class KeyWindowManager {
    private weak var previousKeyWindow: UIWindow?
    
    func storePreviousKeyWindow(excluding currentWindow: UIWindow) {
        previousKeyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow && $0 !== currentWindow }
    }
    
    func restorePreviousKeyWindow() {
        previousKeyWindow?.makeKey()
    }
}
