//
//  ViewController.swift
//  Alura Ingressos
//
//  Created by user on 13/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var imagemBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
    }


}

