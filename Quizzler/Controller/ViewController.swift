//
//  ViewController.swift
//  Quizzler
//
//  Created by song on 5/16/22.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var currentQuestionIndex: Int = 0
    var currentQuestionCorrect: Bool = false
    var currentScore: Int = 0
    var questionNumber = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        
        let firstQuestion = allQuestions.list[currentQuestionIndex]
        
        questionLabel.text = firstQuestion.questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
  
        // -- Find out which answer was pressed (True/False)
        //print(Int(sender.tag))
        
        var senderTag: Int = Int(sender.tag)

        
        if (senderTag == 1) {
            pickedAnswer = true
        }
        else if (senderTag == 2) {
            pickedAnswer = false
        }
        
        //print(pickedAnswer)
        
        // -- Check the Answer
        checkAnswer()
    }
    
    
    func updateUI() {
      
        if (currentQuestionCorrect)
        {
            currentScore += 1
        }
        
        // -- Update the score
        scoreLabel.text = "Score: \(currentScore)"
        
        // -- Update the progress label and bar
        if (questionNumber < allQuestions.list.count)
        {
            questionNumber += 1
        }
        
        progressLabel.text = "\(questionNumber) / 13"
        
        var progressBarWidth = ( view.frame.size.width / CGFloat(allQuestions.list.count) ) * CGFloat(questionNumber)
        print("ProgressBar width should be \(progressBarWidth)")
        
        progressBar.frame.size.width = progressBarWidth
        
    }
    

    func nextQuestion() {
        
        currentQuestionIndex = currentQuestionIndex + 1
        questionLabel.text = allQuestions.list[currentQuestionIndex].questionText
        
//        questionNumber += 1
        
    }
    
    
    func checkAnswer() {
        
        if (allQuestions.list[currentQuestionIndex].answer == pickedAnswer)
        {
            print("Got the correct answer!")
            currentQuestionCorrect = true
        }
        else
        {
            print("😡 Sorry you got it wrong!!!")
            currentQuestionCorrect = false
        }
        
        updateUI()
        
        // Go to the next question
        // -- Check if got to the max
        
        if  (currentQuestionIndex < allQuestions.list.count-1)
        {
            nextQuestion()
        }
        else {
            var message = "You reach the end of the Quiz!"
            print(message)
            
            showRestartAlert("Complete!", message)
            
            
            // -- Disable the buttons and allow them to start over
        }
                
        
    }
    
    func showAlert(_ Title: String, _ Message: String) {
        
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showRestartAlert(_ Title: String, _ Message: String) {
        
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
//        let alertAction = UIAlertAction(title: "Restart", style: .default, handler: nil)
        let alertAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in
            self.startOver()
        })
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    func startOver() {
       currentQuestionIndex = -1
        currentScore = currentQuestionIndex
        questionNumber = 0
        
        nextQuestion()
        updateUI()
        
    }
    

    
}
