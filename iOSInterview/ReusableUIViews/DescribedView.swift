//
//  DescribedView.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/4.
//

import UIKit


/// 支持设置一个描述性label以及位置的UIView
class DescribedView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    enum Position {
        case topLeft
        case topCenter
        case topRight
        case rightCenter
        case bottomRight
        case bottomCenter
        case bottomLeft
        case leftCenter
        case center
    }

    init(title: String, position: Position = .topCenter) {
        super.init(frame: .zero)
        label.text = title
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let firstItem = label as Any
        let leadingConstraint = NSLayoutConstraint(item: firstItem, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: firstItem, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: firstItem, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: firstItem, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: firstItem, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        switch position {
        case .topLeft:
            NSLayoutConstraint.activate([leadingConstraint, topConstraint])
        case .topCenter:
            NSLayoutConstraint.activate([topConstraint, centerXConstraint])
        case .topRight:
            NSLayoutConstraint.activate([topConstraint, trailingConstraint])
        case .rightCenter:
            NSLayoutConstraint.activate([trailingConstraint, centerYConstraint])
        case .bottomRight:
            NSLayoutConstraint.activate([bottomConstraint, trailingConstraint])
        case .bottomCenter:
            NSLayoutConstraint.activate([bottomConstraint, centerXConstraint])
        case .bottomLeft:
            NSLayoutConstraint.activate([leadingConstraint, bottomConstraint])
        case .leftCenter:
            NSLayoutConstraint.activate([leadingConstraint, centerYConstraint])
        case .center:
            NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
