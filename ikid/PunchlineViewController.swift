//
//  PunchlineViewController.swift
//  ikid
//
//  Created by Henry Bao on 5/4/22.
//

import Foundation
import UIKit

class PunchlineViewController: UIViewController {

    @IBOutlet weak var punchlineLabel: UILabel!
    
    var punchline: String = "lorem1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        punchlineLabel.text = punchline
    }
    
}
