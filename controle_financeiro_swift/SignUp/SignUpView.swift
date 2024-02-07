//
//  LoginView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 04/01/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack{
                    Image(systemName: "dollarsign.arrow.circlepath")
                        .resizable()
                        .frame(width: 100, height: 90)
                        .foregroundColor(.white)
                        .padding(.bottom, 24)
                    
                    Input(label: "Nome completo", bindValue: $viewModel.name)
                    Input(label: "E-mail", bindValue: $viewModel.email)
                    Input(label: "Senha", bindValue: $viewModel.password, isSecure: true)
                    Input(label: "Confirmação de senha", bindValue: $viewModel.confirmPassword, isSecure: true)
                    SubmitButton()
                }
                .padding()
                .background(Color("background"))
                .frame(minHeight: geometry.size.height)
                .alert(isPresented: $viewModel.hasError) {
                    Alert(title: Text(viewModel.errorMessage))
                }
            }
            .background(Color("background"))
        }
        .background(Color("background"))
    }
}


extension SignUpView {
    func Input(label: String, bindValue: Binding<String>, isSecure: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            if isSecure {
                SecureField("", text: bindValue)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color("gray800"))
                    .foregroundColor(.white)
                    .cornerRadius(8)                    
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(UIColor.separator), lineWidth: 1)
                    }
                    .textInputAutocapitalization(.never)
            } else {
                TextField("", text: bindValue)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color("gray800"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(UIColor.separator), lineWidth: 1)
                    }
                    .textInputAutocapitalization(.never)
            }
        }
        .padding(.vertical, 8)
    }
    
    func SubmitButton() -> some View {
        Button {
            viewModel.createUser()
        } label: {
            if viewModel.loading {
                ProgressView()
            } else {
                Text("Cadastrar")
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
        }
        .padding(.top, 24)
    }
    
    func RegisterButton() -> some View {
        Button {
            
        } label: {
            Text("Não tem uma conta? Cadastre-se")
                .foregroundColor(.white)
        }
        .padding()
        
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
