//
//  Tab5ViewController.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

import UIKit

class Tab5ViewController: UIViewController {

    @IBOutlet weak var logoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Tab5"
        logoutBtn.setTitle("Log out", for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickLogout(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
            let onboardNavC = storyboard.instantiateViewController(identifier: "OnboardNavigationController")

            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(onboardNavC)
    }
}
