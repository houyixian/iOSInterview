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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
