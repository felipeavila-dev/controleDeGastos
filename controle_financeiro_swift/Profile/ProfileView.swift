//
//  ProfileView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 23/01/24.
//

import SwiftUI
import PhotosUI


struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        
        ScrollView {
            Header()
            InformationArea(name: viewModel.userData.name, email: viewModel.userData.email)
            LogoutButton()
        }
        .onAppear {
            viewModel.getUserProfile()
            viewModel.getUserImage()
        }
        .onChange(of: viewModel.selectedPhoto, perform: { value in
            Task {
                if let data = try? await value?.loadTransferable(type: Data.self) {
                    viewModel.userPhoto = data
                }
            }
        })
        .onChange(of: viewModel.userPhoto, perform: { value in
            viewModel.handleUploadPhoto()
        })
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("background"))
        
    }
}

extension ProfileView {
    func Header() -> some View {
        VStack {
            if viewModel.loadingPhoto {
                HStack {
                    ProgressView()
                        .tint(.white)
                }
                .frame(width: 90, height: 90)
                
            } else {
                AsyncImage(url: URL(string: viewModel.userImage)) { image in
                    image.image?.resizable()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                }
            }
            
            if viewModel.uploadingPhoto {
                Text("Enviando imagem...")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            } else {
                PhotosPicker(selection: $viewModel.selectedPhoto, matching: .images ) {
                    Text("Alterar imagem")
                        .bold()
                        .foregroundColor(.orange)
                        .padding()
                }
            }
            
            
        }
    }
    
    func InformationArea(name: String, email: String) -> some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text("Nome:")
                    .foregroundColor(.white)
                    .bold()
                
                Text(name)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .background(Color.gray)
            
            VStack(alignment: .leading) {
                Text("Email:")
                    .foregroundColor(.white)
                    .bold()
                
                Text(email)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .background(Color.gray)
        }
    }
    
    func LogoutButton() -> some View {
        Button(action: {
            viewModel.handleLogout()
        }, label: {
            Text("Desconectar")
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.red)
                .cornerRadius(8)
                .foregroundColor(.white)
                .bold()
                .padding(.top, 60)
        })
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
