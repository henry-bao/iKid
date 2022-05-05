//
//  JokeViewController.swift
//  ikid
//
//  Created by Henry Bao on 5/4/22.
//

import Foundation
import UIKit

class JokeViewController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    
    var joke: String = "lorem2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        jokeLabel.text = joke
    }
}
