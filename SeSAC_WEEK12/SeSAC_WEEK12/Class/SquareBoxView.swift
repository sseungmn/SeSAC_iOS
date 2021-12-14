//
//  SquareBoxView.swift
//  SeSAC_WEEK12
//
//  Created by SEUNGMIN OH on 2021/12/13.
//

import UIKit

class SquareBoxView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        loadUI()
    }
    
    func loadView() {
        let view = UINib(nibName: "SquareBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10.0
        self.addSubview(view)
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "My Page"
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
}
