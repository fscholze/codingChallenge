//
//  Section3CollectionViewCell.swift
//  OfferistaChallenge
//
//  Created by Feliks Scholze on 03.03.17.
//  Copyright © 2017 Feliks Scholze. All rights reserved.
//

import UIKit

class Section3CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBAction func likeIt(_ sender: UIButton) {
        if UIImagePNGRepresentation(sender.currentImage!) == UIImagePNGRepresentation(UIImage(named:"icon_heart_grey")!) {
            sender.setImage(UIImage(named:"icon_heart_red"), for: [])
        } else {
            sender.setImage(UIImage(named:"icon_heart_grey"), for: [])
        }
    }
    
    func setTitel(title: String) {
        self.labelTitle.text = title
    }
    
    func setCompany(company: String) {
        self.labelCompany.text = company.uppercased()
    }
    
    func setPrice(price: String) {
        let euro = price.components(separatedBy: ".")[0]
        let cents = price.components(separatedBy: ".")[1]
        let font:UIFont? = UIFont(name: "Helvetica", size:13)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:8)
        let _price = "€ \(price)"
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: _price, attributes: [NSFontAttributeName:font!])
        attString.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:_price.characters.count], range: NSRange(location:euro.characters.count+3,length:cents.characters.count))
        self.labelPrice.attributedText = attString
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
}
