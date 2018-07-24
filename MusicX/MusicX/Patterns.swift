import Foundation

//Decorator Pattern
protocol MacBook {
    
    var cost : Double { get }
    
    var description : String { get }
    
}

class MacBookAir: MacBook {
    
    var cost: Double {
        get {
            return 999
        }
    }
    
    var description: String {
        get {
            return "MacBook Air"
        }
    }
    
}

class MacBookPro: MacBook {
    
    var cost: Double {
        get {
            return 1499
        }
    }
    
    var description: String {
        get {
            return "MacBook Pro"
        }
    }
}

class MacBookDecorator: MacBook {
    
    var cost: Double {
        get {
            return mInstance.cost
        }
    }
    
    var description: String {
        get {
            return mInstance.description
        }
    }
    
    let mInstance: MacBook
    
    required init(pInstance: MacBook) {
        mInstance = pInstance
    }
}

class ProcessorUpgrade: MacBookDecorator {
    
    override var cost: Double {
        get {
            return mInstance.cost + 500
        }
    }
    
    override var description: String {
        get {
            return mInstance.description + " i7 processor"
        }
    }
    
    
    required init(pInstance: MacBook) {
        super.init(pInstance: pInstance)
    }
}
