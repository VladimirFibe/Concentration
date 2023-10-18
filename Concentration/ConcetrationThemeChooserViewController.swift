import UIKit

class ConcetrationThemeChooserViewController: VCLLoggingViewController, UITableViewDelegate, UITableViewDataSource {
    let themes = ConcetrationTheme.all

    lazy var tableView: UITableView = {
        view.addSubview($0)
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return $0
    }(UITableView())

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        themes.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = themes[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = (splitViewDetailConcentrationViewController ?? lastConcentrationViewController) ?? ConcentrationViewController()
        lastConcentrationViewController = controller
        controller.theme = themes[indexPath.row].theme
        showDetailViewController(controller, sender: self)
    }

    var lastConcentrationViewController: ConcentrationViewController?

    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        (splitViewController?.viewControllers.last as? UINavigationController)?.topViewController as? ConcentrationViewController
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ConcetrationThemeChooserViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
        true
    }

    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        ((svc.viewControllers.last as? ConcentrationViewController)?.theme == nil) ? .primary : .secondary
    }
}

struct ConcetrationTheme {
    let title: String
    let theme: String

    static let all: [ConcetrationTheme] = [
        .init(title: "Sports", 
              theme: "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒🏑🥍🏏🪃🛼🥊⛸️"),
        .init(title: "Animals", 
              theme: "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐵🐔🐧🐦"),
        .init(title: "Faces", 
              theme: "😀😃😄😁😆😅🥹😂🤣🥲☺️😊🙂🙃😉🥰😍😌😘")
    ]
}
