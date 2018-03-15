//
//  ViewController.swift
//  Trivia
//
//  Created by Philip van der Hoek on 14/03/2018.
//  Copyright © 2018 Philip van der Hoek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startGameButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateStartButtonState() {
        let name = nameTextField.text!
        startGameButton.isEnabled = !name.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameStarted" {
            let name = nameTextField.text!
            let questionViewController = segue.destination as!
            QuestionViewController
            questionViewController.name = name
        }
    }
    @IBAction func nameEdited(_ sender: UITextField) {
        updateStartButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        nameTextField.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

