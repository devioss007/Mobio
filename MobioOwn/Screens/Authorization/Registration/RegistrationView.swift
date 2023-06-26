//
//  RegistrationView.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 22/06/23.
//

import SwiftUI

struct RegistrationView: View {
    var body: some View {
        Text("RegistrationView")
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}


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
