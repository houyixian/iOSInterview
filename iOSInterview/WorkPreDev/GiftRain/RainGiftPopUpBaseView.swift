//
//  RainGiftPopUpBaseView.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/18.
//

import UIKit


/// 礼物雨弹卡的基类，不要直接使用该类
public class RainGiftPopUpBaseView: UIView {
    
    public enum ContentHeightStyle: Int {
        case height280 = 280
        case height330 = 330
    }
    
    public var contentHeightStyle = ContentHeightStyle.height330 {
        didSet {
            centerBgImageView.snp.updateConstraints { (m) in
                switch contentHeightStyle {
                case .height280:
                    m.height.equalTo(contentHeightStyle.rawValue + 50)
                case .height330:
                    m.height.equalTo(contentHeightStyle.rawValue + 50)
                }
            }
            contentView.snp.makeConstraints { (m) in
                m.height.equalTo(contentHeightStyle.rawValue)
            }
        }
    }
    
    /// 子类在contentView中增加自己的内容
    public var contentView = UIView()
    
    /// 子类在该视图中增加底部功能区想放的内容，该视图的高度设置为60
    public var bottomFunctionView = UIView()
    /// 包含所有内容的容器视图
    private let containerView = UIView()
    private let centerBgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var closeContainerView = getCloseContainerView()
    
    private lazy var closeImageView = UIImageView()
    
    
    /// 是否展示弹窗底部的关闭按钮
    public var isShowClose = false {
        didSet {
            closeContainerView.snp.updateConstraints { (m) in
                if isShowClose {
                    m.top.equalTo(bottomFunctionView.snp.bottom).offset(32)
                    m.height.equalTo(44)
                } else {
                    m.top.equalTo(bottomFunctionView.snp.bottom)
                    m.height.equalTo(0)
                }
            }
        }
    }
    
    public var isShowBottomFuctionView = false {
        didSet {
            bottomFunctionView.snp.updateConstraints { (m) in
                if isShowBottomFuctionView {
                    m.height.equalTo(60)
                } else {
                    m.height.equalTo(0)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllSubviews()
        setupAllConstraints()
        configContentView()
        configBottomFunctionView()
        closeContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    private func addAllSubviews() {
        addSubview(containerView)
        containerView.addSubview(centerBgImageView)
        containerView.addSubview(contentView)
        containerView.addSubview(bottomFunctionView)
        containerView.addSubview(closeContainerView)
        bottomFunctionView.backgroundColor = .green
        contentView.backgroundColor = .blue
    }
    
    private func setupAllConstraints() {
        containerView.snp.makeConstraints { (m) in
            m.leading.greaterThanOrEqualToSuperview().offset(15).priority(.required)
            m.trailing.lessThanOrEqualToSuperview().offset(-15).priority(.required)
            m.width.equalTo(300).priority(.high)
            m.center.equalToSuperview()
        }
        switch contentHeightStyle {
        case .height280:
            centerBgImageView.snp.makeConstraints { (m) in
                m.leading.trailing.top.equalToSuperview()
                m.height.equalTo(contentHeightStyle.rawValue + 50)
            }
        case .height330:
            centerBgImageView.snp.makeConstraints { (m) in
                m.leading.trailing.top.equalToSuperview()
                m.height.equalTo(contentHeightStyle.rawValue + 50)
            }
        }
        bottomFunctionView.snp.makeConstraints { (m) in
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            if isShowClose {
                m.height.equalTo(60)
            } else {
                m.height.equalTo(0)
            }
            m.top.equalTo(centerBgImageView.snp.bottom)
        }
        closeContainerView.snp.makeConstraints { (m) in
            if isShowClose {
                m.top.equalTo(bottomFunctionView.snp.bottom).offset(32)
                m.height.equalTo(44)
            } else {
                m.top.equalTo(bottomFunctionView.snp.bottom)
                m.height.equalTo(0)
            }
            m.width.equalTo(44)
            m.bottom.equalToSuperview()
            m.centerX.equalToSuperview()
        }
        contentView.snp.makeConstraints { (m) in
            m.leading.trailing.bottom.equalTo(centerBgImageView)
            m.height.equalTo(contentHeightStyle.rawValue)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getCloseContainerView() -> UIView {
        let view = UIView()
        view.addSubview(closeImageView)
        closeImageView.snp.makeConstraints { (m) in
            m.width.height.equalTo(28)
            m.center.equalToSuperview()
        }
        view.backgroundColor = .blue
        return view
    }
    
    // MARK: - 子类根据需要重写的方法
    /// 在该方法中增加contentView的内容布局，contentView的约束已经按照UI图设置好
    public func configContentView() {
        
    }
    
    /// 在该方法中增加bottomFunctionView的内容布局，bottomFunctionView的高度设置为60，两边对齐父视图
    public func configBottomFunctionView() {
        
    }
    
    // MARK: - 展示和消失的动效，按需取用
    public func show(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.55
        scaleAnimation.values = [0, 1, 0.9, 1]
        scaleAnimation.keyTimes = [0, 0.54, 0.81, 1]
        scaleAnimation.isRemovedOnCompletion = true
        scaleAnimation.fillMode = .forwards
        scaleAnimation.repeatCount = 1
        containerView.layer.add(scaleAnimation, forKey: nil)
    }
    
    @objc public func dismiss() {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.4
        scaleAnimation.values = [1, 1.1, 0]
        scaleAnimation.keyTimes = [0, 0.375, 1]
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = .forwards
        scaleAnimation.repeatCount = 1
        scaleAnimation.delegate = self
        containerView.layer.add(scaleAnimation, forKey: "")
    }
    
}

extension RainGiftPopUpBaseView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removeFromSuperview()
    }
}
