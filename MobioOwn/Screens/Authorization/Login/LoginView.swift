//
//  LoginView.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 22/06/23.
//

import SwiftUI
import CustomAlert

struct LoginView: View {
    @EnvironmentObject var profile: Profile

    @FocusState var isTextFieldFocused: Bool
    @FocusState var isPasswordFieldFocused: Bool

    @State var phoneNumber: String = ""
    @State var password: String = ""
    @State var showAlert: Bool = false

    @Binding var showProgressView: Bool
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        VStack {
            
            VStack(spacing: 30) {
                FocusedTextField(text: $phoneNumber, title: "Telefon raqam")
                    .focused($isTextFieldFocused)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                isTextFieldFocused = true
                            }
                    )
                    .onChange(of: phoneNumber) { newValue in
                        if newValue.count == 9 {
                            isPasswordFieldFocused = true
                        } else if newValue.count > 9 {
                            phoneNumber = String(newValue.dropLast())
                        }
                    }
                PasswordField(text: $password, title: "Parol")
                    .focused($isPasswordFieldFocused)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                isPasswordFieldFocused = true
                            }
                    )
            }
            .customAlert(isPresented: $showAlert) {
                Text("Your password or login is incorrect.")
            } content: { } actions: {
                Button {
                    print("Button clicked")
                } label: {
                    Text("OK")
                        .bold()
                }
            }
            .background(Color.white)
            .padding(.top, 60)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                    isTextFieldFocused = false
                    isPasswordFieldFocused = false
                    } label: {
                        Text("Done")
                            .bold()
                    }
                }
            }

            Spacer()
            
            Button {
                isTextFieldFocused = false
                isPasswordFieldFocused = false
                
                showProgressView = true
                viewModel.authenticateUser(phoneNumber: phoneNumber, password: password) { result in
                    showProgressView = false
                    if result {
                        profile.isUserLoggedIn = true
                    } else {
                        showAlert.toggle()
                    }
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Login")
                        .bold()
                    Spacer()
                }
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .opacity(viewModel.changeButtonOpacity(phoneNumber: phoneNumber, password: password))
            .disabled(viewModel.changeButtonCondition(phoneNumber: phoneNumber, password: password))
        }
        .background(.white)
    }
}
