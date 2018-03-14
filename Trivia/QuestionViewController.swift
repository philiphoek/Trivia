//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Philip van der Hoek on 14/03/2018.
//  Copyright © 2018 Philip van der Hoek. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var answerTextField: UITextField!
    
    let questionController = QuestionController()
    
    var questions = [QuestionItem]()
    
    var answer = ""
    var submittedAnswer = ""
    
    let amountQuestions = 10
    var questionIndex = 0
    var totalPoints = 0
    
    override func viewDidLoad() {
        questionLabel.text = "Waiting for question..."
        super.viewDidLoad()
        fetchQuestion()
    }
    
    func fetchQuestion() {
        // initiate progress bar
        let totalProgress = Float(questionIndex) / Float(amountQuestions)
        progressView.setProgress(totalProgress, animated: true)
        
        // fetch random question
        questionController.fetchQuestionItems { (questions) in
            if let questions = questions {
                self.updateUI(with: questions)
            }
        }
    }
    
    func updateUI(with questions: [QuestionItem]) {
        // update UI with new question
        DispatchQueue.main.async {
            self.questionLabel.text = questions[0].question
            self.answer = questions[0].question
            print(questions[0].answer)
        }
    }
    
    @IBAction func submitAnswerButtonTapped(_ sender: UIButton) {
        //fetch next question when answer is submitted
        questionIndex += 1
        if questionIndex <= amountQuestions && answer == submittedAnswer {
            fetchQuestion()
            totalPoints += 1
            print("right answer")
        } else if questionIndex <= amountQuestions {
            fetchQuestion()
            print("wrong answer")
        } else {
            self.questionLabel.text = "Your're Done"
        }
    }
    
    @IBAction func answerEdited(_ sender: Any) {
        submittedAnswer = answerTextField.text!
        print(submittedAnswer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
