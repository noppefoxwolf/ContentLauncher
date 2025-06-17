import UIKit

extension UIButton.Configuration {
    @MainActor
    public static func launcher() -> UIButton.Configuration {
        #if compiler(>=6.2)
        if #available(iOS 26.0, *) {
            .modernLauncher()
        } else {
            .legacyLauncher()
        }
        #else
        .legacyLauncher()
        #endif
    }
    
    #if compiler(>=6.2)
    @available(iOS 26.0, *)
    @MainActor
    static func modernLauncher() -> UIButton.Configuration {
        var configuration: UIButton.Configuration = .glass()
        configuration.image = UIImage(systemName: "terminal")
        return configuration
    }
    #endif
    
    @MainActor
    static func legacyLauncher() -> UIButton.Configuration {
        var configuration: UIButton.Configuration = .plain()
        configuration.baseForegroundColor = .label
        configuration.background.visualEffect = UIBlurEffect(style: .systemMaterial)
        configuration.background.backgroundColor = .clear
        configuration.background.strokeWidth = 1
        configuration.background.strokeOutset = 1
        configuration.background.strokeColor = .white.withAlphaComponent(0.3)
        if #available(iOS 18.0, *) {
            configuration.background.shadowProperties.opacity = 0.75
            configuration.background.shadowProperties.radius = 50
        }
        configuration.cornerStyle = .capsule
        configuration.image = UIImage(systemName: "terminal")
        return configuration
    }
}

