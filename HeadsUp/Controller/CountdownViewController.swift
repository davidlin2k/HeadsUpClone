//
//  CountdownViewController.swift
//  HeadsUp
//
//  Created by David Lin on 2022-08-21.
//

import UIKit

class CountdownViewController: UIViewController {
    @IBOutlet weak var countDownLabel: UILabel!
    
    var countDown: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.countDown -= 1
            
            if (self.countDown == 0) {
                timer.invalidate()
                self.performSegue(withIdentifier: "showGameView", sender: self)
            }
            else {
                self.countDownLabel.text = String(self.countDown)
            }
        })
    }
}
