//
//  CountdownTableViewCell.swift
//  CountdownApp
//
//  Created by Hameed Abdullah on 8/11/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class CountdownTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    
    let currentDate: Date = Date()
    let dateFormatter: DateFormatter = DateFormatter()
    
    var timer: Timer = Timer()
    let calendar: Calendar = Calendar.current
    let requestedComponent: Set<Calendar.Component> = [.weekOfMonth, .day, .hour, .minute, .second]
    var endTime: Date?
    
    func updateUI(with coundown: CountdownDate) {
        
        titleLabel.text = coundown.title
        
         let dateFormatter: DateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MMMM d yyyy, hh:mm a"
        
        countdownLabel.text = dateFormatter.string(from: coundown.endCountdownDate)
        
        let endDateInString = dateFormatter.string(from: coundown.endCountdownDate)
        
        guard let date = dateFormatter.date(from: endDateInString) else {
            fatalError()
        }
        
        //endTime = dateFormatter.date(from: "23/04/20 12:00:00 a")
        endTime = date
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        timer.fire()
        
    }
    
    @objc func printTime() {
        let currentTime: Date = Date()
        
        if endTime! < currentTime {
            timer.invalidate()
            countdownLabel.text = "Countdown is over"
        }
        
        
        let timeDifference: DateComponents = calendar.dateComponents(requestedComponent, from: currentTime, to: endTime!)
        print("timeDifference = \(timeDifference)")
        
        //let totalOfWeeks: Int = timeDifference.weekOfMonth!
        let totalOfDays: Int = timeDifference.day! + timeDifference.weekOfMonth! * 7
        let totalOfHours: Int = timeDifference.hour! + totalOfDays * 24
        let totalOfMinutes = timeDifference.minute! + totalOfHours * 60
        let totalOfseconds = timeDifference.second! + totalOfMinutes * 60
        
//        daysLabel.text = "\(totalOfDays)"
//        hoursLabel.text = "\(totalOfHours)"
//        minutesLabel.text = "\(totalOfMinutes)"
//        secondsLabel.text = "\(totalOfseconds)"
        
       // countdownLabel.text = "\(timeDifference)"
        
        daysLabel.text = "\(totalOfDays)"
        hoursLabel.text = "\(timeDifference.hour!)"
        minutesLabel.text = "\(timeDifference.minute!)"
        secondsLabel.text = "\(timeDifference.second!)"
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
