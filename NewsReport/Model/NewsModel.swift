//
//  NewsModel.swift
//  NewsReport
//
//  Created by Penchal on 15/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String
    let title, description: String
    let url: String
    let urlToImage: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

struct NewsDataModel {
    var title: String?
    var articleDescription: String?
    var urlToImage: String?
}


















/*
// MARK: - Article
struct Article: Codable {
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String?
    let content: String

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, content
    }
}
 */



/*
struct Welcome: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String
    let title, articleDescription: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

*/
