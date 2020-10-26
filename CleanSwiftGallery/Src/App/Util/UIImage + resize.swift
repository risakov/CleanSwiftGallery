//
//  UIImage + resize.swift
//  CleanSwiftGallery
//
//  Created by Роман on 09.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image.withRenderingMode(self.renderingMode)
    }
    
}
