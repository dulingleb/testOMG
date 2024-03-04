//
//  VerticalCell.swift
//  testOMG
//
//  Created by Dulin Gleb on 4.3.24..
//

import UIKit

class VerticalCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let reuseId = "VerticalCell"
    
    let cellBorderWidth = 1.0
    let cellCornerRadius = 5.0
    
    var numbers: [Int] = []
    var originalTransform: CGAffineTransform?
    
    var collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        

        cv.register(HorizontalCell.self, forCellWithReuseIdentifier: HorizontalCell.reuseId)
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        setupUI()
    
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        addGestureRecognizer(longPressGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupUI() {
        contentView.layer.borderWidth = cellBorderWidth
        contentView.layer.borderColor = UIColor.systemFill.cgColor
        contentView.layer.cornerRadius = cellCornerRadius
        contentView.addSubview(collectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCell.reuseId, for: indexPath) as! HorizontalCell
        cell.updateNumber(number: numbers[indexPath.row])
        return cell
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func setNumbers(numbers: [Int]) {
        self.numbers = numbers
        
        collectionView.reloadData()
    }
    
    func updateVisibleCells() {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? HorizontalCell {
                let number = Int.random(in: 1...100)
                cell.updateNumber(number: number)
            }
        }        
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let targetView = gesture.view else { return }
        
        if gesture.state == .began {
            originalTransform = targetView.transform
            UIView.animate(withDuration: 0.2) {
                targetView.transform = targetView.transform.scaledBy(x: 0.8, y: 0.8)
            }
        } else if gesture.state == .ended || gesture.state == .cancelled {
            guard let originalTransform = originalTransform else { return }
            UIView.animate(withDuration: 0.2) {
                targetView.transform = originalTransform
            }
        }
    }
}
