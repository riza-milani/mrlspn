//
//  UIViewController+Extentions.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit

extension UIViewController {
    func showLoading(_ value: Bool) {
        if value {
            let indicatorView = UIActivityIndicatorView(style: .gray)
            if !view.subviews.contains(indicatorView) {
                indicatorView.tag = 50000
                view.addSubview(indicatorView)
            }
            indicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
            indicatorView.startAnimating()
        } else {
            if let indicatorView = view.viewWithTag(50000) as? UIActivityIndicatorView {
                indicatorView.stopAnimating()
                indicatorView.removeFromSuperview()
            }
        }

    }
}
