//
//  UIImageView+loadURL.swift
//  NewsApiProject
//
//  Created by Thiago de Oliveira Sousa on 23/05/24.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// MARK: - Cache Images

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(urlString: String,
                   placeholderImage: UIImage?,
                   errorImage: UIImage?) {
        
        // 1
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }
        
        // 2
        guard let url = URL(string: urlString) else {
            return
        }
        
        // 3
        if let placeholder = placeholderImage {
            DispatchQueue.main.async {
                self.image = placeholder
            }
        }
        
        self.fetchImageFromNetwork(url: url,
                                   placeholderImage: placeholderImage,
                                   errorImage: errorImage)
    }
    
    private func fetchImageFromNetwork(url: URL,
                                       placeholderImage: UIImage?,
                                       errorImage: UIImage?) {
        
        // 4
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error ) in
            
            // 5
            if let err = error {
                if let errImage = errorImage {
                    DispatchQueue.main.async {
                        self?.image = errImage
                    }
                }
                return
            }
            
            // 6
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if !(200...299).contains(statusCode) {
                if let errImage = errorImage {
                    DispatchQueue.main.async {
                        self?.image = errImage
                    }
                }
                return
            }
            
            // 7
            if let self = self, let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
