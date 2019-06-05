//
//  ViewController.swift
//  Project03C
//
//  Created by William Spanfelner on 29/05/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var flags = [String]()
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = "Tap a flag to learn more..."
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
    
        for item in items {
            if item.hasSuffix("@3x.png") {
                flags.append(item)
                countries.append(String(item.dropLast(7)))
            }
        }
//        print(flags, flags.count, countries, countries.count)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flag", for:  indexPath)
        cell.textLabel?.text = countries[indexPath.row].count > 2 ? countries[indexPath.row].capitalized : countries[indexPath.row].uppercased()
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedFlag = flags[indexPath.row]
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

