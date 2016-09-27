//: Playground - noun: a place where people can play

import UIKit
import CoreImage

/**
 *  Original
 */
func originBlur(image: CIImage) -> CIImage? {
    let filter = CIFilter(name: "CIGaussianBlur")
    filter?.setValue(image, forKey: "inputImage")
    
    if let output = filter?.valueForKey("outputImage") as? CIImage {
        return output
    } else {
        print("image filtering failed")
        return nil
    }
}
/**
 *
 */
typealias Filter = CIImage -> CIImage?
func blur(radius: Double) -> Filter {
    return {image in
        let parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters)
            else { print("image filtering failed 1"); return nil }
        guard let outputImage = filter.outputImage
            else { print("image filtering failed 2"); return nil }
        return outputImage
    }
}
