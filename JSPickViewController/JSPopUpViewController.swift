//
//  JSPopUpViewController.swift
//  JSPickViewController
//
//  Created by joseewu on 2018/1/20.
//  Copyright © 2018年 com.Nietzsche. All rights reserved.
//

import UIKit

class JSPopUpViewController: UIViewController {
    
    private var popupContentContainerView: UIView = UIView()
    private var cancelButton:UIButton = UIButton()
    private var titleLabel:UILabel = UILabel()
    private var caseListTableView:UITableView = UITableView()
    private var listData:[String] = [String]()
    private let listCellIdentifier:String = "listCellIdentifier"
    private var mainViewHeight:CGFloat = 10 {
        didSet{
            caseListTableView.reloadData()
        }
    }
    public var clickListCallback:((_ index:Int)->Void)?
    public var titleText:String?{
        didSet{
            titleLabel.text = titleText
        }
    }
    public var titleColor:UIColor?{
        didSet{
            titleLabel.textColor = titleColor
        }
    }
    public var cancelColor:UIColor?{
        didSet{
            cancelButton.setTitleColor(cancelColor, for: .normal)
        }
    }
    public var cancelText:String?{
        didSet{
            cancelButton.setTitle(cancelText, for: .normal)
        }
    }
    
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
        mainViewHeight = CGFloat(listData.count*50 + 60)
        
        if mainViewHeight > self.view.frame.size.height-2*40 {
            mainViewHeight = self.view.frame.size.height-2*40
        }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        popupContentContainerView.backgroundColor = UIColor.white
        popupContentContainerView.layer.cornerRadius = 6
        view.addSubview(popupContentContainerView)
        
        caseListTableView = UITableView(frame: CGRect.zero, style: .plain)
        caseListTableView.separatorStyle = .none
        caseListTableView.delegate = self
        caseListTableView.dataSource = self
        caseListTableView.register(JSPopUpTableViewCell.self, forCellReuseIdentifier: listCellIdentifier)
        popupContentContainerView.addSubview(caseListTableView)
        
        titleLabel.text = titleText ?? "選擇案件"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 16)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        popupContentContainerView.addSubview(titleLabel)
        
        cancelButton.setTitle(cancelText ?? "取消", for: .normal)
        cancelButton.setTitleColor(UIColor.blue, for: .normal)
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 16)
        cancelButton.addTarget(self, action: #selector(JSPopUpViewController.cancelInvitation(sender:)), for: .touchUpInside)
        popupContentContainerView.addSubview(cancelButton)
        setConstraints()
    }
    func setConstraints(){
        popupContentContainerView.translatesAutoresizingMaskIntoConstraints = false
        caseListTableView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        let titleLabelLeading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: popupContentContainerView, attribute: .leading, multiplier: 1.0, constant: 0)
        tableConstraints.append(titleLabelLeading)
        let titleLabelTop = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: popupContentContainerView, attribute: .top, multiplier: 1.0, constant: 5)
        tableConstraints.append(titleLabelTop)
        let titleWidth = NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
        allConstraints.append(titleWidth)
        
        let titleHeight = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        allConstraints.append(titleHeight)
        
        let cancelTrailing = NSLayoutConstraint(item: cancelButton, attribute: .trailing, relatedBy: .equal, toItem: popupContentContainerView, attribute: .trailing, multiplier: 1.0, constant: -20)
        tableConstraints.append(cancelTrailing)
        let cancelTop = NSLayoutConstraint(item: cancelButton, attribute: .bottom, relatedBy: .equal, toItem: popupContentContainerView, attribute: .bottom, multiplier: 1.0, constant: -10)
        tableConstraints.append(cancelTop)
        let cancelWidth = NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
        allConstraints.append(cancelWidth)
        
        let cancelHeight = NSLayoutConstraint(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        allConstraints.append(cancelHeight)
        
        NSLayoutConstraint.activate(allConstraints)
        view.addConstraints(allConstraints)
        popupContentContainerView.addConstraints(tableConstraints)
    }
    @objc func cancelInvitation(sender:UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    func dismissList(){
        self.dismiss(animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension JSPopUpViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as? JSPopUpTableViewCell
        cell?.titlelabel.text = listData[indexPath.row]
        cell?.tag = indexPath.row
        cell?.tapCheckBtn(isCheck: false)
        cell?.checkButton = {[weak self](index) in
            self?.clickListCallback?(index)
            
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
