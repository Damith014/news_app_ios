//
//  TagCardTableViewCell.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-26.
//

import UIKit

class TagCardTableViewCell: UITableViewCell {
    @IBOutlet weak var tag_collection_view: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
