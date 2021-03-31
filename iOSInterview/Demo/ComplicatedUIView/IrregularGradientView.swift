//
//  IrregularGradientView.swift
//  iOSInterview
//
//  Created by 侯逸仙 on 2021/3/17.
//

import UIKit

class IrregularGradientView: UIView {
    private let irregularShapeLayer = CAShapeLayer()
    private let gradientLayer0 = CAGradientLayer()
    private let gradientLayer1 = CAGradientLayer()
    
    private let cornerRadius: CGFloat = 30
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width
        let height = bounds.height
        let irregularPath = UIBezierPath()
        irregularPath.move(to: CGPoint(x: 0, y: 30))
        irregularPath.addQuadCurve(to: CGPoint(x: 30, y: 0), controlPoint: CGPoint.zero)
        irregularPath.addQuadCurve(to: CGPoint(x: width - 30, y: 0), controlPoint: CGPoint(x: width / 2, y: cornerRadius / 2))
        irregularPath.addQuadCurve(to: CGPoint(x: width, y: 30), controlPoint: CGPoint(x: width, y: 0))
        irregularPath.addLine(to: CGPoint(x: width, y: height - cornerRadius))
        irregularPath.addQuadCurve(to: CGPoint(x: width - cornerRadius, y: height), controlPoint: CGPoint(x: width, y: height))
        irregularPath.addLine(to: CGPoint(x: 30, y: height))
        irregularPath.addQuadCurve(to: CGPoint(x: 0, y: height - 30), controlPoint: CGPoint(x: 0, y: height))
        irregularPath.close()
        irregularShapeLayer.fillColor = UIColor.blue.cgColor
        irregularShapeLayer.strokeColor = UIColor.green.cgColor
        irregularShapeLayer.path = irregularPath.cgPath
        // 在最上面创建一个内阴影试试
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = UIColor.green.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = .evenOdd
//        shadowLayer.lineWidth = 10
//        shadowLayer.strokeColor = UIColor.black.cgColor
        
        let offset: CGFloat = 5
        
        let irregularInnerPath = UIBezierPath()
        irregularInnerPath.move(to: CGPoint(x: offset, y: 30))
        irregularInnerPath.addQuadCurve(to: CGPoint(x: 30, y: offset), controlPoint: CGPoint(x: offset, y: offset))
        irregularInnerPath.addQuadCurve(to: CGPoint(x: width - 30, y: offset), controlPoint: CGPoint(x: width / 2, y: cornerRadius / 2 + offset))
        irregularInnerPath.addQuadCurve(to: CGPoint(x: width - offset, y: 30), controlPoint: CGPoint(x: width - offset, y: offset))
        irregularInnerPath.addLine(to: CGPoint(x: width - offset, y: height - cornerRadius))
        irregularInnerPath.addQuadCurve(to: CGPoint(x: width - cornerRadius, y: height - offset), controlPoint: CGPoint(x: width - offset, y: height - offset))
        irregularInnerPath.addLine(to: CGPoint(x: 30, y: height - offset))
        irregularInnerPath.addQuadCurve(to: CGPoint(x: offset, y: height - 30), controlPoint: CGPoint(x: offset, y: height - offset))
        irregularInnerPath.close()
        let largerPath = CGMutablePath()
        largerPath.addPath(irregularPath.cgPath)
//        let largerPath = UIBezierPath(rect: bounds.insetBy(dx: -42, dy: -42))
//        let someInnerPath = UIBezierPath(rect: CGRect(x: 60, y: 60, width: bounds.width - 120, height: bounds.height - 120))
        largerPath.addPath(irregularInnerPath.cgPath)
        largerPath.closeSubpath()
        shadowLayer.path = largerPath
        shadowLayer.fillColor = UIColor.red.cgColor
        
        gradientLayer0.colors = [
            UIColor.red.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor
        ]
        gradientLayer0.locations = [0, 0.78, 1]
//        gradientLayer0.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer0.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 0.88, c: -1.09, d: 0, tx: 1.04, ty: -0.03))
        gradientLayer0.bounds = CGRect(x: offset * 2, y: offset * 2, width: bounds.width - offset * 4, height: bounds.height - offset * 4)
        gradientLayer0.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer0.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        layer.addSublayer(gradientLayer0)

        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.colors = [
          UIColor(red: 1, green: 0.408, blue: 0.55, alpha: 1).cgColor,
          UIColor(red: 1, green: 0.129, blue: 0.286, alpha: 0).cgColor
        ]
        gradientLayer1.locations = [0, 1]
        gradientLayer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -0.09, b: -0.39, c: 0.47, d: -0.09, tx: 0.64, ty: 0.94))
        gradientLayer1.bounds = bounds.insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        gradientLayer1.position = center
//        layer.addSublayer(gradientLayer1)
//        layer.cornerRadius = 30
//        layer.masksToBounds = true
        
        let newMaskLayer = CAShapeLayer()
        newMaskLayer.path = irregularInnerPath.cgPath
        shadowLayer.mask = newMaskLayer
        self.layer.addSublayer(shadowLayer)
        layer.shouldRasterize = true
        newMaskLayer.shouldRasterize = true
        layer.mask = newMaskLayer
        
    }
    
}
