//
//  ContentView.swift
//  DetectCar
//
//  Created by Ekaterina Khudzhamkulova on 20.3.2022.
//

import SwiftUI
import UIComponents

struct ContentView: View {
    @StateObject var viewModel: ChooseFileViewModel
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var image: UIImage = .init(systemName: "photo") ?? UIImage()
    @State private var imageSelected: Bool = false

    var body: some View {
        VStack {
            ButtonLabel(title: "Choose file", color: Colors.blueGreen)
                .onTapGesture {
                    self.shouldPresentActionScheet = true
                    self.imageSelected = true
                }
                .sheet(isPresented: $shouldPresentImagePicker) {
                    
                    ImagePickerView(isPresented: self.$shouldPresentImagePicker,
                                    image: self.$image,
                                    sourceType: self.shouldPresentCamera ? .camera : .photoLibrary)
                }
                .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Choose mode"),
                                message: Text("Please choose your preferred mode to set your profile image"),
                                buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = false
                    }), ActionSheet.Button.cancel()])
                }
            ButtonLabel(title: "Classify", color: Colors.freesia)
                .opacity(imageSelected ? 1 : 0)
                .onTapGesture {
                    viewModel.classifyImage(image: self.$image)
                }
            Image(uiImage: image)
                .resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
                .padding(8)
            Text(viewModel.labelResults)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ChooseFileViewModel())
    }
}
