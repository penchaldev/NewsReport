//
//  CoreDataHelper.swift
//  WeatherReport
//
//  Created by Penchal on 15/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//


import Foundation

import CoreData
class CoreDataHelper {

    //MARK: - UserData DB Operations -

    class func saveDataAndUpdateData(userData: NewsDataModel) {

        let NewsInfoEntity: News!
        let aBatch = fetchWhetherLocationData()

        if let batchObj = aBatch {
            NewsInfoEntity = batchObj
        }
        else {
            NewsInfoEntity = NSEntityDescription.insertNewObject(forEntityName: String(describing: News.self), into: context) as? News
        }

        NewsInfoEntity.title                 = userData.title
        NewsInfoEntity.articleDescription    = userData.articleDescription
        NewsInfoEntity.urlToImage            = userData.urlToImage


        do {
            try context.save()

        } catch let error {
            print("error occured while saving user data : \(error) ")
        }
    }

    //Checking if there are any duplicate locations in DB
    class func fetchWhetherLocationData() -> News? {


        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
        do {
            let resultArray = try? context.fetch(fetchRequest)

            if let shiftObjs: [News] = resultArray as? [News], shiftObjs.count > 0 {
                if shiftObjs.count > 0 {
                    return shiftObjs[0]
                }
                return nil
            }
        }
        return nil
    }

    //Fetching Data from DB
    class func fetchWhetherData() -> NewsDataModel? {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
        do {
            guard let data = try context.fetch(fetchRequest) as? [News] else { return nil }
            for dataInfo in data {
                var newsData = NewsDataModel()
                newsData.title                 = dataInfo.title
                newsData.articleDescription    = dataInfo.articleDescription
                newsData.urlToImage            = dataInfo.urlToImage

                return newsData

            }
            return nil
        }
        catch let error {
            print("error occured while fetching user data : \(error)")
            return nil
        }
    }

    //Delete data from DB
    class func deleteAllWhetherData() {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: News.self))
        let deleteBatchRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteBatchRequest)
            try context.save()
        }
        catch let error {
            print(error)
        }
    }
}



