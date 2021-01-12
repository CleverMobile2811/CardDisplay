//
//  CardViewController.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

import UIKit

let kCollectionViewNumberOfSets: Int = 4
let kCollectionViewLineSpacing: CGFloat = 4.0
let kNumberOfBanners: Int = 6
let kMaxAutoScrollSpeed: CGFloat = 100
let kMinAutoScrollSpeed: CGFloat = 0
let kCentimeterOf1Inch: CGFloat = 2.54
let kAutoScrollDefaultTimerInterval: CGFloat = 0.01

class CardViewController: UIViewController {

    @IBOutlet weak var collectionView: InfinityCollectionView!
    let reuseCardCell = "CardCollectionViewCell"
    
    var cardData: [Card] = []
    private var autoScrollSpeed: CGFloat!
    private var timerInterval: CGFloat!
    private var movePointAmountForTimerInterval: CGFloat!
    private var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Card"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = ZoomAndSnapFlowLayout()
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(UINib(nibName: reuseCardCell, bundle: Bundle.main), forCellWithReuseIdentifier: reuseCardCell)
        
        config()
    }
    
    private func config() {
        // Initial Data
        loadData()

        // CollectionView's Settings
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = false
        collectionView.numberOfSets = kCollectionViewNumberOfSets
        
        setAutoScrollSpeed(30)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadData() {
        CardService.shareInstance().getCardData{ (result) in
            if (result) {
                DispatchQueue.main.async {
                    self.cardData = SharedVariable.shareInstance().cardArray
                    self.collectionView.reloadData()
//                    print("--test data: \(SharedVariable.shareInstance().cardArray) ")
                }
            }
        }
    }
    private func setAutoScrollSpeed(_ autoScrollSpeed: CGFloat) {
        var availableAutoScrollSpeed: CGFloat
        if autoScrollSpeed > kMaxAutoScrollSpeed {
            availableAutoScrollSpeed = kMaxAutoScrollSpeed
        } else if autoScrollSpeed < kMinAutoScrollSpeed {
            availableAutoScrollSpeed = kMinAutoScrollSpeed
        } else {
            availableAutoScrollSpeed = autoScrollSpeed
        }

        self.autoScrollSpeed = availableAutoScrollSpeed
        if (self.autoScrollSpeed > 0) {
            let movePixelAmountForOneSeconds = self.autoScrollSpeed * CGFloat(DeviceInfo.getPixelPerInch()) * 0.1 / kCentimeterOf1Inch
            let movePointForOneSeconds = movePixelAmountForOneSeconds / UIScreen.main.scale
            let movePointAmountForTimerInterval = movePointForOneSeconds * kAutoScrollDefaultTimerInterval
            let floorMovePointAmountForTimerInterval = floor(movePointAmountForTimerInterval)
            if floorMovePointAmountForTimerInterval < 1 {
                self.movePointAmountForTimerInterval = 1
            } else {
                self.movePointAmountForTimerInterval = floorMovePointAmountForTimerInterval
            }
            self.timerInterval = self.movePointAmountForTimerInterval / movePointForOneSeconds
        }
        
        startAutoScroll()
    }
    private func startAutoScroll() {
        if self.timer.isValid {
            return
        }
        
        if self.autoScrollSpeed == 0 {
            self.stopAutoScroll()
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timerInterval),
                                              target: self,
                                              selector: #selector(timerDidFire),
                                              userInfo: nil,
                                              repeats: true)
        }
    }
    
    private func stopAutoScroll() {
        if self.timer.isValid {
            self.timer.invalidate()
        }
    }
    
    @objc
    private func timerDidFire() {
        let nextContentOffset = CGPoint(x: self.collectionView.contentOffset.x + self.movePointAmountForTimerInterval,
                                        y: self.collectionView.contentOffset.y)
        self.collectionView.contentOffset = nextContentOffset
    }

}
extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cardData.count
        return self.cardData.count * self.collectionView.numberOfSets
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCardCell, for: indexPath)
        if let cell = c as? CardCollectionViewCell {
            let correctIndexRow = indexPath.row % self.cardData.count
            if (self.cardData.count >= correctIndexRow + 1) {
                let item = self.cardData[correctIndexRow]
                cell.bind(imgUrl: item.image_aws_url, title: item.title, desc: item.description)
            }
        }
        return c
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let correctIndexRow = indexPath.row % self.cardData.count
        if (self.cardData.count >= correctIndexRow + 1) {
            let item = self.cardData[correctIndexRow]
            SharedVariable.shareInstance().selCard = item
//            presentAlert(withTitle: item.title, message: "\"\(item.title)\" is selected")
            stopAutoScroll()
            let okAction = AlertAction(title: OKTitle)
            let alertC = getAlertViewController(type: .alert, with: item.title, message: "\"\(item.title)\" is selected", actions: [okAction], showCancel: false, actionHandler: { (button) in
                self.startAutoScroll()
            })
            present(alertC, animated: true, completion: nil)
        }
    }
    
    
}
