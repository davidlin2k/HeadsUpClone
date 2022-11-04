//
//  ViewController.swift
//  HeadsUp
//
//  Created by David Lin on 2022-08-21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var maxScoreLabel: UILabel!
    @IBOutlet weak var lastScoreLabel: UILabel!
    @IBOutlet weak var settingImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        settingImageView.isUserInteractionEnabled = true
        settingImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "maxScore") == nil) {
            defaults.set(0, forKey: "maxScore")
        }
        
        let maxScore = defaults.integer(forKey: "maxScore")
        
        self.maxScoreLabel.text = "Max Score: \(maxScore)"
        
        if (defaults.object(forKey: "lastScore") == nil) {
            defaults.set(0, forKey: "lastScore")
        }
        
        let lastScore = defaults.integer(forKey: "lastScore")
        
        self.lastScoreLabel.text = "Last Score: \(lastScore)"
    }

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        let defaults = UserDefaults.standard
        
        let maxScore = defaults.integer(forKey: "maxScore")
        self.maxScoreLabel.text = "Max Score: \(maxScore)"
        
        let lastScore = defaults.integer(forKey: "lastScore")
        self.lastScoreLabel.text = "Last Score: \(lastScore)"
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        // Your action
    }
}

