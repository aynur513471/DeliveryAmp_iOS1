//
//  TabBarController.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit
import SideMenu
class TabBarController: UITabBarController,UITabBarControllerDelegate {

    var lastItem : UITabBarItem = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        lastItem = (self.tabBar.items?.last)!
        
        setTextAtributes()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.items?[2] && !LocalRequest.checkOrder(){
            Alert.showDefaultAlert(for: self, title: nil, message: "No products selected!")
            
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if (self.tabBar.selectedItem)! == lastItem && !LocalRequest.checkOrder(){
            return false
        }
        return true
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

extension UITabBarController{
    
    func setTextAtributes() {
        if !LocalRequest.checkOrder(){
            self.tabBar.items?.last?.setTitleTextAttributes([NSForegroundColorAttributeName: MyColors.disabledTabItem], for:.normal)
        }else{
            self.tabBar.items?.last?.setTitleTextAttributes([NSForegroundColorAttributeName: MyColors.tabItem], for:.normal)
        }
        
    }

}
