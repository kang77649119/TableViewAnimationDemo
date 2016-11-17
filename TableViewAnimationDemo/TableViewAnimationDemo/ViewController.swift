//
//  ViewController.swift
//  TableViewAnimationDemo
//
//  Created by 也许、 on 2016/11/17.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height
let statusBarH : CGFloat = 20
let cellId = "cellId"

class ViewController: UIViewController {

    let datas = [ "但凡未得到，但凡是过去，总是最登对", "既是如此，何必执着", "爱情有时徒有虚名，不过是一场宿命", "唱的容易做的难，谁又真能如此洒脱", "拥有的时候永远不懂珍惜，人类通病", "这样爱，会容易得多", "爱情虽然美丽，却是易碎玻璃", "缘分可遇不可求" ]
    
    lazy var tableView : UITableView = {
        
        let frame = CGRect(x: 0, y: statusBarH, width: screenW, height: screenH - statusBarH )
        let tableView : UITableView = UITableView(frame: frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化UI
        setupUI()
        
    }
    
    // 在视图显示前,修改单元格的位置
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        let cells = tableView.visibleCells
        for cell in cells {
            // 将cell的偏移量修改为1个表格的高度
            cell.transform = CGAffineTransform(translationX: 0, y: self.tableView.bounds.height)
        }
        
        var index = 0
        for cell in cells {
            
            // 使用动画来恢复cell的位置
            UIView.animate(withDuration: 1, delay: Double(index) * 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: { ()->() in
                // 恢复cell的位置
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            index += 1
        }
        
    }

}

extension ViewController {
    
    // 初始化UI
    func setupUI() {
        self.view.addSubview(tableView)
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = self.datas[indexPath.row]
        
        let greenColor = (CGFloat(indexPath.row) / CGFloat(self.datas.count)) * 0.6
        cell.backgroundColor = UIColor(red: 0.8, green: greenColor, blue: 0.8, alpha: 1)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewWillAppear(true)
    }
    

}
























