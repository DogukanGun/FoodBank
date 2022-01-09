//
//  UIView+drawRoundedEdge.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

extension UIView{
    func drawRoundedEdge(ratio:CGFloat){
        let y:CGFloat = ratio
        let curveTo:CGFloat = 0
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: 0, y: y))
        myBezier.addQuadCurve(to: CGPoint(x: self.bounds.width, y: y), controlPoint: CGPoint(x: self.bounds.width / 2, y: curveTo))
        myBezier.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        myBezier.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        myBezier.close()
        //UIColor.white.setFill()
        backgroundColor?.setFill()
        myBezier.fill()
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = myBezier.cgPath
        self.layer.mask = maskLayer
    }
}
