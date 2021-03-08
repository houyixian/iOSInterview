//
//  DragableViewController.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/5.
//

import UIKit

/// cell可拖拽的collectionview示例，基于iOS9提供的功能
class DragableViewController: UIViewController {
    private let itemSpacing: CGFloat = 5

    private var dataSource: [DragableModel] = [
        DragableModel(title: "1"),
        DragableModel(title: "2"),
        DragableModel(title: "3"),
        DragableModel(title: "4"),
        DragableModel(title: "5"),
        DragableModel(title: "6"),
        DragableModel(title: "7"),
        DragableModel(title: "8"),
        DragableModel(title: "9")
    ]

    private let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("加9", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    private let minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("减1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    private let dragableView = DragableView()

    private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge([])
        view.backgroundColor = .white
        view.addSubview(dragableView)
        dragableView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        plusButton.addTarget(self, action: #selector(plusAction), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusAction), for: .touchUpInside)
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        plusButton.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(15)
            m.bottom.equalToSuperview().offset(-40)
        }
        minusButton.snp.makeConstraints { (m) in
            m.trailing.equalToSuperview().offset(-15)
            m.bottom.equalToSuperview().offset(-40)
        }
    }

    @objc private func plusAction() {
        dragableView.appendDataSource(value: DragableModel(title: "9"))
        dragableView.reloadData()
    }

    @objc private func minusAction() {
        dragableView.removeDataSource(value: DragableModel(title: "1"))
        dragableView.reloadData()
    }

//    private func initCollectionView() {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumInteritemSpacing = itemSpacing
//        flowLayout.scrollDirection = .vertical
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.ReuseIdentifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }

//    @objc private func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
//        let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView))
////        guard let selectedCell = collectionView.cellForItem(at: indexPath) else {
////            return
////        }
//        switch gesture.state {
//        case .began:
//            if let indexPath = indexPath {
//                collectionView.beginInteractiveMovementForItem(at: indexPath)
//            }
//            print("开始移动了")
//        case .changed:
//            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
//            print("位置变化了")
//        case .ended:
//            collectionView.endInteractiveMovement()
//            print("结束移动了")
//        default:
//            collectionView.endInteractiveMovement()
//            collectionView.cancelInteractiveMovement()
//            print("取消移动了")
//        }
//    }

}

//extension DragableViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataSource.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCollectionViewCell.ReuseIdentifier, for: indexPath) as! NormalCollectionViewCell
//        cell.model = dataSource[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.bounds.width - itemSpacing * 2
//        return CGSize(width: width / 3, height: width / 3)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let sourceItem = dataSource[sourceIndexPath.item]
//        dataSource.remove(at: sourceIndexPath.item)
//        dataSource.insert(sourceItem, at: destinationIndexPath.item)
//    }
//}
