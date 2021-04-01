//
//  GridViewController.swift
//  Whitebook
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController: UITableViewController {
    
    let API_ENDPOINT = "https://private-54fe53-pebmeddesafio.apiary-mock.com/contents"
    let SHOW_DETAILS_SEGUE = "ShowDetails"
    let CATEGORY_CELL = "CategoryCell"
    let USER_DEFAULTS_KEY = "cache"
    
    var categories:[Category] = []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CATEGORY_CELL, for: indexPath) as! CategoryTableViewCell
        cell.label.text = categories[indexPath.section].items[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let categoryItem = categories[indexPath.section].items[indexPath.row]
        performSegue(withIdentifier: SHOW_DETAILS_SEGUE, sender: categoryItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SHOW_DETAILS_SEGUE) {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.info = sender as? CategoryItem
        }
    }
    
    func listFromApiList(_ apiList: [ApiItemEntry]) -> [Category]{
        var list:[Category] = []
        
        let apiListByCategoryId = Dictionary(grouping: apiList, by: { $0.category.id })
        for (_, categoryApiList) in apiListByCategoryId {
            let apiCategory = categoryApiList.first!.category
            let categoryItems:[CategoryItem] = categoryApiList.map { (apiEntry) -> CategoryItem in apiEntry.content }
            let category = Category.init(id: apiCategory.id, name: apiCategory.name, items: categoryItems)
            list.append(category)
        }
        
        return list
    }
    
    func apiListFromJsonData(_ json:Data) throws -> [ApiItemEntry] {
        let decoder = JSONDecoder()
        return try decoder.decode([ApiItemEntry].self, from:json)
    }
    
    func loadList(callback:@escaping ([Category]) -> Void, errorCallback:@escaping (Error) -> Void) {
        #if TESTS
            let value = ProcessInfo.processInfo.environment["json"]!
            let data = value.data(using: .utf8)!
            do {
                let entries = try self.apiListFromJsonData(data)
                DispatchQueue.main.async {
                    callback(self.listFromApiList(entries))
                }
            } catch {
                errorCallback(error)
            }
        #else
            let defaults = UserDefaults.standard
            if let dataObj = defaults.object(forKey: USER_DEFAULTS_KEY) {
                let dataStr = dataObj as! String
                let data = dataStr.data(using: .utf8)!
                
                do {
                    let entries = try self.apiListFromJsonData(data)
                    DispatchQueue.main.async {
                        callback(self.listFromApiList(entries))
                    }
                } catch {
                    errorCallback(error)
                }
                return
            }
            
            let url = URL(string: API_ENDPOINT)!
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {
                    errorCallback(error!)
                    return
                }
                do {
                    let dataStr = String.init(data: data, encoding: .utf8)
                    defaults.set(dataStr, forKey: self.USER_DEFAULTS_KEY)
                    
                    let entries = try self.apiListFromJsonData(data)
                    DispatchQueue.main.async {
                        callback(self.listFromApiList(entries))
                    }
                } catch {
                    errorCallback(error)
                }
            }
            task.resume()
        #endif
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadList(callback: { (entries) in
            self.categories = entries
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
}
