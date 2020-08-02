//
//  JobTableViewCell.swift
//  HprDriver
//
//  Created by Rapidzz Macbook on 06/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

protocol JobCellDelegate: NSObjectProtocol {
    func actionCallBackArrived(params: ParamsAny, _ index: Int)
    func actionCallBackReject(params: ParamsAny, _ index: Int)
}
extension UIView {
       func flash(numberOfFlashes: Float) {
          let flash = CABasicAnimation(keyPath: "opacity")
          flash.duration = 0.2
          flash.fromValue = 1
          flash.toValue = 0.1
          flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
          flash.autoreverses = true
          flash.repeatCount = numberOfFlashes
          layer.add(flash, forKey: nil)
      }
}
class JobTableViewCell: UITableViewCell {

    @IBOutlet weak var lblJobName: UILabel?
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblTime: UILabel?
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblPhone: UILabel?
    @IBOutlet weak var lblFlight: UILabel?
    @IBOutlet weak var lblPeopleCount: UILabel?
    @IBOutlet weak var lblBagsCount: UILabel?
    @IBOutlet weak var btnArrived: UIButton?
    @IBOutlet weak var btnReject: UIButton?
    @IBOutlet weak var btnPOB: UIButton?
    @IBOutlet weak var viewBackground: UIView?
    @IBOutlet weak var constraintTop: NSLayoutConstraint?
    @IBOutlet weak var constraintLeading: NSLayoutConstraint?
    @IBOutlet weak var constraintTrailing: NSLayoutConstraint?
    
    
    var delegate: JobCellDelegate?
    var bookingVM:BookingViewModel?
    var index: Int? = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.btnArrived?.dropShadow(radius: 5, opacity: 0.5)
        self.btnReject?.dropShadow(radius: 5, opacity: 0.5)
        self.btnPOB?.dropShadow(radius: 5, opacity: 0.5)
        
        if(DeviceType.IS_IPAD){
            self.btnPOB?.layer.cornerRadius = 30
            self.btnArrived?.layer.cornerRadius = 30
            self.btnReject?.layer.cornerRadius = 30
            self.lblBagsCount?.layer.cornerRadius = 15
            self.lblPeopleCount?.layer.cornerRadius = 15
        }
        
        
    }
    
    func configureView(booking: BookingViewModel, _ index: Int)  {
        self.index = index
        self.bookingVM = booking
        self.lblJobName?.text = booking.bookingTerminal
        self.lblName?.text = booking.loginName
        self.lblPhone?.text = booking.loginMobile
        self.lblPeopleCount?.text = booking.noOfPeople
        self.lblBagsCount?.text = booking.noOfBags
        self.lblFlight?.text = "Flight: " + booking.flight
        self.lblDate?.text = "Date:\(Utilities.getDatefromDateString(strDate: booking.bookingDatestamp))"
        self.lblTime?.text = "Time:\(Utilities.getTimeFromDateString(strDate: booking.bookingDatestamp))"
        
        self.btnPOB?.isHidden = true
        if(booking.bookingType == .Departure){
            self.viewBackground?.backgroundColor = ApplicationColor.LightGray
        }else{
            self.viewBackground?.backgroundColor = ApplicationColor.LightBlue
        }
        
        if(booking.bookingStatus == .Assigned){
            self.btnPOB?.isHidden = true
            self.btnReject?.isHidden = false
            self.btnArrived?.isHidden = false
            self.btnArrived?.setTitle("Arrived", for: .normal)
        }else if(booking.bookingStatus == .Arrived){
            self.btnPOB?.isHidden = false
            self.btnReject?.isHidden = true
            self.btnArrived?.isHidden = true
            self.btnPOB?.setTitle("POB", for: .normal)
        }else if(booking.bookingStatus == .POB){
            self.btnPOB?.isHidden = false
            self.btnReject?.isHidden = true
            self.btnArrived?.isHidden = true
            self.btnPOB?.setTitle("Mark as completed", for: .normal)
        }
        
        if(booking.isNewBooking){

            self.viewBackground?.layer.borderWidth = 10
            
            if(booking.bookingType == .Departure){
                self.viewBackground?.layer.borderColor = ApplicationColor.DarkBlue.cgColor
            }else{
                self.viewBackground?.layer.borderColor = ApplicationColor.Gray.cgColor
            }
           
        }else{
            self.viewBackground?.layer.borderWidth = 0
            self.viewBackground?.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBAction func actionArrived(_ sender: UIButton){
        var status = ""
        if(self.bookingVM!.bookingStatus == .Assigned){
            status = BookingStatus.Arrived.rawValue
        }else if(self.bookingVM!.bookingStatus == .Arrived){
            status = BookingStatus.POB.rawValue
        }else if(self.bookingVM!.bookingStatus == .POB){
            status = BookingStatus.Completed.rawValue
        }
        let params = self.getStatusParams(status: status)
        self.delegate?.actionCallBackArrived(params: params, self.index!)
    }
    
    @IBAction func actionReject(_ sender: UIButton){
        let params = self.getStatusParams(status: "reject")
        
        self.delegate?.actionCallBackReject(params: params, self.index!)
    }
    
    func getStatusParams(status: String) -> ParamsAny {
        let params: ParamsAny = [DictKeys.apiUrl: "",
       //pro DictKeys.session: Global.shared.user!.sessionId,
        DictKeys.bookingType: self.bookingVM!.bookingType.rawValue,
        DictKeys.bookingRef: self.bookingVM!.bookingRef,
        DictKeys.status: status]
        
        return params
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
