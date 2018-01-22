//
//  ViewController.swift
//  JSPickViewController
//
//  Created by joseewu on 2018/1/19.
//  Copyright © 2018年 com.Nietzsche. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var showMenuButton:UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        showMenuButton.frame = CGRect(x: view.frame.size.width/2 - 90, y: view.frame.size.height/2 - 45, width: 180, height: 90)
        showMenuButton.backgroundColor = UIColor.black
        showMenuButton.setTitleColor(UIColor.white, for: .normal)
        showMenuButton.setTitle("show menu", for: .normal)
        showMenuButton.addTarget(self, action: #selector(ViewController.didTapShowMenu(sender:)), for: .touchUpInside)
        view.addSubview(showMenuButton)
        
    }
    @objc func didTapShowMenu(sender:UIButton){
        let popoutMenu = JSPopUpViewController(data: ["test","test2","test3"])
        popoutMenu.modalPresentationStyle = .overCurrentContext
        present(popoutMenu, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

