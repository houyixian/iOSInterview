//
//  RainGiftPopUpBaseViewController.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/4/17.
//

import UIKit

class RainGiftPopUpBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let baseView = RainGiftPopUpBaseView()
        baseView.isShowClose = true
        baseView.contentHeightStyle = .height280
        baseView.show(in: view)
    }
}
