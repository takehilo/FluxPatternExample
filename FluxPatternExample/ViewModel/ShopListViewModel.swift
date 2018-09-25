import RxSwift
import RxCocoa

class ShopListViewModel {
    var shops: Driver<[String]> {
        return shopsStream.asDriver()
    }

    var query: Driver<String> {
        return store.query.asDriver(onErrorJustReturn: "")
    }

    private let store: ShopSearchStore
    private let shopsStream = BehaviorRelay<[String]>(value: [])
    private let disposeBag = DisposeBag()

    init(store: ShopSearchStore) {
        self.store = store

        store.query
            .map { Shop.list[$0]! }
            .bind(to: shopsStream)
            .disposed(by: disposeBag)
    }
}

struct Shop {
    static let list = [
        "カフェ": ["スターバックス", "ドトール", "エクセルシオールカフェ"],
        "ステーキ": ["いきなりステーキ", "モンスターグリル"],
        "牛丼": ["すき家", "松屋", "吉野家"]
    ]
}
