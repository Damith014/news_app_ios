//
//  ListScreenVC.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-26.
//

import Kingfisher
import KVNProgress
import UIKit

class ListScreenVC: UIViewController {
    @IBOutlet weak var table_list: UITableView!
    var articles: [Articles] = []
    var page = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.dataLoad(page: self.page)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }

    func setup() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Hot Updates"
        self.navigationController?.tabBarController?.tabBar.isHidden = true

        self.table_list.register(UINib(nibName: "DetailsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsCardTableViewCell")
    }

    func dataLoad(page: Int) {
        self.page += 1
        KVNProgress.show()
        Client.shared.getTopUpdates(page: self.page) { response in
            DispatchQueue.main.async {
                KVNProgress.dismiss()
                if response.status == "ok" {
                    var items_list = self.articles
                    items_list.append(contentsOf: response.articles ?? [])
                    self.articles = items_list
                    self.table_list.reloadData()

                } else {
                    Utility.showInformativeAlertView(
                        vc: self,
                        Constant.serverAPI.errorMessages.kErrorDefaultTitle,
                        message: Constant.serverAPI.errorMessages.kErrorDefaultMessage,
                        buttonTitle: "Ok",
                        onClickCallback: {}
                    )
                }
            }

        } failure: { _ in
            KVNProgress.dismiss()
            Utility.showInformativeAlertView(
                vc: self,
                Constant.serverAPI.errorMessages.kErrorDefaultTitle,
                message: Constant.serverAPI.errorMessages.kErrorDefaultMessage,
                buttonTitle: "Ok",
                onClickCallback: {}
            )
        }
    }
}

extension ListScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCardTableViewCell", for: indexPath) as! DetailsCardTableViewCell
        cell.selectionStyle = .none

        let article = self.articles[indexPath.row]
        cell.image_main.kf.setImage(with: URL(string: article.urlToImage ?? ""), placeholder: UIImage(imageLiteralResourceName: "placeholder_userSquare"), options: [.transition(.fade(0.2))])

        cell.label_date.text = Utility.dateFormat(date: article.publishedAt ?? "")
        cell.label_title.text = article.title
        cell.label_author.text = "by \(article.author ?? "")"
        cell.label_description.text = "by \(article.description ?? "")"

        if indexPath.row == self.articles.count - 1 {
            self.dataLoad(page: self.page)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsScreenVC = DetailsScreenVC(nibName: "DetailsScreenVC", bundle: nil)
        detailsScreenVC.article = self.articles[indexPath.row]
        detailsScreenVC.fromHome = false
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(detailsScreenVC, animated: true)
    }
}
