//
//  ViewController.swift
//  Project1
//
//  Created by William Spanfelner on 25/05/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var photos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm Viewer"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                photos += [item]
            }
        }
        print(photos, photos.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photos", for: indexPath)
        cell.textLabel?.text = photos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //: 1. Try loading the "Detail" view controller and typecasting it to DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            //: 2. Success! Set its selectedImage property
            vc.selectedImage = photos[indexPath.row]
            vc.photoIndex = indexPath.row + 1
            vc.photoCount = photos.count
            //: 3. now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    /*:
     This method provides the ability to share the image and imageName on social media or other methods
     */
    @objc func shareTapped() {
        let twitterString = """
                            You will love this app.
                            Download now:
                            """
        let url = URL(string: "https://mrstroppy.com")!
        /*:
         The imageName can be viewed by copying the string to the pasteboard and then pasting it into a searchbar on the simulated device.
         */
        
        let vc = UIActivityViewController(activityItems: [twitterString, url], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}

