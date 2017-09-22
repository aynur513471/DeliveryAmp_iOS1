//
//  LegalViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/3/17.
//
//

import UIKit

class LegalViewController: UIViewController, UIWebViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var legalView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegates
        legalView.delegate = self
        legalView.scrollView.delegate = self
        
        let url = NSURL (string: "http://lipsum.com/");
        let requestObj = NSURLRequest(url: url! as URL);
        legalView.loadRequest(requestObj as URLRequest);
        legalView.scrollView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        legalView.scrollView.showsHorizontalScrollIndicator = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        self.view.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)
        self.view.layoutIfNeeded()
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0{
        
            scrollView.contentOffset.x = 0
        }
    }
    
    // MARK: - Navigation

    @IBAction func goBack(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

}
