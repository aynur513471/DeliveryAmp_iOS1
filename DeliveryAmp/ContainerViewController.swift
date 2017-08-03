//
//  ContainerViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class ContainerViewController: UIViewController {
    
    var viewController : UIViewController!
    var segueIdentifier : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func segueIdentifierReceivedFromParent(_ identifier: String){
        self.segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
    }
    
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            
            
            //Remove Container View
            if viewController != nil{
                viewController.view.removeFromSuperview()
                viewController = nil
            }
            
            viewController = segue.destination
            self.addChildViewController(viewController)
            viewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
          
        }
        
    }

}
