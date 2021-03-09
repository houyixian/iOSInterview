//
//  SubviewOutOfBoundsToSuperviewViewController.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/6.
//

import UIKit

class SubviewOutOfBoundsToSuperviewViewController: UIViewController {
    
    private let superView: DescribedView = {
        let view = DescribedView(title: "superView", position: .topCenter)
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    private let subview1: DescribedView = {
        let view = DescribedView(title: "subview1", position: .center)
        view.backgroundColor = .red
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(superView)
        view.backgroundColor = .white
        superView.snp.makeConstraints { (m) in
            m.edges.equalTo(UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100))
        }
        superView.addSubview(subview1)
        subview1.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.height.width.equalTo(200)
            m.leading.equalToSuperview().offset(-50)
        }
    }

}
