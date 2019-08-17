//
//  AddCountdownTableViewController.swift
//  CountdownApp
//
//  Created by Hameed Abdullah on 8/5/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit
import CoreData

var countdownDates: [CountdownDate] = [CountdownDate]() {
    didSet {
        CountdownDate.saveToFile(countdownDates: countdownDates)
    }
}


class AddCountdownTableViewController: UITableViewController {
    
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var endingDate: UIDatePicker!
    
    let currentDate: Date = Date()
    let dateFormatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDateString()
        titleTextFieldLayout()
        
       // endingDate.backgroundColor = UIColor.blue
        endingDate.setValue(UIColor.orange, forKey: "textColor")
        endingDate.setValue(0.8, forKey: "alpha")
    
        
    }
    
    
    func currentDateString() {
        dateFormatter.dateFormat = "MMMM d yyyy, hh:mm a"
        print(dateFormatter.string(from: currentDate))
        currentDateLabel.text = dateFormatter.string(from: currentDate)
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    
        if titleTextField.text != "" {
            
            dateFormatter.dateFormat = "MMMM d yyyy, hh:mm a"
            endingDate.minimumDate = currentDate.addingTimeInterval(3600)
            
            let newCountdown = CountdownDate(title: titleTextField.text!, startCountdownDate: currentDate, endCountdownDate: endingDate.date)
            
            print(newCountdown.title)
            print(newCountdown.startCountdownDate)
            print(newCountdown.endCountdownDate)
            
            countdownDates.insert(newCountdown, at: 0)
            dismiss(animated: true, completion: nil)
        } else {
    
            print("title is empty")
        }
            
        

    }
    
    
    //for debugging
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !countdownDates.isEmpty {
            
            print(countdownDates.count)
        }
    }
    
    
    func titleTextFieldLayout() {
        titleContainerView.layer.borderWidth = 1
        titleContainerView.layer.borderColor = UIColor(displayP3Red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        titleContainerView.layer.cornerRadius = 3
        titleContainerView.clipsToBounds = true
        titleTextField.borderStyle = .none
        
        let placeholderAttr = NSAttributedString(string: "Countdown Title", attributes: [NSAttributedString.Key.foregroundColor : UIColor(displayP3Red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        titleTextField.attributedPlaceholder = placeholderAttr
        //titleTextField.textColor = UIColor(displayP3Red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        titleTextField.textColor = UIColor.orange
    }
    
    

}
