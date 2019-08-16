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

// let scoreObj = Score(score: score, level: levelupScore, category: "Smileys & People", timestamp: Date())

//scores.append(scoreObj)

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
            //86400    24 hours
            //43200    12 hours
            endingDate.minimumDate = currentDate.addingTimeInterval(3600)
            //print(endCountDown)
            print(endingDate.minimumDate)
            
            
            
            let newCountdown = CountdownDate(title: titleTextField.text!, startCountdownDate: currentDate, endCountdownDate: endingDate.date)
            
            print(newCountdown.title)
            print(newCountdown.startCountdownDate)
            print(newCountdown.endCountdownDate)
            
           // countdownDates.append(newCountdown)
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
        titleTextField.textColor = UIColor(displayP3Red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
