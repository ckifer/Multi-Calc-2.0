//
//  AddAthleteController.swift
//  Multi Calc 2.0
//
//  Created by Jerrod on 3/21/18.
//  Copyright © 2018 Jerrod Sunderland. All rights reserved.
//

import UIKit

class AddAthleteController: UIViewController, UITextFieldDelegate {
    @IBOutlet var athleteName: UITextField!
    
    let userSettings = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide keyboard and change title
        self.hideKeyboardWhenTappedAround()
        self.athleteName.delegate = self
        if let tabController = self.parent as? UITabBarController {
            tabController.navigationItem.title = "Add Athlete"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard and change title
        self.hideKeyboardWhenTappedAround()
        self.athleteName.delegate = self
        if let tabController = self.parent as? UITabBarController {
            tabController.navigationItem.title = "Add Athlete"
        }
    }
    // hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func addAthletePressed(_ sender: Any) {
        if athleteName.text != "" {
            // add values to athlete array and set textfield to ""
            let name = athleteName.text!
            let athlete: Athlete = Athlete(id: GlobalVariable.athletesArray.count, name: name, events: [Event]())
            GlobalVariable.athletesArray.append(athlete)
            userSettings.set(GlobalVariable.athletesArray.count - 1, forKey: "totAthletes")
            for i in 0...GlobalVariable.athletesArray.count - 1 {
                GlobalVariable.athletesArray[i].saveAthlete()
            }
            //athlete.saveAthlete()
            athleteName.text = ""
        }else {
            alert(message: "Make sure name is given!")
        }
    }
    // alert function
    func alert(message: String, title: String = "Error") {
        //calls alert controller with tital and message
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //creates and adds ok button
        let OKAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
        alertController.addAction(OKAction)
        //shows
        self.present(alertController, animated: true, completion: nil)
    }
}
