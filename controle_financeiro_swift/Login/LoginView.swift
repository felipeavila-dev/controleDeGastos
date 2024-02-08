//
//  LoginView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 04/01/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "dollarsign.arrow.circlepath")
                    .resizable()
                    .frame(width: 100, height: 90)
                    .foregroundColor(.white)
                    .padding(.bottom, 24)
                
                
                Input(label: "E-mail", bindValue: $viewModel.email)
                Input(label: "Senha", bindValue: $viewModel.password, isSecure: true)
                SubmitButton()
                RegisterButton()
            }
            .navigationTitle("Login")
            .navigationBarHidden(true)            
            .padding()
            .frame(maxHeight: .infinity)
            .background(Color("background"))
            .alert(isPresented: $viewModel.hasError) {
                Alert(title: Text(viewModel.errorMessage))
            }
        }        
    }
}





extension LoginView {
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
            viewModel.doLogin()
        } label: {
            Text("Entrar")
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.top, 24)
    }
    
    func RegisterButton() -> some View {
        NavigationLink {
            SignUpView(viewModel: SignUpViewModel())
        } label: {
            Text("Não tem uma conta? Cadastre-se")
                .foregroundColor(Color.white)
                
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
