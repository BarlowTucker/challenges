//
//  DiceViewController.swift
//  Challenge2
//
//  Created by Barlow Tucker on 4/1/16.
//  Copyright © 2016 Jane. All rights reserved.
//

import UIKit
import BFPaperButton

class DiceViewController:UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var rollButton: BFPaperButton!
    @IBOutlet var diceButtons: [UIButton]!
    @IBOutlet weak var endRoundButton: BFPaperButton!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    //MARK: - Private Variables
    private let diceRoller: DiceRoller = DiceRoller(numberOfDice: 3)
    
    //MARK: - Private Methods
    private func setDiceButtonImages() {
        for (index, dieButton) in self.diceButtons.enumerate() {
            dieButton.setImage(self.diceRoller.dice[index].image, forState: .Normal)
        }
    }
    private func indexForDie(die:UIButton) -> Int {
        return self.diceButtons.indexOf(die) ?? 0
    }
    
    private func resetDice() {
        self.diceRoller.reset()
        self.setDiceButtonImages()
    }
    
    private func updateView() {
        self.endRoundButton.hidden = !self.diceRoller.isGameStarted
        self.setDiceButtonImages()
        self.currentScoreLabel.text = "\(self.diceRoller.currentScore)"
        self.highScoreLabel.text = "\(self.diceRoller.highScore)"
        
        let title:String = self.diceRoller.isGameOver ? "GAME OVER! Start Over" : "Roll!"
        self.rollButton.setTitle(title, forState: .Normal)
        self.rollButton.backgroundColor = self.diceRoller.isGameOver ? DiceStyleKit.gameOver : DiceStyleKit.rollColor
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rollButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.endRoundButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.endRoundButton.backgroundColor = DiceStyleKit.greenDie
        self.updateView()
    }
    
    //MARK: - IBActions
    @IBAction func rollTapped(sender: AnyObject) {
        self.diceRoller.rollDice()
        self.updateView()
    }
    
    @IBAction func dieTapped(sender: UIButton) {
        self.diceRoller.lockDie(atIndex: self.diceButtons.indexOf(sender)!)
        self.updateView()
    }
    @IBAction func endRoundTapped(sender: AnyObject) {
        self.diceRoller.endRound()
        self.updateView()
    }
}