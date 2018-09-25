import UIKit
import RxSwift

class BaseViewController: UIViewController {
    #if TRACE_RESOURCES
    private let startResourceCount = Resources.total
    #endif

    override func viewDidLoad() {
        super.viewDidLoad()

        #if TRACE_RESOURCES
        let className = NSStringFromClass(self.classForCoder)
        print("[\(className) viewDidLoad] Number of resources: \(Resources.total)")
        #endif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        #if TRACE_RESOURCES
        let className = NSStringFromClass(self.classForCoder)
        print("[\(className) viewWillAppear] Number of resources: \(Resources.total)")
        #endif
    }

    deinit {
        #if TRACE_RESOURCES
        let className = NSStringFromClass(self.classForCoder)
        print("[\(className) before deinit] Number of resources: \(Resources.total)")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            print("[\(className) after deinit] Number of resources: \(Resources.total)")
        }
        #endif
    }
}
