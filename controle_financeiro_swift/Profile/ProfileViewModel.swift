//
//  ProfileViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 23/01/24.
//

import Foundation
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import _PhotosUI_SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userData = ProfileModel(name: "", email: "")
    @Published var selectedPhoto: PhotosPickerItem? = nil
    @Published var userPhoto: Data? = nil
    @Published var userImage: String = ""
    @Published var loadingPhoto: Bool = false
    @Published var uploadingPhoto: Bool = false
    
    func handleUploadPhoto() {
        self.uploadingPhoto = true
        self.loadingPhoto = true
        
        let userId = Auth.auth().currentUser?.uid
        
        let ref = Storage.storage().reference(withPath: "images/\(userId!).jpg")
        let newMetaData = StorageMetadata()
        newMetaData.contentType = "image/jpeg"
        
        if let userPhoto = userPhoto {
            ref.putData(userPhoto, metadata: newMetaData) { metadata, err in
                ref.downloadURL { url, err in                    
                    self.userImage = url?.absoluteString ?? ""
                    self.uploadingPhoto = false
                    self.loadingPhoto = false
                }
            }
        }
        
        self.uploadingPhoto = false
        self.loadingPhoto = false
    }
    
    func getUserImage() {
        self.loadingPhoto = true
        
        let userId = Auth.auth().currentUser?.uid
    
        Storage.storage().reference(withPath: "images").listAll { StorageListResult, Error in
            for photo in StorageListResult!.items {
                if photo.name == "\(userId!).jpg" {
                    photo.downloadURL { url, err in
                        self.userImage = url!.absoluteString
                        self.loadingPhoto = false
                    }
                }
            }
        }
        
        self.uploadingPhoto = false
        self.loadingPhoto = false
    }
    
    func getUserProfile() {
        let userId = Auth.auth().currentUser?.uid
        
        Firestore.firestore()
            .collection("user")
            .document(userId!)
            .getDocument { document, error in
                if error != nil {
                    return
                }
                
                let user = ProfileModel(name: document?.data()?["name"] as! String,
                                        email: document?.data()?["email"] as! String)
                
                self.userData = user
            }
    }
    
    func handleLogout() {
        try! Auth.auth().signOut()
    }
}
