//
//  ViewController.swift
//  ikid
//
//  Created by Henry Bao on 5/3/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectJoke()
        switchViewController(nil, to: jokeViewController)
    }
    
    let jokesDict = [
        "Good": [
            "1": [
                "Joke" : "Why don't you ever see elephants hiding in trees?",
                "Punchline": "Because they're really good at it"
            ],
            "2": [
                "Joke" : "What do you call a cow with no legs?",
                "Punchline": "Ground beef"
            ],
            "3": [
                "Joke" : "What did the egg say to the pot of boiling water?",
                "Punchline": "It's going to take me a minute to get hard, I just got laid this morning"
            ],
        ],
        "Pun": [
            "1": [
                "Joke" : "Time flies like an arrow",
                "Punchline": "Fruit flies like a banana"
            ],
            "2": [
                "Joke" : "What do you get if you drop a piano down a mine shaft?",
                "Punchline": "A flat minor"
            ],
            "3": [
                "Joke" : "What do you get if you drop a piano on a military base?",
                "Punchline": "A flat major"
            ],
        ],
        "Dad": [
            "1": [
                "Joke" : "Why shouldn't you wear glasses when you play football?",
                "Punchline": "Because it's a contact sport"
            ],
            "2": [
                "Joke" : "What should you do if you are cold?",
                "Punchline": "Stand in the corner. It’s 90 degrees"
            ],
            "3": [
                "Joke" : "When does a joke become a dad joke?",
                "Punchline": "When the punchline becomes ap-parent"
            ],
        ],
    ]
    
    let knockKnock = ["Moo", "Knock knock", "Who's there?", "Time-traveling cow", "Time-traveling cow who?"]
    
    var jokeViewController: JokeViewController! = nil
    var punchlineViewController: PunchlineViewController! = nil
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func switchView(_ sender: Any) {
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)

        if nextButton.titleLabel?.text == "Home" {
            self.tabBarController?.selectedIndex = 0
            jokeIndex = 0
        }
        
        if jokeViewController != nil &&
            jokeViewController?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            punchlineViewController?.view.frame = self.view.frame
            switchViewController(jokeViewController, to: punchlineViewController)
            
            if endOfJoke() && self.restorationIdentifier != "Knock Knock" {
                nextButton.setTitle("Home", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            jokeViewController.view.frame = view.frame
            switchViewController(punchlineViewController, to: jokeViewController)
            
            if !endOfJoke() && self.restorationIdentifier != "Knock Knock" {
                nextButton.setTitle("Punchline", for: .normal)
            } else if endOfJoke() && self.restorationIdentifier == "Knock Knock" {
                nextButton.setTitle("Home", for: .normal)
            }
    
            jokeIndex += 1
            selectJoke()
        }
        UIView.commitAnimations()
    }
    
    fileprivate func switchViewController(_ from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParent: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParent()
        }
        
        if to != nil {
            self.addChild(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParent: self)
        }
    }

    var jokeIndex: Int = 1
    var knockIndex: Int = 0
    func selectJoke() {
        if self.restorationIdentifier == "Knock Knock" {
            jokeBuilder(joke: knockKnock[knockIndex])
            if knockIndex + 1 < knockKnock.count {
                punchlineBuilder(punchline: knockKnock[knockIndex + 1])
            } else {
                knockIndex = -2
                punchlineBuilder(punchline: "")
            }
            knockIndex += 2
        } else {
            jokeBuilder(joke: jokesDict[self.restorationIdentifier!]![String(jokeIndex)]!["Joke"]!)
            punchlineBuilder(punchline: jokesDict[self.restorationIdentifier!]![String(jokeIndex)]!["Punchline"]!)
        }

    }
    
    func endOfJoke() -> Bool {
        if self.restorationIdentifier == "Knock Knock" {
            return knockIndex + 1 >= knockKnock.count
        } else {
            return jokeIndex == jokesDict[self.restorationIdentifier!]!.count
        }
    }

    fileprivate func jokeBuilder(joke: String) {
        if jokeViewController == nil {
            jokeViewController = (storyboard?.instantiateViewController(withIdentifier: "Joke") as! JokeViewController)
            jokeViewController.joke = joke
        } else {
            jokeViewController.jokeLabel.text = joke
        }
    }

    fileprivate func punchlineBuilder(punchline: String) {
        if punchlineViewController == nil {
            punchlineViewController = (storyboard?.instantiateViewController(withIdentifier: "Punchline") as! PunchlineViewController)
            punchlineViewController.punchline = punchline
        } else {
            punchlineViewController.punchlineLabel.text = punchline
        }
    }
}
