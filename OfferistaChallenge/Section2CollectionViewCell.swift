//
//  Section2CollectionViewCell.swift
//  OfferistaChallenge
//
//  Created by Feliks Scholze on 03.03.17.
//  Copyright © 2017 Feliks Scholze. All rights reserved.
//

import UIKit

class Section2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func setImage(url: String) {
        if let _url = URL(string: url) {
            
            let request = NSMutableURLRequest(url: _url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print(error)
                } else {
                    if let unwrappedData = data {
                        DispatchQueue.main.sync(execute: {
                            // Update UI
                            if let downloadedImage = UIImage(data: unwrappedData) {
                                self.image.image = downloadedImage
                            } else {
                                print("error")
                            }
                        })
                    }
                }
            }
            // start task
            task.resume()
        }
    }

}
