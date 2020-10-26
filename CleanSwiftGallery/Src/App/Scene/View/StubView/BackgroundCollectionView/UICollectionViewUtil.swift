//
//  UICollectionViewUtil.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

extension UICollectionView {
    func stubView(take header: CGRect? = nil) {
        let sizes: CGSize = bounds.size
        let nib = R.nib.stubView
        guard let backgroundView = nib.instantiate(withOwner: nil)[0] as? StubView else {
            return
        }

        let rect = header != nil ? CGRect(x: 0,
                                          y: header!.maxY,
                                          width: sizes.width,
                                          height: sizes.height - header!.height) : CGRect(x: 0.0,
                                                                                          y: 0.0,
                                                                                          width: sizes.width,
                                                                                          height: sizes.height)

        let container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: sizes.width, height: sizes.height))
        backgroundView.frame = rect
        container.addSubview(backgroundView)

        backgroundView.setup()
        self.backgroundView = container
    }

    func hideEmptyMessage() {
        self.backgroundView = nil
    }
    
    func emptyMessageWithImage() {
        let sizes: CGSize = bounds.size

        let nib = R.nib.stubView
        let backgroundView = nib.instantiate(withOwner: nil)[0] as? StubView
        backgroundView?.frame = CGRect(x: 0.0, y: 0.0, width: sizes.width, height: sizes.height)

        backgroundView?.setup()

        self.backgroundView = backgroundView
    }
}
