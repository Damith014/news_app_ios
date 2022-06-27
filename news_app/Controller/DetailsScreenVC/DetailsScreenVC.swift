//
//  DetailsScreenVC.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import Kingfisher
import UIKit

class DetailsScreenVC: UIViewController {
    var article: Articles?
    var fromHome: Bool = false

    @IBOutlet weak var image_back: UIImageView!
    @IBOutlet weak var label_autor: UILabel!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var image_head: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        self.label_date.text = Utility.dateFormat(date: self.article?.publishedAt ?? "")
        self.label_title.text = self.article?.title
        self.label_description.text = self.article?.description
        self.label_autor.text = self.article?.author
        self.image_head.kf.setImage(with: URL(string: self.article?.urlToImage ?? ""), placeholder: UIImage(imageLiteralResourceName: "placeholder_userSquare"), options: [.transition(.fade(0.2))])

        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailsScreenVC.tapBack))
        self.image_back.isUserInteractionEnabled = true
        self.image_back.addGestureRecognizer(tap)
    }

    @objc func tapBack(sender: UITapGestureRecognizer) {
        if self.fromHome {
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.tabBarController?.tabBar.isHidden = false
        }
        self.navigationController?.popViewController(animated: true)
    }
}
