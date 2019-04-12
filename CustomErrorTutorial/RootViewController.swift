//
//  RootViewController.swift
//  CustomErrorTutorial
//
//  Created by Alex Nagy on 12/04/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import TinyConstraints

class RootViewController: UIViewController {
    
    let imageViewHeight: CGFloat = 120.0
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        
        Service.fetchImage { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.imageView.backgroundColor = .clear
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        
        imageView.topToSuperview(offset: 36, usingSafeArea: true)
        imageView.centerXToSuperview()
        imageView.width(imageViewHeight)
        imageView.height(imageViewHeight)
        
        activityIndicator.center(in: imageView)
    }
    
}

