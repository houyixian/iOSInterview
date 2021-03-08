//
//  DragableView.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/5.
//

import UIKit

class DragableView: UIView {

    public var dataSource: [DragableModel] = [
        DragableModel(title: "1"),
        DragableModel(title: "2"),
        DragableModel(title: "3"),
        DragableModel(title: "4"),
        DragableModel(title: "5"),
        DragableModel(title: "6"),
        DragableModel(title: "7"),
        DragableModel(title: "8"),
//        DragableModel(title: "9")
    ]

    public func appendDataSource(value: DragableModel) {
        dataSource.append(value)
    }

    public func removeDataSource(value: DragableModel) {
        dataSource.removeLast()
//        dataSource.removeAll { (removedValue) -> Bool in
//            removedValue.title == value.title
//        }
    }

    public func reloadData() {
        collectionView.reloadData()
    }

    public var itemSpacing: CGFloat = 5

    private var flowLayout: UICollectionViewFlowLayout!

    private var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionView()
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        collectionView.backgroundColor = .white
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    private func initCollectionView() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.ReuseIdentifier)
        collectionView.register(DragablePlusTableViewCell.self, forCellWithReuseIdentifier: DragablePlusTableViewCell.ReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @objc private func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView))
//        guard let selectedCell = collectionView.cellForItem(at: indexPath) else {
//            return
//        }
        switch gesture.state {
        case .began:
            if let indexPath = indexPath, indexPath.item != dataSource.count {
                collectionView.beginInteractiveMovementForItem(at: indexPath)
            }
            print("开始移动了")
        case .changed:
                collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            print("位置变化了")
        case .ended:
            collectionView.endInteractiveMovement()
            print("结束移动了")
        default:
            collectionView.endInteractiveMovement()
            collectionView.cancelInteractiveMovement()
            print("取消移动了")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DragableView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 最多只支持展示9个元素
        return dataSource.count < 9 ? dataSource.count + 1 : 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == dataSource.count {
            // 代表是最后一个plus号
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DragablePlusTableViewCell.ReuseIdentifier, for: indexPath) as! DragablePlusTableViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCollectionViewCell.ReuseIdentifier, for: indexPath) as! NormalCollectionViewCell
            cell.model = dataSource[indexPath.item]
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - itemSpacing * 2)
        let itemWidth = (width / 3).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.item == dataSource.count {
            return false
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.item == dataSource.count {
            return originalIndexPath
        }
        return proposedIndexPath
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("debug source is \(sourceIndexPath.item)")
        print("debug destination is \(destinationIndexPath.item)")
        if destinationIndexPath.item == dataSource.count {
            return
        }
        let sourceItem = dataSource[sourceIndexPath.item]
        dataSource.remove(at: sourceIndexPath.item)
        dataSource.insert(sourceItem, at: destinationIndexPath.item)
    }
}
