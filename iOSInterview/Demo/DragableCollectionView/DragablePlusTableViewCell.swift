//
//  DragablePlusTableViewCell.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/8.
//

import UIKit

class DragablePlusTableViewCell: UICollectionViewCell {
    static let ReuseIdentifier = "DragablePlusTableViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "➕"
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()

    public var model: DragableModel? {
        didSet {
            titleLabel.text = model?.title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
