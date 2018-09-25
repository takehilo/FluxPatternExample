import UIKit
import RxSwift
import RxCocoa

class ShopSearchViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var vm: ShopSearchViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    func setupTableView() {
        vm.genres
            .drive(tableView.rx.items(cellIdentifier: "ShopSearchCell", cellType: UITableViewCell.self)) { (_, element, cell) in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected.asDriver()
            .do(onNext: { [unowned self] in self.tableView.deselectRow(at: $0, animated: false)} )
            .withLatestFrom(vm.genres) { ($0, $1) }
            .map { (indexPath, genres) in genres[indexPath.row] }
            .drive(onNext: { [unowned self] genre in
                self.vm.querySelected.onNext(genre)
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
