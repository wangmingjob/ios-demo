//
//  ViewController.swift
//  demo
//
//  Created by wangming on 6/10/17.
//  Copyright © 2017 itormcity. All rights reserved.
//

import UIKit
import SnapKit
import PopupDialog

class ViewController: UIViewController {
    let cellIdentifier: String = "Cell"
    var sectionList: [String] = ["北京", "上海", "广州", "山东"]
    var dataList: [[String]]?
    lazy var contentLabel: UILabel = {
        let resultView = UILabel()
        resultView.backgroundColor = UIColor.green
        resultView.text = "content"
        resultView.font = UIFont.systemFont(ofSize: 10.0)
        resultView.textAlignment = NSTextAlignment.center
        return resultView
    }()
    
    
    lazy var tableView: UITableView = {
        let resultView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        resultView.dataSource = self
        resultView.delegate = self
        return resultView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

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

extension ViewController {
    
    func initView() {
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orange
        
        
        self.view.addSubview(contentLabel)
        self.contentLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(50)
            make.width.height.equalTo(100)
        }
        
                self.contentLabel.isUserInteractionEnabled = true
        self.contentLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ViewController.contentClick(sender:))))
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.width.equalTo(self.view)
            make.height.equalTo(500)
        }
        
    }
    
    func initData() {
        print("log")
        
        dataList = [
            ["a", "b","c"],
            ["d", "f","g", "h"],
            ["d", "b","c", "f", "g"],
            ["d", "b","c", "f", "g"]
        ]

        tableView.reloadData()
    }
    
    func contentClick(sender: UITapGestureRecognizer) {
        print("click content")
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the popup dialog default view"
        let image = UIImage(named: "pexels-photo-103290")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        // Create buttons
        let buttonOne = CancelButton(title: "present") {
            print("You canceled the car dialog.")
            
            let viewController: ViewController2 = ViewController2()
            viewController.title2 = "title2"
            self.present(viewController, animated: true, completion: nil)
        }
        
        let buttonTwo = DefaultButton(title: "pushViewController") {
            print("What a beauty!")
            
            let viewController: ViewController3 = ViewController3()
            viewController.title3 = "title3"
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        let buttonThree = DefaultButton(title: "BUT", height: 60) {
            print("Ah, maybe next time :)")
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataList![section].count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionList.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let content: UIView = UIView()
        let sectionValue: String = self.sectionList[section]
        let header: UILabel = UILabel()
        header.text = sectionValue
        header.font = UIFont.boldSystemFont(ofSize: 10.0)
        header.textAlignment = NSTextAlignment.center
        header.backgroundColor = UIColor.red
        header.textColor = UIColor.white
        header.layer.cornerRadius = 5
        header.clipsToBounds = true
        
        content.addSubview(header)
        header.snp.makeConstraints{ (make) -> Void in
            make.top.left.equalTo(0)
            make.width.equalTo(100)
        }
        
        return content
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        
        let cellContent: String = self.dataList![indexPath.section][indexPath.row]
        
        let content: UILabel = UILabel()
        content.backgroundColor = UIColor.green
        content.text = cellContent
        content.font = UIFont.systemFont(ofSize: 10.0)
        content.textAlignment = NSTextAlignment.center
        cell.addSubview(content)
        content.snp.makeConstraints{ (make) -> Void in
            make.width.height.equalTo(cell)
        }

       
        return cell
    }
}

