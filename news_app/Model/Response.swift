//
//  Response.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-26.
//

import Foundation
struct Response: Decodable {
    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        self.articles = try container.decodeIfPresent([Articles].self, forKey: .articles)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }

    var status: String?
    var totalResults: Int?
    var articles: [Articles]?
}

struct Articles: Decodable {
    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decodeIfPresent(Source.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }

    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct Source: Decodable {
    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    var id: String?
    var name: String?
}
