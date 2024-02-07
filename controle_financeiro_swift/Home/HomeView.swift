//
//  HomeView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 08/01/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            TabView {
                DashboardView(viewModel: DashboardViewModel())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }                    
                
                ReportView(viewModel: ReportViewModel())
                    .tabItem {
                        Label("Relatório", systemImage: "list.bullet.clipboard.fill")
                    }
                
                ProfileView(viewModel: ProfileViewModel())
                    .tabItem {
                        Label("Perfil", systemImage: "person.fill")
                    }
            }
            .tint(Color.brown)
            .onAppear {
                UITabBar.appearance().barTintColor = UIColor(.white)
            }
        }        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
