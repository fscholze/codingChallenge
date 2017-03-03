//
//  ViewController.swift
//  OfferistaChallenge
//
//  Created by Feliks Scholze on 03.03.17.
//  Copyright © 2017 Feliks Scholze. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var section1CollectionView: UICollectionView!
    @IBOutlet weak var section3CollectionView: UICollectionView!
    @IBOutlet weak var section2CollectionView: UICollectionView!
    
    let SECTION1_ENTRIES = 4 // Number of Products in Section 1
    var arraySection1 = [Product]() // array to hold all 4 Products of Section 1
    
    struct Product {
        var category = ""
        var title = ""
        var imageUrl = ""
        var price = ""
        var company = ""
    }
    
    func downloadData(url: String, section: Int) {
        // Daten werden von einer website or php Script runtergeladen
        if let _url = URL(string: url) {
            
            let request = NSMutableURLRequest(url: _url)
            
            // Task wird defintiert
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print(error)
                } else {
                    if let unwrappedData = data {
                        
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            // Section 1
                            if section == 1 {
                                for i in 0...(self.SECTION1_ENTRIES-1) {
                                    self.arraySection1.append(self.jsonToProduct(json: jsonResult[i] as! NSDictionary))
                                }
                                DispatchQueue.main.sync(execute: {
                                    self.section1CollectionView.reloadData()
                                })
                            }
                            
                            // Section 2
                            
                            //Section 3
                            
                        } catch {
                            print("JSON Processing Failed")
                        }
                        
                    }
                }
            }
            // task wird gestartet
            task.resume()
        }
    }

    func jsonToProduct(json: NSDictionary) -> Product { // Make a Product struct of json entry
        var _product = Product()
        _product.title = json["title"] as! String
        _product.category = json["category"] as! String
        _product.imageUrl = json["image"] as! String
        _product.price = json["price"] as! String
        _product.company = json["company"] as! String
        
        return _product
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        downloadData(url: "https://s3-eu-west-1.amazonaws.com/offerista-challenge/1.json", section: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
    // Collection Views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1) { // Section 1
            return 4
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            let cell: Section1CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Section1CollectionViewCell
            let _index = indexPath.row
            cell.setTitel(title: arraySection1[_index].title)
            cell.setCategory(category: arraySection1[_index].category)
            cell.setImage(url: arraySection1[_index].imageUrl)
            cell.tag = _index
            return cell
        default:
            print("error - collectionView")
            let cell: Section1CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Section1CollectionViewCell
            return cell
        }
    }
}

