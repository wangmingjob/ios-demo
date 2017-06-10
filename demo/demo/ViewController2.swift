//
//  ViewController2.swift
//  demo
//
//  Created by wangming on 6/10/17.
//  Copyright © 2017 itormcity. All rights reserved.
//

import Foundation
import UIKit

class ViewController2: UIViewController {
    open var title2: String?
    
    lazy var contentLabel: UILabel = {
        let resultView = UILabel()
        resultView.backgroundColor = UIColor.green
        resultView.text = "content"
        resultView.font = UIFont.systemFont(ofSize: 10.0)
        resultView.textAlignment = NSTextAlignment.center
        return resultView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController2 {
    func initView() {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints{ (make) -> Void in
            make.center.equalTo(self.view)
            make.width.height.equalTo(100)
        }
        
        self.contentLabel.text = self.title2
        
        self.contentLabel.isUserInteractionEnabled = true
        self.contentLabel.tag = 100
        self.contentLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ViewController2.clickContent(sender:))))
    }
    
    func initData() {
        
    }
}

extension ViewController2 {
    func clickContent(sender: UITapGestureRecognizer) {
        let content: Int = (sender.view?.tag)!
        print("click content \(content)")
        
        dismiss(animated: true, completion: {
            print("closed")
        })
    }
}
