//
//  SplashView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 08/01/24.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLogged {
                HomeView(viewModel: HomeViewModel())
            } else {
                LoginView(viewModel: LoginViewModel())
            }
        }        
        .onAppear {
            viewModel.checkLoggedUser()
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
    }
}
