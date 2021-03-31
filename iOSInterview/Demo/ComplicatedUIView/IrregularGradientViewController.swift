//
//  IrregularGradientViewController.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/17.
//

import UIKit

class IrregularGradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let gradientView = IrregularGradientView()
        view.addSubview(gradientView)
//        gradientView.backgroundColor = .red
        gradientView.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(15)
            m.trailing.equalToSuperview().offset(-15)
            m.width.equalTo(gradientView.snp.height)
            m.center.equalToSuperview()
        }
    }
}
