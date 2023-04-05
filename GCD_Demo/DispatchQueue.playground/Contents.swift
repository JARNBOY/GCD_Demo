import UIKit


func mainQueue() {
    DispatchQueue.main.async {
        print("Hello main queue")
    }
}

func globalQueue() {
    let globalQueue = DispatchQueue.global()
    globalQueue.async {
        print("Hello global queue")
    }
}

func customQueue() {
    let concurrentQueue = DispatchQueue(label: "queuename1",attributes: .concurrent)
    
    concurrentQueue.async  {
        for i in 0...10 {
            print("\(i) Hello concurrent queue")
        }
        
        for i in 0...10 {
            print("\(i) Second Hello concurrent queue")
        }
        
        print("Done concurrent")
        
    }
    
    let serialQueue = DispatchQueue(label: "queuename2")
    
    serialQueue.sync {
        print("Hello serial queue")
    }
}

mainQueue()
globalQueue()
customQueue()
