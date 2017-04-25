//
//  LoginView.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        self.loadDateAndTime()
        // adding comment
    }
    
    func loadDateAndTime() {
        let today = Date()
        let d_format = DateFormatter()
        d_format.dateFormat = "dd/MM/yyyy"
        dateLabel.text = d_format.string(from: today)
        
        timeLabel.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.none
            , timeStyle: DateFormatter.Style.short)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        codeTextField.text = nil
        
        if codeTextField.text == nil {
            loginButton.isEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDateAndTime()
    }

}
