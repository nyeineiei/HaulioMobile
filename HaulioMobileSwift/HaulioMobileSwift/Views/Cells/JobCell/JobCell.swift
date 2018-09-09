//
//  JobCell.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import UIKit

protocol UITableViewCellDelegate: AnyObject{
    func tapBtnAccept(index:NSInteger)
    func tapBtnShowMap(index:NSInteger)
}


class JobCell: UITableViewCell {

    @IBOutlet weak var lblJobNo: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyAddress: UILabel!
    
    var index:NSInteger!
    
    weak var delegate: UITableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadFromNib() -> JobCell {
        let vw = Bundle.main.loadNibNamed("JobCell", owner: self, options: nil)?.first as? JobCell
        return vw!
    }
    
    func setData(data:Any,index:NSInteger) {
        let d = data as! Dictionary<String, Any>
        self.index = index
        
        let jobid:NSInteger = d["job-id"] as! NSInteger
        self.lblJobNo.text = String(jobid)
        self.lblCompanyName.text = d["company"] as? String
        self.lblCompanyAddress.text = d["address"] as? String
    }
    
    @IBAction func tapBtnAccept(_ sender: Any) {
        self.delegate?.tapBtnAccept(index: self.index)
    }
    
    @IBAction func tapBtnShowMap(_ sender: Any) {
        self.delegate?.tapBtnShowMap(index: self.index)
    }
    
}
