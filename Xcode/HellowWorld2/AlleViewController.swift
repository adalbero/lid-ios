//
//  AlleViewController.swift
//  HellowWorld2
//
//  Created by Mathias Bergmann Guimaraes on 07.06.22.
//

import UIKit

class AlleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countdownTimerLabel: UILabel!
    
    
    var timer:Timer = Timer()
    var count:Int = 3599
    var isCounting:Bool = false
    
    var allQuestions = [QuestionHolder]()
    //let names = ["henry", "Milke", "Sophie", "Toby"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.registerTableViewCell()
        
        title = "third screen"
        countdownTimerLabel.text = "59:59"
        startCountdownTimer()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func startCountdownTimer() -> Void {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimerCounter), userInfo: nil, repeats: true)
    }
    
    @objc func countdownTimerCounter() -> Void {
        var timeString = ""
        if count <= 0 {
            timeString = "TIME"
        }else{
            count = count - 1
            let time = secondsToMinutesSeconds(seconds: count)
            timeString = makeTimerString(minutes: time.0, seconds: time.1)
        }
        
        
        
        countdownTimerLabel.text = timeString
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int){
        
        return (((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimerString(minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    private func registerTableViewCell() {
        let themeLabel = UINib(nibName: "SecondTableViewCell", bundle: nil)
        
        self.tableView.register(themeLabel, forCellReuseIdentifier: "SecondTableViewCell")
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AlleViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("YOU TAPPED ME!")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension AlleViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuestions[0].getSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as? SecondTableViewCell {
            return cell
        }
        
        //cell.textLabel?.text = allQuestions[0].getQuestion(index: indexPath.row).question
        
        return UITableViewCell()

    }
}
