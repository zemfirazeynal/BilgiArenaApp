//
//  CircularProgressView.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//
import UIKit

final class CircularProgressView: UIView {

    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()

    var progress: CGFloat = 0 {
        didSet {
            setProgress(progress)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }

    private func createCircularPath() {
        let radius = min(frame.width, frame.height) / 2
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius - 8,
                                        startAngle: -.pi / 2,
                                        endAngle: 1.5 * .pi,
                                        clockwise: true)

        // Track (gray background)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.systemGray5.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)

        // Progress (main purple arc)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.systemIndigo.cgColor
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }

    private func setProgress(_ progress: CGFloat) {
        progressLayer.strokeEnd = min(max(progress, 0), 1)
    }
}
