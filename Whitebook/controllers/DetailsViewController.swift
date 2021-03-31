//
//  ViewController.swift
//  Whitebook
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var authorsLabel: UILabel!
    
    var info:CategoryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = info?.name
        self.descriptionLabel.text = info?.description
        self.authorsLabel.text = "Autores: " + info!.authors
            .map({ (item) -> String in item.name}).joined(separator: ", ")
        
        let url = URL(string: info!.urlImage)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.imageView.image = UIImage.init(data: data)
            }
        }
        task.resume()
    }
}

