//
//  GameViewController.swift
//  HeadsUp
//
//  Created by David Lin on 2022-08-21.
//

import UIKit

class GameViewController: UIViewController, GameEngineDelegate {
    
    @IBOutlet weak var timeProgressView: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var correctView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var timesUpView: UIView!
    
    let gameEngine = GameEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine.delegate = self
        self.wordLabel.text = gameEngine.getCurrentWord()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        gameEngine.onExit()
    }
    
    func updateProgressBar(progress: Float) {
        self.timeProgressView.setProgress(progress, animated: false)
    }
    
    func correct() {
        correctView.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            self.correctView.isHidden = true
        })
        
        self.scoreLabel.text = "Score: \(gameEngine.getScore())"
        self.wordLabel.text = gameEngine.getCurrentWord()
    }

    func pass() {
        passView.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            self.passView.isHidden = true
        })
        
        self.wordLabel.text = gameEngine.getCurrentWord()
    }
    
    func timesUp() {
        timesUpView.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            self.timesUpView.isHidden = true
        })
        
        self.wordLabel.text = gameEngine.getCurrentWord()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        gameEngine.onExit()
    }
}
