//
//  CategoryCollectionViewCell.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var view_background: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected{
                self.view_background.backgroundColor = UIColor(red: 255/255.0, green: 58/255.0, blue: 68/255.0, alpha: 1)
                self.label_title.textColor = UIColor.white
            }else{
                self.view_background.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
                self.label_title.textColor = UIColor.black
            }
        }
    }

}
