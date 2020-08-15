//
//  ViewController.swift
//  NewsReport
//
//  Created by Penchal on 15/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var newsReport:NewsModel?
    var fetchedNewsReport:NewsDataModel?
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Reachability.isConnectedToNetwork() {
            serverCalls()
        }else {
//           fetchDataFromDatabase()
        }
    }
    
    func serverCalls() {
        showActivityIndicator(progressLabel: "Fetching Data")
        WRNetworkManager.getServiceCall() { (newsObject) in
            self.newsReport = newsObject
//            print("Fetched Location Weather Report: \(newsObject)")
            print("News Title : \(newsObject.articles[0].title)")
            print("News Description : \(newsObject.articles[0].title)")
            print("News Title : \(newsObject.articles[0].urlToImage)")
            
            self.hideActivityIndicator()
            self.saveAndUpdateNewsReport()
        }
        
    }
    func saveAndUpdateNewsReport() {
        DispatchQueue.main.async {
            
            var newsModel = NewsDataModel()
            newsModel.title                 = self.newsReport?.articles[0].title
            newsModel.articleDescription    = self.newsReport?.articles[0].articleDescription
            newsModel.urlToImage            = self.newsReport?.articles[0].urlToImage
        
            CoreDataHelper.saveDataAndUpdateData(userData: newsModel)
        }
    }
    
/*
    func fetchDataFromDatabase() {
        if let dataInfo = CoreDataHelper.fetchWhetherData() {
            print("offlineData:\(dataInfo)")
            self.fetchedNewsReport?.title              = dataInfo.title
            self.fetchedNewsReport?.urlToImage         = dataInfo.urlToImage
        }else {
            print("Offline data not available For Location ")
        }
    }
 */
    
}


//MARK: Table View delegate and datasource methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsReport?.articles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.newsTitle.text = ("Title: \(newsReport?.articles[indexPath.row].title ?? "")")
        cell.newsDescription.text = ("Description: \(newsReport?.articles[indexPath.row].articleDescription ?? "")")

        let image = self.newsReport?.articles[indexPath.row].urlToImage

        DispatchQueue.global().async {
            if let url = URL(string: image ?? "") {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.newsImage.image = image
                    }
                }
            }
        }
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height
    }

}

