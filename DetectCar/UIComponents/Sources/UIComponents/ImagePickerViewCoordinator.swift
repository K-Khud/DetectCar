//
//  File.swift
//  
//
//  Created by Ekaterina Khudzhamkulova on 20.3.2022.
//

import UIKit
import SwiftUI

public class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding public var image: UIImage
    @Binding public var isPresented: Bool

    public init(image: Binding<UIImage>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
        self.isPresented = false
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }

}
