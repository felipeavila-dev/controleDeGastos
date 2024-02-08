//
//  NewExpenseView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 15/01/24.
//

import SwiftUI

struct NewExpenseView: View {
    @ObservedObject var viewModel: NewExpenseViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            Text("Cadastro")
                .foregroundColor(.white)
                .font(.title2)
                .bold()
            
            Spacer()
                .padding(.vertical, 20)
            
            VStack(spacing: 16) {
                input(placeholder: "Título", bindingValue: $viewModel.title)
                input(placeholder: "R$ 0,00", bindingValue: $viewModel.value)
                
                DatePicker("Data:", selection: $viewModel.date, displayedComponents: DatePickerComponents.date)
                    .datePickerStyle(.compact)
                    .foregroundColor(.white)
                    .colorScheme(.dark)
                    .environment(\.locale, Locale.init(identifier: "pt_BR"))
                
                HStack(spacing: 8) {
                    Button {
                        viewModel.expenseType = 0
                    } label: {
                        Text("Receita")
                            .padding(6)
                            .frame(maxWidth: .infinity)
                            .background(viewModel.expenseType == 0 ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .bold()
                            .cornerRadius(4)
                    }

                    Spacer()
                    
                    Button {
                        viewModel.expenseType = 1
                    } label: {
                        Text("Despesa")
                            .padding(6)
                            .frame(maxWidth: .infinity)
                            .background(viewModel.expenseType == 1 ? Color.red : Color.gray)
                            .foregroundColor(.white)
                            .bold()
                            .cornerRadius(4)
                    }
                }
 
                if viewModel.hasError {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                                          
                Button {
                    viewModel.registerData()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cadastrar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .bold()
                }
                .padding(.vertical, 40)
                                                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
        
    }
    
}

extension NewExpenseView {
    func input(placeholder: String, bindingValue: Binding<String>) -> some View {
        TextField("",
                  text: bindingValue,
                  prompt: Text(placeholder).foregroundColor(.gray)
        )
        .autocorrectionDisabled(true)
        .padding(12)
        .background(Color("gray800"))
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct NewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseView(viewModel: NewExpenseViewModel())
    }
}
