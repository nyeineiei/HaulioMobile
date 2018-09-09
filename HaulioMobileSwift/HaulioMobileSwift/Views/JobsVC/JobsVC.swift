//
//  JobsVC.swift
//  HaulioMobileSwift
//
//  Created by Nyein Ei on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import UIKit

class JobsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITableViewCellDelegate{
    
    
    var arr:NSArray!
    @IBOutlet weak var tblJobs: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .setupData()
        self.setupNavigationBar()
        self.setupRightBarButtonItem()
    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .init(red: 235/255, green: 33/255, blue: 46/255, alpha: 1.0)
        let vwimg = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        vwimg.image = UIImage(named: "img_logo")
        self.navigationItem.titleView = vwimg;
    }
    
    func setupRightBarButtonItem() {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
        btn.setImage(UIImage (named: "ic_logout.png"), for: .normal)
        btn.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 25.0)
        let barButtonItem = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = barButtonItem
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
        cell.setData(data: self.arr[indexPath.row],index: indexPath.row)
        cell.delegate = self
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130
    }

    func tapBtnAccept(index:NSInteger){
        //Push userProfileVC
        let userProfileVC = UserProfileVC(nibName: "UserProfileVC", bundle: nil)
        userProfileVC.setData(data: self.arr[index])
        self.navigationController!.pushViewController(userProfileVC, animated: true)
    }
    
    func tapBtnShowMap(index:NSInteger){
        //Push mapVC
        let mapVC = MapVC(nibName: "MapVC", bundle: nil)
        mapVC.setData(data: self.arr[index])
        self.navigationController!.pushViewController(mapVC, animated: true)
    }
    
    @objc func logout() {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("UserLoggedOut"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
