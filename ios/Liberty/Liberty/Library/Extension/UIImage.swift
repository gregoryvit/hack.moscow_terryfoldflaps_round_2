//
//  UIImage.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {

    convenience init?(from buffer: CMSampleBuffer) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else {
            return nil
        }
        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

    func crop(rect: CGRect) -> UIImage? {
        var rect = rect
        rect.origin.x *= self.scale
        rect.origin.y *= self.scale
        rect.size.width *= self.scale
        rect.size.height *= self.scale

        guard let imageRef = self.cgImage?.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    }

    func centerCrop(size: CGSize) -> UIImage? {
        return self.crop(rect: CGRect(x: (self.size.width - size.width) / 2.0,
                                      y: (self.size.height - size.height) / 2.0,
                                      width: size.width,
                                      height: size.height))
    }

    func resize(toSize size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let i = newImage {
            return i
        }
        return UIImage()
    }
}
