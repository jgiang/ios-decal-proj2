//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UITextFieldDelegate {
    
    // undoes all guesses
    @IBOutlet var startOverButton: UIButton!
    // start over with new word
    @IBOutlet var newGameButton: UIButton!
    // connected to number of incorrect guesses
    @IBOutlet var stateImage: UIImageView!
    @IBOutlet var inputText: UITextField!
    @IBOutlet var guessButton: UIButton!
    // knownString from Hangman api
    @IBOutlet var revealedSecretPhrase: UILabel!
    // guessedLetters from Hangman api
    // going to show all guesses because you shouldn't be able to guess letters twice
    @IBOutlet var previousGuesses: UILabel!
    
    
    var game = Hangman()
    var numIncorrectGuesses = 0
    var gameInProgress = false
    var gameFinished = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.inputText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        guessButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        return false
    }
    
    @IBAction func startGame(sender: UIButton) {
        // tag of newGame button is 0
        if (sender.tag == 0) {
            game = Hangman()
            gameInProgress = true
            game.start()
            print(game.answer)
            numIncorrectGuesses = 0
            stateImage.image = UIImage(named:"basic-hangman-img/hangman\(numIncorrectGuesses+1).gif")
            
        // tag of startOver button is 1
        } else if (sender.tag == 1 && (gameInProgress || gameFinished)) {
            gameInProgress = true
            game.knownString = ""
            for (var i = 0; i < game.answer!.characters.count; i += 1) {
                if (game.answer! as NSString).substringWithRange(NSMakeRange(i, 1)) == " " {
                    game.knownString = game.knownString! + " "
                } else {
                    game.knownString = game.knownString! + "_"
                }
            }
            game.guessedLetters?.removeAllObjects()
            numIncorrectGuesses = 0
            stateImage.image = UIImage(named:"basic-hangman-img/hangman\(numIncorrectGuesses+1).gif")

        } else {
            let alertController = UIAlertController(title: "Nothing to Undo", message: "You have not started a game", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Gotcha", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        revealedSecretPhrase.text = game.knownString
        previousGuesses.text = ""
        gameFinished = false
    }
    
    @IBAction func makeGuess(sender: UIButton) {
        if (inputText.text! == "" || !gameInProgress) {
            return
        }
        var guess = inputText.text!.lowercaseString
        inputText.text = ""
        if (guess.characters.count == 1 && guess >= "a" && guess <= "z") {
            guess = guess.uppercaseString
            if game.guessLetter(guess) {
                revealedSecretPhrase.text = game.knownString
                previousGuesses.text = game.guesses()
                if (game.knownString == game.answer) {
                    gameInProgress = false
                    gameFinished = true
                    gameOver(true)
                }
            } else {
                numIncorrectGuesses++
                if (numIncorrectGuesses > 5) {
                    gameInProgress = false
                    gameFinished = true
                    gameOver(false)
                }
                stateImage.image = UIImage(named:"basic-hangman-img/hangman\(numIncorrectGuesses+1).gif")
                previousGuesses.text = game.guesses()
            }
        }
    }
    
    func gameOver(success: Bool) {
        var status: String
        var comment: String
        if success {
            status = "Congrats!"
            comment = "You won!"
        } else {
            status = "Bummer!"
            comment = "You lost :("
        }
        let alertController = UIAlertController(title: status, message:
            comment + " Press 'New Game' to play with a new phrase or 'Start Over' to play with the same phrase again", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Gotcha", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    }

