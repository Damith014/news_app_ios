//
//  DetailsCardTableViewCell.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

class DetailsCardTableViewCell: UITableViewCell {
    @IBOutlet weak var image_main: UIImageView!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var label_author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
