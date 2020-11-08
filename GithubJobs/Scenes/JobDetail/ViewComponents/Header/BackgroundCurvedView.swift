//
//  BackgroundCurvedView.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

import UIKit

class BackgroundCurvedView: UIView {

    override func draw(_ rect: CGRect) {
        let layerHeight = layer.frame.height
        let layerWidth = layer.frame.width

        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: layerWidth, y: 0))
        path.addLine(to: CGPoint(x: layerWidth, y: layerHeight * 0.85))
        path.addQuadCurve(to: CGPoint(x: 0, y: layerHeight * 0.85),
                          controlPoint: CGPoint(x: layerWidth * 0.5, y: layerHeight))
        path.close()


        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }

}
