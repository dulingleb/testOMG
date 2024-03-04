//
//  ViewController.swift
//  testOMG
//
//  Created by Dulin Gleb on 4.3.24..
//

import UIKit

class ViewController: UICollectionViewController {
    
    var timer: DispatchSourceTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.reuseId)
        
        let queue = DispatchQueue.global(qos: .userInitiated)
                
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .seconds(1))
        timer?.setEventHandler { [weak self] in
            self?.updateData()
        }
        timer?.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.random(in: 100...1000)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as! VerticalCell
        cell.setNumbers(numbers: initNumbers())
        
        return cell
    }
    
    func initNumbers() -> [Int] {
        var numbers: [Int] = []
        for _ in 0..<Int.random(in: 11...20) {
            numbers.append(Int.random(in: 0...100))
        }
        return numbers
    }
    
    @objc func updateData() {
        DispatchQueue.main.async {
            let visibleIndexPaths = self.collectionView.indexPathsForVisibleItems
            for indexPath in visibleIndexPaths {
                if let cell = self.collectionView.cellForItem(at: indexPath) as? VerticalCell {
                    cell.updateVisibleCells()
                }
            }
        }
    }
    
}

