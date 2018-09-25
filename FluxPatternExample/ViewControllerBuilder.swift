import UIKit

class ViewControllerBuilder {
    static let shared = ViewControllerBuilder()

    private let dispatcher = Dispatcher()
    private let shopSearchStore: ShopSearchStore
    private let shopSearchActionCreator: ShopSearchActionCreator

    init() {
        shopSearchStore = ShopSearchStore(with: dispatcher)
        shopSearchActionCreator = ShopSearchActionCreator(with: dispatcher)
    }

    func makeShopListViewController() -> ShopListViewController {
        let vm = ShopListViewModel(store: shopSearchStore)
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ShopListViewController") as! ShopListViewController
        vc.vm = vm
        return vc
    }

    func makeShopSearvhViewController() -> ShopSearchViewController {
        let vm = ShopSearchViewModel(store: shopSearchStore, actionCreator: shopSearchActionCreator)
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ShopSearchViewController") as! ShopSearchViewController
        vc.vm = vm
        return vc
    }
}
