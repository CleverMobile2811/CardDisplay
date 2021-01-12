//
//  ViewController.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

import UIKit
import AVFoundation
import AZTabBar

class MainViewController: UIViewController {
    
    var counter = 0
    var tabController:AZTabBarController!
    
    var audioId: SystemSoundID!
    
    var resultArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioId = createAudio()

        
        var icons = [UIImage]()
        icons.append(#imageLiteral(resourceName: "Hom"))
        icons.append(#imageLiteral(resourceName: "Heart"))
        icons.append(#imageLiteral(resourceName: "Camera"))
        icons.append(#imageLiteral(resourceName: "Search Filled"))
        icons.append(#imageLiteral(resourceName: "User"))
        
        var sIcons = [UIImage]()
        sIcons.append(#imageLiteral(resourceName: "Home Filled"))
        sIcons.append(#imageLiteral(resourceName: "Heart Filled"))
        sIcons.append(#imageLiteral(resourceName: "Camera Filled"))
        sIcons.append(#imageLiteral(resourceName: "Search Filled"))
        sIcons.append(#imageLiteral(resourceName: "User Filled"))

        
        //init
        //tabController = .insert(into: self, withTabIconNames: icons)
            
        tabController = .insert(into: self, withTabIcons: icons, andSelectedIcons: sIcons)

        //set delegate
        tabController.delegate = self

        //set child controllers
        
        let cardNavC = UIStoryboard(name: "Card", bundle: nil).instantiateInitialViewController() as! UINavigationController
        tabController.setViewController(cardNavC, atIndex: 0)

        let infoNavC = UIStoryboard(name: "Info", bundle: nil).instantiateInitialViewController() as! UINavigationController
        tabController.setViewController(infoNavC, atIndex: 1)

        let tab3NavC = UIStoryboard(name: "Tab3", bundle: nil).instantiateInitialViewController() as! UINavigationController
        tabController.setViewController(tab3NavC, atIndex: 2)
        
        let tab4NavC = UIStoryboard(name: "Tab4", bundle: nil).instantiateInitialViewController() as! UINavigationController
        tabController.setViewController(tab4NavC, atIndex: 3)
        
        let tab5NavC = UIStoryboard(name: "Tab5", bundle: nil).instantiateInitialViewController() as! UINavigationController
        tabController.setViewController(tab5NavC, atIndex: 4)


        //customize

        let color = UIColor(red: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)

        tabController.selectedColor = color

        tabController.highlightColor = color

        tabController.highlightedBackgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)

        tabController.defaultColor = .lightGray

        //tabController.highlightButton(atIndex: 2)

        tabController.buttonsBackgroundColor = UIColor(red: (247.0/255), green: (247.0/255), blue: (247.0/255), alpha: 1.0)

        tabController.selectionIndicatorHeight = 0

        tabController.selectionIndicatorColor = color

        tabController.tabBarHeight = 60

        tabController.notificationBadgeAppearance.backgroundColor = .red
        tabController.notificationBadgeAppearance.textColor = .white
        tabController.notificationBadgeAppearance.borderColor = .clear
        tabController.notificationBadgeAppearance.borderWidth = 0.2

//        tabController.setBadgeText("!", atIndex: 4)

        tabController.setIndex(10, animated: true)

        tabController.setAction(atIndex: 3){
            self.counter = 0
//            self.tabController.setBadgeText(nil, atIndex: 3)
        }

        tabController.setAction(atIndex: 2) {
//            self.tabController.onlyShowTextForSelectedButtons = !self.tabController.onlyShowTextForSelectedButtons
        }

        tabController.setAction(atIndex: 4) {
            //self.tabController.setBar(hidden: true, animated: true)
        }

        tabController.setIndex(0, animated: true)

        tabController.animateTabChange = true
        tabController.onlyShowTextForSelectedButtons = false
        tabController.setTitle("Card", atIndex: 0)
        tabController.setTitle("Info", atIndex: 1)
        tabController.setTitle("Tab 3", atIndex: 2)
        tabController.setTitle("Tab 4", atIndex: 3)
        tabController.setTitle("Tab 5", atIndex: 4)
        tabController.font = UIFont(name: "AvenirNext-Regular", size: 12)

        let container = tabController.buttonsContainer
        container?.layer.shadowOffset = CGSize(width: 0, height: -2)
        container?.layer.shadowRadius = 10
        container?.layer.shadowOpacity = 0.1
        container?.layer.shadowColor = UIColor.black.cgColor


        tabController.setButtonTintColor(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), atIndex: 0)
        
        // set firstFlag
        UserDefaults.standard.setValue(true, forKey: "firstFlag")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override var childForStatusBarStyle: UIViewController?{
        return tabController
    }
    
    func getNavigationController(root: UIViewController)->UINavigationController{
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.title = title
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)
        return navigationController
    }
    
    func createAudio()->SystemSoundID{
        var soundID: SystemSoundID = 0
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "blop" as CFString?, "mp3" as CFString?, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        return soundID
    }
    
}

extension MainViewController: AZTabBarDelegate{
    func tabBar(_ tabBar: AZTabBarController, statusBarStyleForIndex index: Int) -> UIStatusBarStyle {
        return (index % 2) == 0 ? .default : .lightContent
    }
    
    func tabBar(_ tabBar: AZTabBarController, shouldLongClickForIndex index: Int) -> Bool {
        return true//index != 2 && index != 3
    }
    
    func tabBar(_ tabBar: AZTabBarController, shouldAnimateButtonInteractionAtIndex index: Int) -> Bool {
        return true
    }
    
    func tabBar(_ tabBar: AZTabBarController, didMoveToTabAtIndex index: Int) {
        print("didMoveToTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, didSelectTabAtIndex index: Int) {
        print("didSelectTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, willMoveToTabAtIndex index: Int) {
        print("willMoveToTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, didLongClickTabAtIndex index: Int) {
        print("didLongClickTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, systemSoundIdForButtonAtIndex index: Int) -> SystemSoundID? {
        return tabBar.selectedIndex == index ? nil : audioId
    }
    
}

