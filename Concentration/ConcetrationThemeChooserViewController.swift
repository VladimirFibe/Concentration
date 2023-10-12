import UIKit

class ConcetrationThemeChooserViewController: UITableViewController {
    let themes = ConcetrationTheme.all

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        themes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = themes[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = ConcentrationViewController()
        controller.theme = themes[indexPath.row].theme
        showDetailViewController(controller, sender: self)
    }
}

extension ConcetrationThemeChooserViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
        true
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
