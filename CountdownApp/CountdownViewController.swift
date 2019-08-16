//
//  CountdownViewController.swift
//  CountdownApp
//
//  Created by Hameed Abdullah on 8/5/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
 
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedDate = CountdownDate.loadDates() {
            countdownDates = savedDate
        }
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countdownDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatesCell", for: indexPath) as! CountdownTableViewCell
        let countdownDate = countdownDates[indexPath.row]
        cell.updateUI(with: countdownDate)
       cell.showsReorderControl = true
        return cell
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            countdownDates.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
     func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedDate = countdownDates.remove(at: fromIndexPath.row)
        countdownDates.insert(movedDate, at: to.row)
        tableView.reloadData()
    }

}

