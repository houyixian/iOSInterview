//
//  UIControl+UIGestureRecognizerViewController.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/4.
//

import UIKit
import SnapKit

class UIControlMixUIGestureRecognizerViewController: UIViewController {

    private let superView: DescribedView = {
        let view = DescribedView(title: "SuperView", position: .topCenter)
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("UIButton", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        edgesForExtendedLayout = UIRectEdge([])
        view.addSubview(superView)
        superView.addSubview(button)
        superView.snp.makeConstraints { (m) in
            m.edges.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        button.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(tappedUIButton), for: .touchUpInside)
        superView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedSuperView)))
    }

    @objc private func tappedSuperView() {
        CommonToastManager.showInWindow(text: "选中了superView")
        print("tapGesture 选中了superView")
    }

    @objc private func tappedUIButton() {
        CommonToastManager.showInWindow(text: "tappedUIButton")
    }

}
