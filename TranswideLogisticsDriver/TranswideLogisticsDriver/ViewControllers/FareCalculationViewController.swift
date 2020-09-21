//
//  FareCalculationViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 8/15/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

protocol FareCalculationViewControllerDelegate : class{
    func close()
}

class FareCalculationViewController: UIViewController {

    @IBOutlet weak var lblFre: UILabel!
    @IBOutlet weak var lblTotalTime: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    var distance : Double = 0.0
    var time : Int = 0
    weak var delegate : FareCalculationViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

        // Do any additional setup after loading the view.
    }
    
    func configureView(){
        self.lblDistance.text = "\(self.distance)"
        self.lblTotalTime.text = "\(self.time)"
        
        let fare = Int(self.distance * 70) + (self.time * 35) + 500
        self.lblFre.text  = "\(fare)"
    }
    
    @IBAction func actionDone(_ sender: Any) {
        if let del = self.delegate{
            del.close()
            self.dismiss(animated: true, completion: nil)
        }
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
