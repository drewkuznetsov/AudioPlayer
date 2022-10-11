import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var selfView: View { view as! View }
    
    override func loadView() {
        view = View()
    }
}
