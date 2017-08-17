//
//  TabBarViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/16/17.
//
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var tabBar: UITabBar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hei i am load")
        print(tabBar.items?.count)
    }

    override func viewDidAppear(_ animated: Bool) {
        print("hei i am appear")
        print(tabBar.items?.count)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
