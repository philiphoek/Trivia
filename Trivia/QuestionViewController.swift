//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Philip van der Hoek on 14/03/2018.
//  Copyright © 2018 Philip van der Hoek. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var answerTextField: UITextField!
    
    let questionController = QuestionController()
    
    var questions = [QuestionItem]()
    
    var answer = ""
    
    var name: String!
    
    var score: Score?
    
    let amountQuestions = 10
    var questionIndex = 0
    var totalPoints = 0
    
    override func viewDidLoad() {
        questionLabel.text = "Waiting for question..."
        super.viewDidLoad()
        fetchQuestion()
        updateAnswer()
        scoreLabel.text = name + ", your score is: " + String(totalPoints)
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
            self.answer = questions[0].answer
            print(self.answer)
        }
    }
    
    func updateAnswer() {
        let submittedAnswer = answerTextField.text!
        submitButton.isEnabled = !submittedAnswer.isEmpty
    }
    
    @IBAction func submitAnswerButtonTapped(_ sender: UIButton) {
        //fetch next question when answer is submitted
        questionIndex += 1
        let submittedAnswer = answerTextField.text!
        if questionIndex <= amountQuestions && answer == submittedAnswer {
            fetchQuestion()
            totalPoints += 1
            scoreLabel.text = name + ", your score is: " + String(totalPoints)
            print("right answer")
            answerTextField.text = ""
        } else if questionIndex <= amountQuestions {
            fetchQuestion()
            print("wrong answer")
            answerTextField.text = ""
        } else {
            print(name)
            score = Score(player: name, points: totalPoints)
            self.questionLabel.text = "Your're Done"
            answerTextField.isEnabled = false
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
    @IBAction func answerEdited(_ sender: UITextField) {
        updateAnswer()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        answerTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "resultSegue" {
            let resultViewController = segue.destination as!
            ResultViewController
            resultViewController.score = score
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
