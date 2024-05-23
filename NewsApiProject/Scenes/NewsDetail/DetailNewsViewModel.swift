//
//  DetailNewsViewModel.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import Foundation

protocol DetailNewsViewProtocol {
    func formattedDate(dateString: String) -> String
}

final class DetailNewsViewModel: DetailNewsViewProtocol {
    func formattedDate(dateString: String) -> String {
        // create dateFormatter with UTC time format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateString.replacingOccurrences(of: "Z", with: "")
        guard let date = dateFormatter.date(from: dateString) else { return "unkown"}

        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "h:mm a, E MMM d, yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
}
