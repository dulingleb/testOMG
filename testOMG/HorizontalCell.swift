//
//  VerticalCollectionViewCell.swift
//  testOMG
//
//  Created by Dulin Gleb on 4.3.24..
//

import UIKit

class HorizontalCell: UICollectionViewCell {
    static let reuseId = "HorizontalCell"
    
    let numberLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.textAlignment = .center
        return lbl
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberLabel.frame = contentView.bounds
        numberLabel.center = contentView.center
    }
    
    func setupUI() {
        contentView.addSubview(numberLabel)
    }
    
    func updateNumber(number: Int) {
        numberLabel.text = "\(number)"
    }
    
}
