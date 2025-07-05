import SwiftUI
import UIKit

@MainActor
public struct LauncherHostingWindowConfiguration {
    public var launcherButtonConfiguration: UIButton.Configuration = .launcher()
    
    #if os(iOS)
    public var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier = .medium
    #endif
    
    public init() {}
}

public final class LauncherHostingWindow<Content: View>: UIWindow {
    private let keyWindowManager = KeyWindowManager()
    
    public init(
        windowScene: UIWindowScene,
        content: Content,
        configuration: LauncherHostingWindowConfiguration = LauncherHostingWindowConfiguration()
    ) {
        super.init(windowScene: windowScene)
        rootViewController = LauncherHostViewController(
            content: content,
            configuration: configuration,
            onDismiss: { [weak self] in
                self?.keyWindowManager.restorePreviousKeyWindow()
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
        keyWindowManager.storePreviousKeyWindow(excluding: self)
        super.makeKey()
    }
}
