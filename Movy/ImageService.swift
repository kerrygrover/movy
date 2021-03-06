//
//  ImageService.swift
//  Movy
//
//  Created by Prateek Grover on 25/09/16.
//  Copyright © 2016 prateekgrover. All rights reserved.
//

import Foundation
import UIKit

class ImageService{
    
    static let sharedInstance = ImageService()
    let imageCache:NSCache = NSCache<NSString,MovyUIImage>()
    
    internal func downloadImage(path:String, completionHandler:@escaping (MovyUIImage?) -> Void){
        
        let url = URL(string: IMAGE_DOWNLOAD_BASE_URL+path)
        
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (responseData, responseUrl, error) -> Void in
            if let data = responseData{
                let downloadedImage = MovyUIImage(data: data)
                if downloadedImage != nil{
                    downloadedImage!.urlPath = path
                    self?.imageCache.setObject(downloadedImage!, forKey: path as NSString)
                    completionHandler(downloadedImage!)
                }
            }
        }
        
        task.resume()
    }
    
    internal func checkCache(path:String) -> MovyUIImage?{
        return self.imageCache.object(forKey: path as NSString)
    }
}
