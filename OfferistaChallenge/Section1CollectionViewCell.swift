//
//  Section1CollectionViewCell.swift
//  OfferistaChallenge
//
//  Created by Feliks Scholze on 03.03.17.
//  Copyright © 2017 Feliks Scholze. All rights reserved.
//

import UIKit

class Section1CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    
    //var activityIndicator = UIActivityIndicatorView()
    
    func setTitel(title: String) {
        self.labelTitle.text = title
    }
    
    func setCategory(category: String) {
        self.labelCategory.text = category.uppercased()
    }
    
    func setImage(url: String) {
        if let _url = URL(string: url) {
            
            //createSpinner()
            
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
            // task wird gestartet
            task.resume()
        }
        //self.activityIndicator.stopAnimating()
    }
    
   /* func createSpinner() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y:0, width: 50, height: 50))
        activityIndicator.center = self.image.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        Section1CollectionViewCell. addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }*/
    
}
