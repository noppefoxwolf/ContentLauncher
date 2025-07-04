import SwiftUI
import UIKit

public final class LauncherHostingWindow<Content: View>: UIWindow {
    private weak var previousKeyWindow: UIWindow?
    
    public init(
        windowScene: UIWindowScene,
        content: Content,
        launcherButtonConfiguration: UIButton.Configuration = .launcher()
    ) {
        super.init(windowScene: windowScene)
        rootViewController = LauncherHostViewController(
            content: content,
            buttonConfiguration: launcherButtonConfiguration,
            onDismiss: { [weak self] in
                self?.restorePreviousKeyWindow()
            }
        )
        isHidden = false // visibleWithoutMakeKey
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isModelPresented: Bool {
        rootViewController?.presentedViewController != nil
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isModelPresented {
            return super.hitTest(point, with: event)
        } else {
            let hitTestResult = super.hitTest(point, with: event)
            if hitTestResult is UIButton {
                return hitTestResult
            } else {
                return nil
            }
        }
    }
    
    public override func makeKey() {
        // Store the previous key window before becoming key
        previousKeyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow && $0 !== self }
        
        super.makeKey()
    }
    
    private func restorePreviousKeyWindow() {
        previousKeyWindow?.makeKey()
    }
}
