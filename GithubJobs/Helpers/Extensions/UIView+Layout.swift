//
//  UIView+Layout.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

extension UIView {

    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize? = nil) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()

        anchoredConstraints.top = top.flatMap { topAnchor.constraint(equalTo: $0, constant: padding.top) }
        anchoredConstraints.leading = leading.flatMap { leadingAnchor.constraint(equalTo: $0, constant: padding.left) }
        anchoredConstraints.bottom = bottom.flatMap { bottomAnchor.constraint(equalTo: $0, constant: -padding.bottom) }
        anchoredConstraints.trailing = trailing.flatMap { trailingAnchor.constraint(equalTo: $0, constant: -padding.right) }

        anchoredConstraints.width = size.flatMap { widthAnchor.constraint(equalToConstant: $0.width) }
        anchoredConstraints.height = size.flatMap { heightAnchor.constraint(equalToConstant: $0.height) }

        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach { $0?.isActive = true }

        return anchoredConstraints
    }

    func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        let safeAreaLayoutGuide = superview.safeAreaLayoutGuide
        topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom).isActive = true
        leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding.right).isActive = true
    }

    func centerInSuperview(size: CGSize? = nil) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true

        if let size = size {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func centerXInSuperview() {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }

    func centerYInSuperview() {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }

    func constraintWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func constraintHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func constraintWidthAspectRatio(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: constant).isActive = true
    }

    func constraintHeightAspectRatio(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: constant).isActive = true
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
