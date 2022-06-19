//
//  ViewController.swift
//  HellowWorld2
//
//  Created by Mathias Bergmann Guimaraes on 06.06.22.
//
import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "main Screen"
        // Do any additional setup after loading the view.
        
       

    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        //toggle
        if myLabel.text == "this is a test"{
            myLabel.text = "Hello World"
        }else{
            myLabel.text = "this is a test"
        }
    }
    
    
    
}
