//
//  MainCardCollectionViewCell.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

class MainCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image_head: UIImageView!
    @IBOutlet weak var label_author: UILabel!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
