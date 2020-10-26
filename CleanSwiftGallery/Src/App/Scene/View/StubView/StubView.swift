//
//  StubView.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class StubView: UIView {

    @IBOutlet weak var stubImage: UIImageView!

    func setup() {
        self.setNeedsDisplay()
        self.setNeedsLayout()
    }

}
