import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let primary = ConcetrationThemeChooserViewController()
        let secondary = ConcentrationViewController()
        let controller = UISplitViewController(style: .doubleColumn)
        controller.delegate = primary
        primary.lastConcentrationViewController = secondary
        controller.setViewController(UINavigationController(rootViewController: primary), for: .primary)
        controller.setViewController(UINavigationController(rootViewController: secondary), for: .secondary)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        return true
    }
}
