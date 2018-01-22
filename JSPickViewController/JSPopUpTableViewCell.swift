//
//  JSPopUpTableViewCell.swift
//  JSPickViewController
//
//  Created by joseewu on 2018/1/20.
//  Copyright © 2018年 com.Nietzsche. All rights reserved.
//

import UIKit

class JSPopUpTableViewCell: UITableViewCell {
    var titlelabel:UILabel = UILabel()
    private let separateLine:UIView = UIView()
    private let checkedBut:UIButton = UIButton()
    private let uncheckedBut:UIButton = UIButton()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        renderUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titlelabel.text = ""
    }
    func renderUi(){
        selectionStyle = .none
        titlelabel.text = ""
        titlelabel.textColor = UIColor.black
        titlelabel.font = UIFont(name: "PingFangSC-Regular", size: 18)
        titlelabel.textAlignment = .left
        addSubview(titlelabel)
        
        separateLine.backgroundColor = UIColor.darkGray
        addSubview(separateLine)
        
        uncheckedBut.setImage(UIImage(named: "unchecked"), for: .normal)
        uncheckedBut.contentMode = .scaleAspectFill
        uncheckedBut.clipsToBounds = true
        addSubview(uncheckedBut)
        
        checkedBut.setImage(UIImage(named: "checked"), for: .normal)
        checkedBut.contentMode = .scaleAspectFill
        checkedBut.clipsToBounds = true
        addSubview(checkedBut)
        
        setConstraints()
    }
    func setConstraints(){
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        separateLine.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints:[NSLayoutConstraint] = [NSLayoutConstraint]()
        let leading = NSLayoutConstraint(item: titlelabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
        allConstraints.append(leading)
        let trailing = NSLayoutConstraint(item: titlelabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -60.0)
        allConstraints.append(trailing)
        let top = NSLayoutConstraint(item: titlelabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        allConstraints.append(top)
        let bottom = NSLayoutConstraint(item: titlelabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        allConstraints.append(bottom)
        
        let separateBottom = NSLayoutConstraint(item: separateLine, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        allConstraints.append(separateBottom)
        let separateLeading = NSLayoutConstraint(item: separateLine, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        allConstraints.append(separateLeading)
        let separateTrailing = NSLayoutConstraint(item: separateLine, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        allConstraints.append(separateTrailing)
        let separateHeight = NSLayoutConstraint(item: separateLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.5)
        allConstraints.append(separateHeight)
        
        NSLayoutConstraint.activate(allConstraints)
        addConstraints(allConstraints)
    }
}
