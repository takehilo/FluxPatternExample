import RxSwift

final class Dispatcher {
    static let shared = Dispatcher()

    private let dispatcher = PublishSubject<Action>()

    func register<A: Action>(handler: @escaping (_ action: A) -> Void) -> Disposable {
        return dispatcher.subscribe(onNext: { action in
            guard let action = action as? A else { return }
            handler(action)
        })
    }

    func dispatch(_ action: Action) {
        dispatcher.onNext(action)
    }
}
