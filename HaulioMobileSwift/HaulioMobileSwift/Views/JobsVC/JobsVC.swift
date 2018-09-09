//
//  JobsVC.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import UIKit

class JobsVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    var arr:NSArray!
    @IBOutlet weak var tblJobs: UITableView!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = false
        super.viewDidLoad()
        self .setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupData() {
        NetworkHelper.shared.requestJobList { (result: Any) in
            self.arr = result as! NSArray;
            
            if(self.arr.count != 0){
                self.setupTableView()
                self.tblJobs.reloadData()
            }
        }
    }
    
    func setupTableView() {
        self.tblJobs.delegate = self
        self.tblJobs.dataSource = self
        self.tblJobs.register(UINib(nibName: "JobCell", bundle: nil), forCellReuseIdentifier: "JobCell")
    }


    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:JobCell = self.tblJobs.dequeueReusableCell(withIdentifier: "JobCell") as! JobCell
        cell.setData(data: self.arr[indexPath.row])
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130
    }

}
