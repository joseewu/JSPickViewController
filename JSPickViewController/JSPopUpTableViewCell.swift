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
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        renderUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func renderUi(){
        titlelabel.text = ""
        titlelabel.textColor = UIColor.black
        titlelabel.font = UIFont(name: "PingFangSC-Regular", size: 18)
        setConstraints()
    }
    func setConstraints(){
        
    }
}
