//
//  ChooseFileViewModel.swift
//  DetectCar
//
//  Created by Ekaterina Khudzhamkulova on 20.3.2022.
//

import Foundation
import SwiftUI
import Combine
import Vision

final class ChooseFileViewModel: ObservableObject {
    var subscription: Set<AnyCancellable> = []

    @Published var labelResults: String = ""

    func classifyImage(image: Binding<UIImage>) {
        guard let model = try? VNCoreMLModel(for: Top4CarsClassification_1().model) else {
            print("No model")
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let observations = request.results as? [VNClassificationObservation] {
                let top3 = observations.prefix(through: 2)
                    .map{ ($0.identifier, $0.confidence) }
                print(top3)
                    self.labelResults += "\(top3[0])\n\(top3[1])\n\(top3[2])"
            }

        }
        request.imageCropAndScaleOption = .centerCrop
        guard let new = image.wrappedValue.cgImage else {
            print("error unbinding")
            return
        }

        let handler = VNImageRequestHandler(cgImage: new)
        try? handler.perform([request])
    }
}

extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)

        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)

        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()

// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
