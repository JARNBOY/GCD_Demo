//
//  ViewController.swift
//  GCD_Demo
//
//  Created by Papon Supamongkonchai on 4/4/2566 BE.
//

import UIKit

enum TaskQueueType {
    case serialQueue //synchonize
    case concurrentlyQueue //asynchonize
    case badQueue
}

class ViewController: UIViewController {
    
    @IBOutlet weak var lblThreadOne: UILabel!
    @IBOutlet weak var lblThreadTwo: UILabel!
    @IBOutlet weak var lblThreadThree: UILabel!
    @IBOutlet weak var btnStartQueue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func runQueueTask(selectTypeQeue: TaskQueueType) {
        switch selectTypeQeue {
        case .serialQueue:
            self.startSerialQueue()
        case .concurrentlyQueue:
            self.startConcurrentlyQueue()
        case .badQueue:
            self.startCrashBadThread()
        }
        
        //Dispatch delay for see action start till end from text
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setText(text: "isComplete Loop")
        }
        
    }
    
    func startSerialQueue() {
        //default process GCD is serial queue (synchronous) because GCD queue is FIFO.
        let serialQueue = DispatchQueue(label: "SerialQueue")
        
        serialQueue.sync {
            self.loopThousandEaterPerformance(indexName:1)
            self.loopThousandEaterPerformance(indexName:2)
            self.loopThousandEaterPerformance(indexName:3)
        }
    }
    
    func startConcurrentlyQueue() {
        //process GCD of "attributes: .concurrent" concurrently queue (asynchronous)
        let concerrentlyQueue = DispatchQueue(label: "ConcurrentlyQueue", attributes: .concurrent)
        
        concerrentlyQueue.async {
            self.loopThousandEaterPerformance(indexName:1)
            self.loopThousandEaterPerformance(indexName:2)
            self.loopThousandEaterPerformance(indexName:3)
        }
    }
    
    func startSampleDispatchGroup() {
        
    }
    
    func startSampleDispatchSemaphore() {
        
    }
    
    private func loopThousandEaterPerformance(indexName:Int) {
        let goText: String = "Go"
        for i in 0...1000 {
            print("\(goText) \(indexName) : \(i)")
        }
    }
    
    private func setText(text:String) {
        lblThreadOne.text = "Thread 1 : \(text)"
        lblThreadTwo.text = "Thread 2 : \(text)"
        lblThreadThree.text = "Thread 3 : \(text)"
    }
    
    private func startCrashBadThread() {
        //This function bring you crash app because thread about set UI need on process in async queue parallel
        DispatchQueue.main.sync {
            self.loopThousandEaterPerformance(indexName:1)
            self.loopThousandEaterPerformance(indexName:2)
            self.loopThousandEaterPerformance(indexName:3)
        }
    }
    
    //MARK: Button Action
    
    @IBAction func btnStartQueue_click() {
        setText(text: "Start Queue Loop")
        runQueueTask(selectTypeQeue: .concurrentlyQueue)
    }
    
}

