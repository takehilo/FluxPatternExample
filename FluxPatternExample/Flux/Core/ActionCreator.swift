protocol ActionCreator {
    var dispatcher: Dispatcher { get }
    init(with dispatcher: Dispatcher)
}
