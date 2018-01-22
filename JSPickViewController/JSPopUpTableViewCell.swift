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
    var checkButton:((_ checkedIndex:Int)->Void)?
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
    private func renderUi(){
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
        uncheckedBut.addTarget(self, action: #selector(JSPopUpTableViewCell.didTapCheckBox(sender:)), for: .touchUpInside)
        uncheckedBut.clipsToBounds = true
        addSubview(uncheckedBut)
        
        checkedBut.setImage(UIImage(named: "checked"), for: .normal)
        checkedBut.contentMode = .scaleAspectFill
        checkedBut.clipsToBounds = true
        checkedBut.addTarget(self, action: #selector(JSPopUpTableViewCell.didTapCheckBox(sender:)), for: .touchUpInside)
        addSubview(checkedBut)
        
        setConstraints()
    }
    @objc private func didTapCheckBox(sender:UIButton){
        if sender == checkedBut {
            checkedBut.isHidden = true
            uncheckedBut.isHidden = false
        }else{
            checkedBut.isHidden = false
            uncheckedBut.isHidden = true
            checkButton?(self.tag)
        }
    }
    public func tapCheckBtn(isCheck:Bool){
        checkedBut.isHidden = !isCheck
        uncheckedBut.isHidden = isCheck
    }
    private func setConstraints(){
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        separateLine.translatesAutoresizingMaskIntoConstraints = false
        uncheckedBut.translatesAutoresizingMaskIntoConstraints = false
        checkedBut.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        let uncheckedTrailing = NSLayoutConstraint(item: uncheckedBut, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
        allConstraints.append(uncheckedTrailing)
        let uncheckedCenterY = NSLayoutConstraint(item: uncheckedBut, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        allConstraints.append(uncheckedCenterY)
        let uncheckedWidth = NSLayoutConstraint(item: uncheckedBut, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        allConstraints.append(uncheckedWidth)
        let uncheckedHeight = NSLayoutConstraint(item: uncheckedBut, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        allConstraints.append(uncheckedHeight)
        
        let checkedTrailing = NSLayoutConstraint(item: checkedBut, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
        allConstraints.append(checkedTrailing)
        let checkedCenterY = NSLayoutConstraint(item: checkedBut, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        allConstraints.append(checkedCenterY)
        let checkedWidth = NSLayoutConstraint(item: checkedBut, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        allConstraints.append(checkedWidth)
        let checkedHeight = NSLayoutConstraint(item: checkedBut, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        allConstraints.append(checkedHeight)
        
        NSLayoutConstraint.activate(allConstraints)
        addConstraints(allConstraints)
    }
}
