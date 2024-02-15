//
//  ImageDownloader.swift
//  dicoding-ios-fundamental
//
//  Created by Keenan Adityo on 15/02/24.
//

import Foundation

import UIKit

class ImageDownloader {

  func downloadImage(url: URL) async throws -> UIImage {
    async let imageData: Data = try Data(contentsOf: url)
    return UIImage(data: try await imageData)!
  }
}
