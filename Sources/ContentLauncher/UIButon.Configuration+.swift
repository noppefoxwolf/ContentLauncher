import UIKit

extension UIButton.Configuration {
    @MainActor
    public static func launcher() -> UIButton.Configuration {
        #if os(visionOS)
        .blurLauncher()
        #elseif os(iOS)
        if #available(iOS 26.0, *) {
            .glassLauncher()
        } else {
            .blurLauncher()
        }
        #endif
    }
    
    @available(iOS 26.0, *)
    @available(visionOS, unavailable)
    @MainActor
    static func glassLauncher() -> UIButton.Configuration {
        var configuration: UIButton.Configuration = .glass()
        configuration.image = UIImage(systemName: "wrench.and.screwdriver")
        return configuration
    }
    
    @MainActor
    static func blurLauncher() -> UIButton.Configuration {
        var configuration: UIButton.Configuration = .plain()
        configuration.baseForegroundColor = .label
        configuration.background.visualEffect = UIBlurEffect(style: .systemMaterial)
        configuration.background.backgroundColor = .clear
        configuration.background.strokeWidth = 1
        configuration.background.strokeOutset = 1
        configuration.background.strokeColor = .white.withAlphaComponent(0.3)
        if #available(iOS 18.0, visionOS 2.0, *) {
            configuration.background.shadowProperties.opacity = 0.75
            configuration.background.shadowProperties.radius = 50
        }
        configuration.cornerStyle = .capsule
        configuration.image = UIImage(systemName: "wrench.and.screwdriver")
        return configuration
    }
}

