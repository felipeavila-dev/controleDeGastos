//
//  ContentView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 04/01/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

class ContentViewModel {
    @Published var isLogged = false
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
