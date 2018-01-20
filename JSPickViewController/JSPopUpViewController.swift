//
//  JSPopUpViewController.swift
//  JSPickViewController
//
//  Created by joseewu on 2018/1/20.
//  Copyright © 2018年 com.Nietzsche. All rights reserved.
//

import UIKit

class JSPopUpViewController: UIViewController {
    
    var popupContentContainerView: UIView = UIView()
    var cancelButton:UIButton = UIButton()
    var titleLabel:UILabel = UILabel()
    var caseListTableView:UITableView = UITableView()
    var listData:[String] = [String]()
    let listCellIdentifier:String = "listCellIdentifier"
    var mainViewHeight:CGFloat = 10 {
        didSet{
            caseListTableView.reloadData()
        }
    }
    var clickListCallback:((_ index:Int)->Void)?
    
    convenience public init(data:[String]){
        self.init()
        listData = data
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUi()
        // Do any additional setup after loading the view.
    }
    func renderUi(){
        
        self.view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
//        if mainViewHeight > self.view.frame.size.height-2*Constants.adjustLength(byRatio: 40) {
//            mainViewHeight = self.view.frame.size.height-2*Constants.adjustLength(byRatio: 40)
//        }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        popupContentContainerView.backgroundColor = UIColor.red
        popupContentContainerView.layer.cornerRadius = 10
        view.addSubview(popupContentContainerView)
        
        caseListTableView.separatorStyle = .none
        caseListTableView = UITableView(frame: CGRect.zero, style: .plain)
        caseListTableView.delegate = self
        caseListTableView.dataSource = self
        caseListTableView.register(UITableViewCell.self, forCellReuseIdentifier: listCellIdentifier)
        caseListTableView.tableHeaderView = nil
        caseListTableView.tableFooterView = nil
        view.addSubview(caseListTableView)
        
        titleLabel.text = "選擇案件"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "", size: 10)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        view.addSubview(titleLabel)
        
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.blue, for: .normal)
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.titleLabel?.font = UIFont(name: "", size: 10)
        cancelButton.addTarget(self, action: #selector(JSPopUpViewController.cancelInvitation(sender:)), for: .touchUpInside)
        view.addSubview(cancelButton)
        setConstraints()
    }
    func setConstraints(){
        let views:[String: Any] = ["popupContentContainerView": popupContentContainerView,
                                   "caseListTableView":caseListTableView]
        var allConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
        let descHorizontal = "H:|-40-[popupContentContainerView]-40-|"
        let descVertical = "V:|-100-[popupContentContainerView]-100-|"
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat:
            descHorizontal,options: NSLayoutFormatOptions(rawValue: 0),metrics: nil,views: views)
        allConstraints += horizontalConstraints
        let verticleConstraints = NSLayoutConstraint.constraints(withVisualFormat:
            descVertical,options: NSLayoutFormatOptions(rawValue: 0),metrics: nil,views: views)
        allConstraints += verticleConstraints
        
//        let tableHorizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat:
//            "H:[popupContentContainerView]-[caseListTableView]-[popupContentContainerView]",options: NSLayoutFormatOptions(rawValue: 0),metrics: nil,views: views)
//        allConstraints += tableHorizontalConstraint
//        let tableVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat:
//            "V:[popupContentContainerView]-[caseListTableView]-[popupContentContainerView]",options: NSLayoutFormatOptions(rawValue: 0),metrics: nil,views: views)
//         allConstraints += tableVerticalConstraint
        
        NSLayoutConstraint.activate(allConstraints)
    }
    @objc func cancelInvitation(sender:UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension JSPopUpViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
