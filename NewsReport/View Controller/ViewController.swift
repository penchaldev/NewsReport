//
//  ViewController.swift
//  NewsReport
//
//  Created by Penchal on 15/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var articals = [Article]()

    @IBOutlet weak var newsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        newsTableView.allowsSelection = false
        fetchDataFromDatabase()
    }

 //MARK: - Fetching from Database
    func fetchDataFromDatabase() {
        showActivityIndicator(progressLabel: "Fetching Data")
        if let dataInfo = CoreDataHelper.fetchWhetherData(), dataInfo.count > 0 {
            print("offlineData:\(dataInfo)")
            articals = dataInfo
            self.newsTableView.reloadData()
        }
        else {
            print("Offline data not available, Fetching from Server call and Saving to database")
            if Reachability.isConnectedToNetwork() {
                serverCalls()
            }
        }
    }

    func serverCalls() {
        
        WRNetworkManager.getServiceCall() { (newsObject) in
            
            print("Fetched Location Weather Report: \(newsObject)")
            self.saveAndUpdateNewsReport(articals: newsObject.articles)
        }

    }

    //MARK: - Saving Server data to Database
    func saveAndUpdateNewsReport(articals: [Article]) {
        DispatchQueue.main.async {

            for news in articals {

                CoreDataHelper.saveDataAndUpdateData(userData: news)
            }
            self.fetchDataFromDatabase()

        }
    }

    //MARK: Table View delegate and datasource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articals.count)
        return articals.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell

        let aNews = articals[indexPath.row]
        cell.newsTitle.text = ("\(aNews.title)")
        cell.newsDescription.text = ("Details: \(aNews.description)")

        let imageUrlString = aNews.urlToImage
        print("UrlString:\(String(describing: imageUrlString))")

        if let imageUrl = imageUrlString {
            cell.newsImage.image = UIImage(named: "")
            showActivityIndicator(progressLabel: "Loading")
            DispatchQueue.global().async {
                if let url = URL(string: imageUrl ) {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            cell.newsImage.image = image
                        }
                    }
                }
            }

        } else {
            //if url is Nil Loading Default Image
            cell.newsImage.image = UIImage(named: "internet")
            self.hideActivityIndicator()
        }
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height
    }


}





