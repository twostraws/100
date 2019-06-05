//
//  DetailViewController.swift
//  Project03C
//
//  Created by William Spanfelner on 29/05/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var selectedFlag: String?
    var country: String?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let countryName = country else {
            print("No country name found.")
            return
        }
        
        title = "Flag of \(countryName.count > 2 ? countryName.capitalized : countryName.uppercased())"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let flagToLoad = selectedFlag {
            imageView.image = UIImage(named: flagToLoad)
        }
    }
    
    @objc func shareTapped() {
        guard let flagImage = imageView.image else {
            print("No flag image found.")
            return
        }
        guard let countryName = country else {
            print("No country name found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [flagImage, countryName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
