//
//  HomeScreenVC.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import Kingfisher
import KVNProgress
import ReachabilitySwift
import UIKit

class HomeScreenVC: UIViewController {
    @IBOutlet weak var text_search: UITextField!
    @IBOutlet weak var image_filter: UIImageView!
    @IBOutlet weak var table_news: UITableView!
    let tags: [String] = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]

    var default_country: String = "us"
    var default_language: String = "en"
    var default_category: String = ""

    var leates_news: [Articles] = []

    var articles: [Articles] = []

    var isSearch: Bool = false

    var reachability: Reachability!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }

    func setup() {
        do {
            self.reachability = try! Reachability()

            self.reachability.whenReachable = { _ in
                DispatchQueue.main.async {
                    print("Connected")
                }
            }
            self.reachability.whenUnreachable = { _ in
                DispatchQueue.main.async {
                    print("Disconnected")
                    let alert = UIAlertController(title: Constant.serverAPI.errorMessages.kNoInternetErrorTitle, message: Constant.serverAPI.errorMessages.kNoInternetConnectionMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }

            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        } catch {
            print(error)
        }

        self.table_news.register(UINib(nibName: "HeadCardTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadCardTableViewCell")
        self.table_news.register(UINib(nibName: "TagCardTableViewCell", bundle: nil), forCellReuseIdentifier: "TagCardTableViewCell")
        self.table_news.register(UINib(nibName: "SubCardTableViewCell", bundle: nil), forCellReuseIdentifier: "SubCardTableViewCell")

        self.text_search.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeScreenVC.tapFilter))
        self.image_filter.isUserInteractionEnabled = true
        self.image_filter.addGestureRecognizer(tap)

        self.default_category = self.tags[0].lowercased()
        self.loadLeatesNews()
        self.getCategory(text: self.default_category)
    }

    @objc func networkStatusChanged(_ notification: Notification) {
    }

    @objc func tapFilter(sender: UITapGestureRecognizer) {
        let filterScreenVC = FilterScreenVC(nibName: "FilterScreenVC", bundle: nil)
        filterScreenVC.delegate = self
        filterScreenVC.default_country = self.default_country
        filterScreenVC.default_language = self.default_language
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.modalPresentationStyle = .pageSheet
        self.present(filterScreenVC, animated: true, completion: nil)
    }

    func loadLeatesNews() {
        KVNProgress.show()
        Client.shared.getHeadingNews(county: self.default_country, language: self.default_language) { response in
            DispatchQueue.main.async {
                KVNProgress.dismiss()
                if response.status == "ok" {
                    self.leates_news = response.articles ?? []
                    self.table_news.reloadData()

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

    @objc func tapSeeAll(sender: UITapGestureRecognizer) {
        let listScreenVC = ListScreenVC(nibName: "ListScreenVC", bundle: nil)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(listScreenVC, animated: true)
    }

    func getCategory(text: String) {
        KVNProgress.show()
        Client.shared.category(text: text, county: self.default_country, language: self.default_language) { response in
            DispatchQueue.main.async {
                KVNProgress.dismiss()
                if response.status == "ok" {
                    self.articles = response.articles ?? []
                    self.table_news.reloadData()

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

    func search(text: String) {
        KVNProgress.show()
        Client.shared.search(text: text) { response in
            DispatchQueue.main.async {
                KVNProgress.dismiss()
                if response.status == "ok" {
                    self.articles = response.articles ?? []
                    self.table_news.reloadData()

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

    func goDetailsScreen(article: Articles) {
        let detailsScreenVC = DetailsScreenVC(nibName: "DetailsScreenVC", bundle: nil)
        detailsScreenVC.article = article
        detailsScreenVC.fromHome = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(detailsScreenVC, animated: true)
    }
}

extension HomeScreenVC: FilterDelegate {
    func filter(county: String, language: String) {
        self.default_language = language
        self.default_country = county

        self.loadLeatesNews()
        self.getCategory(text: self.default_category)
    }
}

extension HomeScreenVC: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0 {
            self.isSearch = false
            self.loadLeatesNews()
        } else {
            self.isSearch = true
            self.search(text: textField.text!)
        }
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0 {
            self.isSearch = false
            self.loadLeatesNews()
        }
        return true
    }
}

extension HomeScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isSearch ? self.articles.count : (self.articles.count + 2)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !self.isSearch {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeadCardTableViewCell", for: indexPath) as! HeadCardTableViewCell
                cell.selectionStyle = .none
                cell.main_collection_view.dataSource = self
                cell.main_collection_view.delegate = self
                cell.main_collection_view.tag = 0
                cell.main_collection_view.register(UINib(nibName: "MainCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCardCollectionViewCell")
                cell.main_collection_view.reloadData()

                let tap = UITapGestureRecognizer(target: self, action: #selector(HomeScreenVC.tapSeeAll))
                cell.label_see_all.isUserInteractionEnabled = true
                cell.label_see_all.addGestureRecognizer(tap)

                return cell

            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TagCardTableViewCell", for: indexPath) as! TagCardTableViewCell
                cell.selectionStyle = .none
                cell.tag_collection_view.dataSource = self
                cell.tag_collection_view.delegate = self
                cell.tag_collection_view.tag = 1
                cell.tag_collection_view.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
                return cell

            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SubCardTableViewCell", for: indexPath) as! SubCardTableViewCell
                cell.selectionStyle = .none

                let article = self.articles[indexPath.row - 2]

                cell.image_head.kf.setImage(with: URL(string: article.urlToImage ?? ""), placeholder: UIImage(imageLiteralResourceName: "placeholder_userSquare"), options: [.transition(.fade(0.2))])

                cell.label_title.text = article.title
                cell.label_author.text = "\(article.author ?? "")"
                cell.label_date.text = Utility.dateFormatSearch(date: article.publishedAt ?? "")
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubCardTableViewCell", for: indexPath) as! SubCardTableViewCell
            cell.selectionStyle = .none

            let article = self.articles[indexPath.row]

            cell.image_head.kf.setImage(with: URL(string: article.urlToImage ?? ""), placeholder: UIImage(imageLiteralResourceName: "placeholder_userSquare"), options: [.transition(.fade(0.2))])

            cell.label_title.text = article.title
            cell.label_author.text = "\(article.author ?? "")"
            cell.label_date.text = Utility.dateFormatSearch(date: article.publishedAt ?? "")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSearch {
            self.goDetailsScreen(article: self.articles[indexPath.row])
        } else {
            self.goDetailsScreen(article: self.articles[indexPath.row - 2])
        }
    }
}

extension HomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return self.leates_news.count
        }
        return self.tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCardCollectionViewCell", for: indexPath) as! MainCardCollectionViewCell

            let article = self.leates_news[indexPath.row]

            cell.image_head.kf.setImage(with: URL(string: article.urlToImage ?? ""), placeholder: UIImage(imageLiteralResourceName: "placeholder_userSquare"), options: [.transition(.fade(0.2))])

            cell.label_title.text = article.title
            cell.label_author.text = "by \(article.author ?? "")"
            cell.label_description.text = "by \(article.description ?? "")"
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.label_title.text = self.tags[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            self.default_category = self.tags[indexPath.row]
            self.getCategory(text: self.tags[indexPath.row])
        } else {
            self.goDetailsScreen(article: self.leates_news[indexPath.row])
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.tag != 0 {
            return (collectionView.indexPathsForSelectedItems?.count ?? 0) < 2
        }
        return false
    }
}
