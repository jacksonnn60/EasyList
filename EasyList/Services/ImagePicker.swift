//
//  ImagePicker.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 07/09/2022.
//

import Foundation
import UIKit

protocol ImagePickerDelegate: NSObject {
    func imagePicker(didPickImage image: UIImage)
    func imagePicker(didTakeImage image: UIImage)
    func imagePicker(didCancelPickingImage picker: UIImagePickerController)
}

class ImagePicker: NSObject, UINavigationControllerDelegate {
    
    var delegate: ImagePickerDelegate?
    
    private lazy var imagePickerController: UIImagePickerController = {
        $0.delegate = self
        return $0
    }(UIImagePickerController())
    
    func takePhoto() {
        // TODO: - End fuction...
    }
    
    func pickImage(from view: UIViewController) {
        imagePickerController.allowsEditing = true
        
        view.present(imagePickerController, animated: true)
    }
}


extension ImagePicker: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let tempImage = info[.editedImage] as? UIImage else {
            return imagePickerController.dismiss(animated: true)
        }
        
        delegate?.imagePicker(didPickImage: tempImage)
        
        imagePickerController.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true) { [weak self] in
            self?.delegate?.imagePicker(didCancelPickingImage: picker)
        }
    }
}
