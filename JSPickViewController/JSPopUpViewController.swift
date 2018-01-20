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
        
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = true
        if mainViewHeight > self.view.frame.size.height-2*40 {
            mainViewHeight = self.view.frame.size.height-2*40
        }else{
            mainViewHeight = CGFloat(listData.count*40 + 60)
        }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        popupContentContainerView.backgroundColor = UIColor.white
        popupContentContainerView.layer.cornerRadius = 10
        view.addSubview(popupContentContainerView)
        
        caseListTableView = UITableView(frame: CGRect.zero, style: .plain)
        caseListTableView.separatorStyle = .none
        caseListTableView.delegate = self
        caseListTableView.dataSource = self
        caseListTableView.register(UITableViewCell.self, forCellReuseIdentifier: listCellIdentifier)
        popupContentContainerView.addSubview(caseListTableView)
        
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
        popupContentContainerView.translatesAutoresizingMaskIntoConstraints = false
        caseListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints:[NSLayoutConstraint] = [NSLayoutConstraint]()
        let leading = NSLayoutConstraint(item: popupContentContainerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 60.0)
        allConstraints.append(leading)
        let trailing = NSLayoutConstraint(item: popupContentContainerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -60.0)
        allConstraints.append(trailing)
        let centerX = NSLayoutConstraint(item: popupContentContainerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        allConstraints.append(centerX)
        let height = NSLayoutConstraint(item: popupContentContainerView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: mainViewHeight)
        allConstraints.append(height)
        popupContentContainerView.addConstraint(height)
        var tableConstraints:[NSLayoutConstraint] = [NSLayoutConstraint]()
        let tableTop = NSLayoutConstraint(item: caseListTableView, attribute: .top, relatedBy: .equal, toItem: popupContentContainerView, attribute: .top, multiplier: 1.0, constant: 40)
        tableConstraints.append(tableTop)
        let tableBottom = NSLayoutConstraint(item: caseListTableView, attribute: .bottom, relatedBy: .equal, toItem: popupContentContainerView, attribute: .bottom, multiplier: 1.0, constant: -40)
        tableConstraints.append(tableBottom)
        let tableWidth = NSLayoutConstraint(item: caseListTableView, attribute: .width, relatedBy: .equal, toItem: popupContentContainerView, attribute: .width, multiplier: 1.0, constant: 0)
        tableConstraints.append(tableWidth)
        let tableCenterX = NSLayoutConstraint(item: caseListTableView, attribute: .centerX, relatedBy: .equal, toItem: popupContentContainerView, attribute: .centerX, multiplier: 1.0, constant: 0)
        tableConstraints.append(tableCenterX)
        NSLayoutConstraint.activate(allConstraints)
        view.addConstraints(allConstraints)
        popupContentContainerView.addConstraints(tableConstraints)
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
        cell.backgroundColor = UIColor.gray
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
