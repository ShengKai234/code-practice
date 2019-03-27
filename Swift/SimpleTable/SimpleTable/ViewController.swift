//
//  ViewController.swift
//  SimpleTable
//
//  Created by Kai on 2018/3/8.
//  Copyright © 2018年 AppCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITabBarDelegate {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster",
                           "For Kee Restaurant", "Po's Atelier", "Bourke Stree Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meat And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    var restaurantImage = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster",
                           "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //回傳陣列數
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //識別碼宣告
        let cellIdentifier = "Cell"
        //指定Ｃell去得佇列
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        //指定文字標籤要顯示的文字
        //textLabel為Optional
        cell.textLabel?.text = restaurantNames[indexPath.row] //indexPath為正在顯示的列
        cell.imageView?.image = UIImage(named : restaurantImage[indexPath.row])
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }


}

