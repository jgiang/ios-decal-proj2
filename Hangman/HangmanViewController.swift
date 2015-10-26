//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet var startOverButton: UIButton!
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet var stateImage: UIImageView!
    @IBOutlet var inputText: UITextField!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet var incorrectGuesses: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

