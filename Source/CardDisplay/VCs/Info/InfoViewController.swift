//
//  InfoViewController.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var cardLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Info"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (SharedVariable.shareInstance().selCard != nil) {
            cardLabel.text = SharedVariable.shareInstance().selCard?.title
        } else {
            cardLabel.text = "No one selected"
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
