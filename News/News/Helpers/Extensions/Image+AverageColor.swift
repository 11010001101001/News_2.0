//
//  Image+AverageColor.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation
import SwiftUI
import UIKit

extension View {

    @MainActor
    var averageColor: UIColor {
        let renderer = ImageRenderer(content: self)

        guard let uiImage = renderer.uiImage,
              let inputImage = CIImage(image: uiImage) else { return .red }

        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage,
                                                kCIInputExtentKey: extentVector]),
              let outputImage = filter.outputImage else { return .red }

        var bitmap = [UInt8](repeating: 0, count: 4)

        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}
