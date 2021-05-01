//
//  SubviewOutOfBoundsToSuperviewViewController.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/6.
//

import UIKit

/// 子视图超出了父视图如何响应
class SubviewOutOfBoundsToSuperviewViewController: UIViewController {
    
    private let superView: EnLargedDescribedView = {
        let view = EnLargedDescribedView(title: "superView", position: .topCenter)
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
            m.leading.equalToSuperview().offset(-80)
        }
    }

}

private class EnLargedDescribedView: DescribedView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var isInsideSelf = super.point(inside: point, with: event)
        if !isInsideSelf {
            // 如果不在自身中，判断是不是在超出自身的subView里面
            for subview in subviews {
                let convertedPoint = convert(point, to: subview)
                if subview.point(inside: convertedPoint, with: event) {
                    isInsideSelf = true
                    break
                }
            }
        }
        print("point \(point)\(isInsideSelf ? "在" : "不在")\(title)中")
        return isInsideSelf
    }
}
