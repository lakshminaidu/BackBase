//
//  BaseViewController.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - IBoutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    // setup the view
    func setup() {
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.stopAnimating()
        self.navigationController?.navigationBar.barTintColor = .purple
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - User defined
    /// toggle the loader
    func showloader(state: Bool) {
        if state == true {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
