//
//  RegistrationView.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 22/06/23.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var profile: Profile
    
    @FocusState var isTextFieldFocused: Bool
    @FocusState var isPasswordFieldFocused: Bool
    @FocusState var isEmailFieldFocused: Bool
    @FocusState var isFullnameFieldFocused: Bool
    
    @State var phoneNumber: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var fullname: String = ""
    @State var faulureAlert: Bool = false
    @State var successAlert: Bool = false
    
    
    @Binding var showProgressView: Bool
    
    @StateObject var viewModel = RegistrationViewModel()
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                VStack(spacing: 30) {
                    // shu yerda
                    FullnameField(text: $fullname, title: "To'liq ism familiya")
                        .focused($isTextFieldFocused)
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    isFullnameFieldFocused = true
                                }
                        )
                    
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
                                isEmailFieldFocused = true
                            } else if newValue.count > 9 {
                                phoneNumber = String(newValue.dropLast())
                            }
                        }
                    // shu yerda
                    EmailField(text: $email, title: "Email")
                        .focused($isEmailFieldFocused)
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    isEmailFieldFocused = true
                                }
                        )
                    
                    PasswordField(text: $password, title: "Parol")
                        .focused($isPasswordFieldFocused)
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    isPasswordFieldFocused = true
                                }
                        )
                }
                .customAlert(isPresented: $successAlert) {
                    Text("You have successfully registrared!")
                } content: { } actions: {
                    Button {
//                        print("Button clicked")
                    } label: {
                        Text("OK")
                            .bold()
                    }
                }
                .customAlert(isPresented: $faulureAlert) {
                    Text("The given data was invalid.")
                } content: { } actions: {
                    Button {
//                        print("Button clicked")
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
                            isEmailFieldFocused = false
                            isFullnameFieldFocused = false
                        } label: {
                            Text("Done")
                                .bold()
                        }
                    }
                }
            }
            Spacer()
            
            Button {
                isTextFieldFocused = false
                isPasswordFieldFocused = false
                isFullnameFieldFocused = false
                isFullnameFieldFocused = false
                
                showProgressView = true
                viewModel.registerUser(phoneNumber: phoneNumber, password: password, fullname: fullname, email: email) { (result, message)  in
                    showProgressView = false
//                    print(message, "salom")
                    if result, message == "user succesfully registered" {
                        successAlert.toggle()
                        faulureAlert.toggle()
                    } else {
                        faulureAlert.toggle()
                    }
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Ro'yxatdan o'tish")
                        .bold()
                    Spacer()
                }
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .opacity(viewModel.changeButtonOpacity(phoneNumber: phoneNumber, password: password, fullname: fullname, email: email))
            .disabled(viewModel.changeButtonCondition(phoneNumber: phoneNumber, password: password, fullname: fullname, email: email))
        }
        .background(.white)
    }
}

// MARK: - Details

struct FocusedTextField: View {
    
    @FocusState private var isFocused: Bool
    @Binding var text: String
    let title: String
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text(title)
                    .foregroundColor(isFocused ? .red : .secondary)
                    .offset(y: 14)
                
                HStack(spacing: -7) {
                    Text("+998")
                    TextField("", text: $text)
                        .focused($isFocused)
                        .onChange(of: isFocused) { focused in
                            isFocused = focused
                        }
                        .frame(height: 30)
                        .padding(10)
                        .accentColor(.red)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.phonePad)
                }
                
            }
            .padding(.leading)
            
            Rectangle()
                .foregroundColor(isFocused ? .red : .secondary)
                .frame(height: isFocused ? 2 : 1)
        }
        .padding(.horizontal)
        
    }
}

struct PasswordField: View {
    
    @FocusState private var isFocused: Bool
    @Binding var text: String
    let title: String
    @State var showPassword: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text(title)
                    .foregroundColor(isFocused ? .red : .secondary)
                    .offset(y: 14)
                
                HStack {
                    
                    if showPassword {
                        TextField("", text: $text)
                            .background(.white)
                            .focused($isFocused)
                            .onChange(of: isFocused) { focused in
                                isFocused = focused
                            }
                            .frame(height: 30)
                            .padding(.vertical, 10)
                            .accentColor(.red)
                            .textContentType(.oneTimeCode)
                            .keyboardType(.asciiCapable)
                            .autocorrectionDisabled(true)
                            .focused($isFocused)
                    } else {
                        SecureField("", text: $text)
                            .background(.white)
                            .focused($isFocused)
                            .onChange(of: isFocused) { focused in
                                isFocused = focused
                            }
                            .frame(height: 30)
                            .padding(.vertical, 10)
                            .accentColor(.red)
                            .textContentType(.oneTimeCode)
                            .keyboardType(.asciiCapable)
                            .autocorrectionDisabled(true)
                            .focused($isFocused)
                    }
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                            .background(Color.white)
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                }
                
            }
            .padding(.leading)
            
            Rectangle()
                .foregroundColor(isFocused ? .red : .secondary)
                .frame(height: isFocused ? 2 : 1)
        }
        .padding(.horizontal)
    }
}


struct EmailField: View {
    
    @FocusState private var isFocused: Bool
    @Binding var text: String
    let title: String
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text(title)
                    .foregroundColor(isFocused ? .red : .secondary)
                    .offset(y: 14)
                
                TextField("", text: $text)
                    .focused($isFocused)
                    .onChange(of: isFocused) { focused in
                        isFocused = focused
                    }
                    .frame(height: 30)
                    .padding(.vertical, 10)
                    .accentColor(.red)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.emailAddress)
            }
            .padding(.leading)
            
            Rectangle()
                .foregroundColor(isFocused ? .red : .secondary)
                .frame(height: isFocused ? 2 : 1)
        }
        .padding(.horizontal)
        
    }
}


struct FullnameField: View {
    
    @FocusState private var isFocused: Bool
    @Binding var text: String
    let title: String
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text(title)
                    .foregroundColor(isFocused ? .red : .secondary)
                    .offset(y: 14)
                
                TextField("", text: $text)
                    .focused($isFocused)
                    .onChange(of: isFocused) { focused in
                        isFocused = focused
                    }
                    .frame(height: 30)
                    .padding(.vertical, 10)
                    .accentColor(.red)
                    .textContentType(.oneTimeCode)
            }
            .padding(.leading)
            
            Rectangle()
                .foregroundColor(isFocused ? .red : .secondary)
                .frame(height: isFocused ? 2 : 1)
        }
        .padding(.horizontal)
        
    }
}

struct CircularLoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    var text: String?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 2 : 0)
                
                if isShowing {
                    Rectangle()
                        .fill(Color.black).opacity(isShowing ? 0.6 : 0)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 48) {
                        ProgressView().scaleEffect(1.8, anchor: .center)
                        Text(text ?? "Loading...").font(.title3).fontWeight(.semibold)
                    }
                    .frame(width: 250, height: 200)
                    .background(Color.white)
                    .foregroundColor(Color.primary)
                    .cornerRadius(16)
                }
            }
        }
    }
}
