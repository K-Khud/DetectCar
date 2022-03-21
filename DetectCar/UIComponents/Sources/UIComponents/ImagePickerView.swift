//
//  File.swift
//  
//
//  Created by Ekaterina Khudzhamkulova on 20.3.2022.
//

import UIKit
import SwiftUI

public struct ImagePickerView: UIViewControllerRepresentable {
    public var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding public var image: UIImage
    @Binding public var isPresented: Bool

    public init(isPresented: Binding<Bool>, image: Binding<UIImage>, sourceType: UIImagePickerController.SourceType = .photoLibrary) {
        self._isPresented = isPresented
        self._image = image
        self.sourceType = sourceType
    }

    public func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented)
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}
