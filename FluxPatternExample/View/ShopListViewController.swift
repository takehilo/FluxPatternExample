import UIKit
import RxSwift
import RxCocoa

class ShopListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var vm: ShopListViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
    }

    func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        navigationItem.setRightBarButton(searchButton, animated: true)

        searchButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self] _ in
                let vc = ViewControllerBuilder.shared.makeShopSearvhViewController()
                self.present(vc, animated: true)
            })
            .disposed(by: disposeBag)

        vm.query.drive(navigationItem.rx.title).disposed(by: disposeBag)
    }

    func setupTableView() {
        vm.shops
            .drive(tableView.rx.items(cellIdentifier: "ShopListCell", cellType: UITableViewCell.self)) { (_, element, cell) in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
    }
}
