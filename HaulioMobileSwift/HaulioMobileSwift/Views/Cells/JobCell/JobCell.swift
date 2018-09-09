//
//  JobCell.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var lblJobNo: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyAddress: UILabel!
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
    
    func setData(data:Any) {
        print(data)
        let d = data as! Dictionary<String, Any>
        
        self.lblJobNo.text = d["job-id"] as? String
        self.lblCompanyName.text = d["company"] as? String
        self.lblCompanyAddress.text = d["address"] as? String
    }
    
    @IBOutlet weak var tapBtnAccept: UIButton!
}
