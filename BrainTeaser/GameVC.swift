//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Jonny B on 3/30/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var answerImg: CustomView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var highScoreLbl: UILabel!
    @IBOutlet weak var finalScoreLbl: UILabel!
    @IBOutlet weak var modalView: MaterialView!
    
    var currentCard: Card!
    var previousCard: Card!
    
    var currentCardID = String()
    var previousCardID = String()
    
    var count = 10.0
    var gameActive: Bool = false
    var timer = NSTimer()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        
        self.view.addSubview(currentCard)
        
    }
    
    
    func startTimer(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "update", userInfo: nil, repeats: true)
        
    }
    
    func update() {
        
        if (count > 0) {
            count = count - 1
            timerLbl.text = "\(Int(count))"
        } else {
            
            gameOver()
            
        }
    }
    
    @IBAction func yesPressed(sender: UIButton) {
        
        if sender.titleLabel?.text == "YES" {
           
            checkAnswerForYes()
            
        } else {
            
            titleLbl.text = "Does this card match the previous?"
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(sender: AnyObject) {
        
        checkAnswerForNo()
      
        showNextCard()
    }
    
    func showNextCard() {
        
        if let current = currentCard {
            
            currentCardID = current.currentShape
            print(currentCardID)
            
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished:Bool) -> Void in
                
                cardToRemove.removeFromSuperview()
                
            })
            
        }
        
        if let next = createCardFromNib() {
            
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            previousCardID = next.currentShape
            print(previousCardID)
            
            if noBtn.hidden {
                
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
                startTimer()
                scoreLbl.text = "0"
                gameActive = true
                
                
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished:Bool) -> Void in
                
                
            })
        }
    }
    
    func createCardFromNib() -> Card? {
        
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
        
    }
    
    
    func checkAnswerForYes() {
        
        if currentCardID == previousCardID {
            
            answerImg.image = UIImage(named: "correct.png")
            answerImg.scaleToSmall()
            answerImg.scaleAnimation()
            answerImg.scaleDefault()
            score += 1
            scoreLbl.text = String(score)
            
        } else {
            
            answerImg.image = UIImage(named: "wrong.png")
            answerImg.scaleToSmall()
            answerImg.scaleAnimation()
            answerImg.scaleDefault()
        }
        
    }
    
    func checkAnswerForNo() {
        
        if currentCardID == previousCardID {
            
            answerImg.image = UIImage(named: "wrong.png")
            answerImg.scaleToSmall()
            answerImg.scaleAnimation()
            answerImg.scaleDefault()
            
        } else {
            
            answerImg.image = UIImage(named: "correct.png")
            answerImg.scaleToSmall()
            answerImg.scaleAnimation()
            answerImg.scaleDefault()
            score += 1
            scoreLbl.text = String(score)
            
        }
        
    }
    
    
    func gameOver() {
        
        timer.invalidate()
        gameActive = false
        noBtn.hidden = true
        yesBtn.setTitle("START", forState: .Normal)
        count = 10
        titleLbl.text = "Remember this image."
        timerLbl.text = "30"
        answerImg.image = nil
        modalView.hidden = false
        modalView.layer.zPosition = CGFloat(MAXFLOAT)
        
        
        finalScoreLbl.text = String(score)
        highScoreLbl.text = String(score)
        
        score = 0
        
        yesBtn.enabled = false
    }
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        
        modalView.hidden = true
        yesBtn.enabled = true
        
    }
    
    func animateAnswerImg() {
        
        
    }
    
    
}
