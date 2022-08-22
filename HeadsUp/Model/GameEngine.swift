//
//  GameEngine.swift
//  HeadsUp
//
//  Created by David Lin on 2022-08-22.
//

import Foundation
import CoreMotion

protocol GameEngineDelegate {
    func updateProgressBar(progress: Float)
    func pass()
    func correct()
    func timesUp()
}

class GameEngine {
    let defaults = UserDefaults.standard
    
    let words = ["Cat", "Sun", "Cup", "Ghost", "Flower", "Pie", "Cow", "Banana", "Snowflake", "Bug", "Book", "Jar", "Snake", "Light", "Tree", "Lips", "Apple", "Slide", "Socks", "Smile", "Swing", "Coat", "Shoe", "Water", "Heart", "Hat", "Ocean", "Kite", "Dog", "Mouth", "Milk", "Duck", "Eyes", "Skateboard", "Bird", "Boy", "Apple", "Person", "Girl", "Mouse", "Ball", "House", "Star", "Nose", "Bed", "Whale", "Jacket", "Shirt", "Hippo", "Beach", "Egg", "Face", "Cookie", "Cheese", "Ice", "Cream", "Cone", "Drum", "Circle", "Spoon", "Worm", "Spider", "Web"]
    
    let motionManager = CMMotionManager()
    var totalTime: Double = 10.0
    var countDown: Double = 10.0
    var timer: Timer!
    
    var _currentWord: String
    var _score: Int = 0
    
    var delegate: GameEngineDelegate?
    
    init() {
        if (motionManager.isGyroAvailable) {
            motionManager.gyroUpdateInterval = (1.0 / 60.0)
            motionManager.startGyroUpdates()
        }
        
        self._currentWord = words.randomElement() ?? "Default"
        
        self.timer = startTimer()
    }
    
    func stopGyroUpdates() {
        motionManager.stopGyroUpdates()
    }
    
    func startTimer() -> Timer {
        return Timer.scheduledTimer(withTimeInterval: (1.0 / 60.0), repeats: true, block: { timer in
            guard let y = self.motionManager.gyroData?.rotationRate.y else { return }
            
            if (self.countDown > 0) {
                self.countDown -= (1.0 / 60.0)
                
                if (y < -12.0) {
                    self.timer.invalidate()
                    self.nextWord()
                    self._score += 1
                    self.delegate?.correct()
                }
                else if (y > 12.0) {
                    self.timer.invalidate()
                    self.nextWord()
                    self.delegate?.pass()
                }
            }
            else {
                self.timer.invalidate()
                self.nextWord()
                self.delegate?.timesUp()
            }
            
            self.delegate?.updateProgressBar(progress: Float(self.countDown) / Float(self.totalTime))
        })
    }
    
    func nextWord() {
        countDown = 10.0
        self._currentWord = self.words.randomElement() ?? "Default"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { () in
            self.timer = self.startTimer()
        })
    }
    
    func getCurrentWord() -> String {
        return self._currentWord
    }
    
    func getScore() -> Int {
        return self._score
    }
    
    func onExit() {
        stopGyroUpdates()
        
        let defaults = UserDefaults.standard
        
        if (self.getScore() > defaults.integer(forKey: "maxScore")) {
            defaults.set(self.getScore(), forKey: "maxScore")
        }
        
        defaults.set(self.getScore(), forKey: "lastScore")
    }
}
