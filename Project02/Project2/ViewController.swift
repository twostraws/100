//
//  ViewController.swift
//  Project2
//
//  Created by William Spanfelner on 26/05/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
//    @IBOutlet weak var testLabel: UILabel!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        // MARK: Useful technique of applying a border
//        testLabel.layer.borderWidth = 5
//        testLabel.layer.borderColor = UIColor.red.cgColor
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showScore))
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() + "    Score: \(score)"
        questionsAsked += 1
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        

        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Ooops!\nThe flag of \(countries[sender.tag].uppercased()) was selected"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        if questionsAsked == 10 {
            ac.addAction(UIAlertAction(title: "Final Score = \(score) / \(questionsAsked)", style: .default, handler: askQuestion))
        } else {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let yourScore = "Your score is \(score) / \(questionsAsked - 1)"
//: An alert style message can be displayed as follows:
        let ac = UIAlertController(title: "Your score", message: yourScore, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
//:  An activityVC approach is shown here.
        let vc = UIActivityViewController(activityItems: [yourScore], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}

