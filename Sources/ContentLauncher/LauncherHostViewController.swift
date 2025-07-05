import UIKit
import SwiftUI

final class LauncherHostViewController<Content: View>: UIViewController, UIAdaptivePresentationControllerDelegate {
    let button: UIButton
    let content: Content
    let configuration: LauncherHostingWindowConfiguration
    let onDismiss: (() -> Void)?
    
    init(
        content: Content,
        configuration: LauncherHostingWindowConfiguration,
        onDismiss: (() -> Void)? = nil
    ) {
        self.button = UIButton(configuration: configuration.launcherButtonConfiguration)
        self.content = content
        self.configuration = configuration
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(button)
        
        button.addAction(UIAction { [unowned self] _ in
            presentContent()
        }, for: .primaryActionTriggered)
        
        button.addInteraction(LauncherButtonInteraction())
    }
    
    func presentContent() {
        let vc = UIHostingController(rootView: content)
        #if os(iOS)
        vc.sheetPresentationController?.detents = [.medium(), .large()]
        vc.sheetPresentationController?.selectedDetentIdentifier = configuration.selectedDetentIdentifier
        vc.sheetPresentationController?.prefersGrabberVisible = true
        
        vc.sheetPresentationController?.prefersEdgeAttachedInCompactHeight = true
        vc.sheetPresentationController?.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        #endif
        
        present(vc, animated: true) { [weak self] in
            // Set up dismiss callback when presentation is complete
            vc.presentationController?.delegate = self
        }
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss?()
    }
}
