//
//  ViewController.swift
//  Whitebook
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func loadList(callback:@escaping ([ApiItemEntry]) -> Void, errorCallback:@escaping (Error) -> Void) {
        let url = URL(string: "https://private-54fe53-pebmeddesafio.apiary-mock.com/contents")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                errorCallback(error!)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let entries = try decoder.decode([ApiItemEntry].self, from:data)
                callback(entries)
            } catch {
                errorCallback(error)
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadList(callback: { (entries) in
            
        }) { (error) in
            
        }
    }
}

