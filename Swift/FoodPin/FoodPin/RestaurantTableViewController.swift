//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Kai on 2018/3/15.
//  Copyright © 2018年 AppCode. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    //等於restaurantIsVisited = [false, false, .....21]
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named : restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        
        //更新Cell輔助視圖
        if restaurantIsVisited[indexPath.row] {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //選去列動作建立
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //動作清單建立
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        if let popoverController = optionMenu.popoverPresentationController{
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        //動作選單加入
        //handler為動作執行選項
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        //打電話動作加入
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            //Alert Message提示視窗建立
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            //Alert Message提示中選項建立
            alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call" + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        let checkActionTitle = (restaurantIsVisited[indexPath.row]) ? "Undo Check in" : "Check in"
        
        let checkInAction = UIAlertAction(title: checkActionTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
                
                self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false: true
                let cell = tableView.cellForRow(at: indexPath)
                cell?.accessoryType = (self.restaurantIsVisited[indexPath.row]) ? .checkmark :.none
            })
        
        
        optionMenu.addAction(checkInAction)
        //呈現選單
        present(optionMenu, animated: true, completion: nil)
        //取消（灰諧部分）的選取
        tableView.deselectRow(at: indexPath, animated: false)
    }
    

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, sourceView, completionHandler) in
            //從資料來源刪除列
            
            //呼叫處理器來取消動作按鈕（執行刪除動作）
            completionHandler(true)

        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
