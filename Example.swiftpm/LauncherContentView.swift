import SwiftUI
import UIKit

struct LauncherContentView: View {
    var body: some View {
        NavigationView {
            List {
                LabeledContent {
                    Text(.now, style: .time)
                } label: {
                    Text("Server time")
                }
                
                Button {
                    debugKeyWindow()
                } label: {
                    Text("Debug Key Window")
                }
                
                Button {
                    exit(0)
                } label: {
                    Text("Exit app")
                }
            }
            .navigationTitle("Debug Tools")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func debugKeyWindow() {
        print("Debug Key Window tapped - printing key window info in 3 seconds...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            guard let keyWindow = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .first(where: { $0.isKeyWindow }) else {
                print("No key window found")
                return
            }
            
            print("=== Key Window Debug Info ===")
            print("Window: \(keyWindow)")
            print("Frame: \(keyWindow.frame)")
            print("Bounds: \(keyWindow.bounds)")
            print("Safe Area Insets: \(keyWindow.safeAreaInsets)")
            print("Root View Controller: \(String(describing: keyWindow.rootViewController))")
            print("Window Level: \(keyWindow.windowLevel)")
            print("Is Key Window: \(keyWindow.isKeyWindow)")
            print("Is Hidden: \(keyWindow.isHidden)")
            print("Alpha: \(keyWindow.alpha)")
            print("Transform: \(keyWindow.transform)")
            
            if let rootVC = keyWindow.rootViewController {
                print("Root VC View Frame: \(rootVC.view.frame)")
                print("Root VC View Bounds: \(rootVC.view.bounds)")
            }
            
            print("=============================")
        }
    }
}
