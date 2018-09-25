import RxSwift
import RxCocoa

class ShopSearchViewModel {
    var genres: Driver<[String]> {
        return Driver.just(Genre.list)
    }

    var querySelected: AnyObserver<String> {
        return querySelectedStream.asObserver()
    }

    private let disposeBag = DisposeBag()

    private let actionCreator: ShopSearchActionCreator

    private let querySelectedStream = PublishSubject<String>()

    init(actionCreator: ShopSearchActionCreator) {
        self.actionCreator = actionCreator

        querySelectedStream.subscribe(onNext: { [unowned self] query in
            self.actionCreator.selectQuery(query: query)
        })
        .disposed(by: disposeBag)
    }
}

struct Genre {
    static let list = ["カフェ", "ステーキ", "牛丼"]
}
