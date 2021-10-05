//
//  Coordinator.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 29/09/21.
//

import Foundation
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    var picker: ImagePickerView
    
    init(picker: ImagePickerView){
        self.picker = picker
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
