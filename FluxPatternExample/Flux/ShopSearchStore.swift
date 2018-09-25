import RxSwift
import RxCocoa

class ShopSearchStore: Store {
    var query: Observable<String> {
        return queryStream.asObservable()
    }
    
    private let disposeBag = DisposeBag()

    private let queryStream = BehaviorRelay<String>(value: "カフェ")

    required init(with dispatcher: Dispatcher = .shared) {
        dispatcher.register { [unowned self] (action: ShopSearchActions) in
            switch action {
            case let .querySelected(query):
                self.queryStream.accept(query)
            }
        }
        .disposed(by: disposeBag)
    }
}
