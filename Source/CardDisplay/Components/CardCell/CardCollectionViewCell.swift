//
//  CardCollectionViewCell.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

import UIKit
import SDWebImage

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: SDAnimatedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bind(imgUrl: String, title: String, desc: String) {
        var url = URL(string: imgUrl)
        if (url == nil) {
            url = URL(string: "https://cdn.browshot.com/static/images/not-found.png")
        }
        let tempImg = UIImage(systemName: "clock")
//        imgView.sd_setImage(with: url)
        imgView.sd_setImage(with: url, placeholderImage: tempImg)
        titleLabel.text = title
        descLabel.text = desc
    }
    
}
