//
//  ResultViewController.swift
//  Trivia
//
//  Created by Philip van der Hoek on 15/03/2018.
//  Copyright © 2018 Philip van der Hoek. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var score: Score!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = score.player + " has " + String(score.points) + " points."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
