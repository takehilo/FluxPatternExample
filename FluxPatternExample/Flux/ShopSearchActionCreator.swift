class ShopSearchActionCreator: ActionCreator {
    static let shared = ShopSearchActionCreator()

    var dispatcher: Dispatcher

    required init(with dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }

    func selectQuery(query: String) {
        dispatcher.dispatch(ShopSearchActions.querySelected(query: query))
    }
}
