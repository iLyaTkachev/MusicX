import PKHUD

class Loading {
    
    static func show() {
        HUD.show(.systemActivity)
    }
    
    static func dismiss() {
        HUD.hide()
    }
    
    static func success() {
        HUD.flash(.success, delay: 0.1)
    }
    
    static func failure() {
        HUD.flash(.error, delay: 0.1)
    }
    
    static func dismiss(_ isSuccess: Bool) {
        isSuccess ? Loading.success() : Loading.failure()
    }
    
}
