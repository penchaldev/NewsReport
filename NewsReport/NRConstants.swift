//
//  WRConstants.swift
//  NewsReport
//
//  Created by Penchal on 15/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import Foundation
import UIKit


//MARK: - CELL IDENTIFIERS -

let tableCell = "cell"

//MARK: - STORYBOARD ID'S -

let keyDetailReportVC = "DetailedReport"

//MARK: - ALERT MESSAGES -

let keyError = "Error!"
let keyNetConnect = "Please connect to Internet"

//MARK: - API Key -

let apiKey = "beae3cfddeab4db0bc3fc9490ba48067"

//MARK: - Network Responses -

enum NetworkResponse:String {
    case success
    case unautherized
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
    case unautherized
}

enum HTTPMethod:String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

//MARK: - City Names -
let cityNamesArray =  ["Agra","Ahmedabad","Allahabad","Amritsar","Bengaluru","Bhopal","Chennai","Coimbatore","Cuttack","Delhi","Faridabad","Guntur","Gurgaon","Guwahati","Hyderabad","Indore","Jaipur","Jammu","Kanpur","Kochi","Kolkata","Lucknow","Mangalore","Meerut","Mumbai","Mysore","Nagpur","Nashik","Noida","Patna","Pimpri","Pune","Raipur","Ranchi","Srinagar","Surat","Thane","Thiruvananthapuram","Vadodara","Varanasi","Vijayawada","Visakhapatnam"]


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
