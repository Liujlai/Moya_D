//
//  ViewController.swift
//  Moya_D
//
//  Created by idea on 2018/1/2.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cupcake

class ViewController: UIViewController {
    
    var lab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabUI()
        loadDataOperation()
//        loadDataJD()
//        loadData()
//        loadlistData()
    }
    
    func setupLabUI(){
        lab = Label.lines(0).bg("#96CDCD").border(2, "#EE6AA7").color("#FFFFFF").addTo(view).makeCons({ (make) in
            make.width.height.equal(self.view)
        })
    }
    func loadDataOperation(){
        Network.request(.operation, success: { (json) in
            self.lab.str(json)
        }, error: { (statusCode) in
            //服务器报错等问题
            print("请求错误！错误码：\(statusCode)")
        }) { (error) in
            //没有网络等问题
            print("请求失败！错误信息：\(error.errorDescription ?? "")")
        }
    }
    
    func loadDataJD(){
        ApiProvider.request(.JD) { result  in
            if case let .success(response) = result{
                let data = try? response.mapJSON()
                let json = JSON(data!)
                DispatchQueue.main.async {
                    self.lab.str(json)
                }              
            }
        }
    }
    func loadData(){
        ApiProvider.request(.scores) { result in
            if case let .success(response) = result{
                let data = try? response.mapJSON()
                let json = JSON(data!)
                DispatchQueue.main.async {
                    self.lab.str(json)
                }
            }
        }
    }
    func loadlistData(){
        ApiProvider.request(.list) { result in
            if case let .success(response) = result{
                let data = try? response.mapJSON()
                let json = JSON(data!)
                DispatchQueue.main.async {
                    self.lab.str(json)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

