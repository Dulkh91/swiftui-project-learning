//
//  Formatter.swift
//  blogView
//
//  Created by Ros Dul on 19/5/26.
//

import Foundation

let formatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .medium   // e.g. May 15, 2026
    df.timeStyle = .short    // e.g. 9:21 AM
    df.locale = Locale(identifier: "us_US")// foce to am/pm
    return df
}()
