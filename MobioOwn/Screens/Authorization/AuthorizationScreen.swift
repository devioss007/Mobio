//
//  AuthorizationScreen.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import SwiftUI

struct AuthorizationScreen: View {
    
    @EnvironmentObject var profile: Profile
    
    @State var selectedTab: Int = 0
    @State var showProgressView: Bool = false
    private let tabs = ["Login", "Register"]
        
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                // MARK: - Header View
                HeaderView()
                    .padding(EdgeInsets(top: 40, leading: 30, bottom: 30, trailing: 30))
                
                // MARK: - Tabview
                ScrollViewReader { scrollProxy in
                    HStack {
                        ForEach(0..<tabs.count, id: \.self) { i in
                            tabButton(index: i)
                                .modifier(if: i == selectedTab) { content in
                                    content
                                        .anchorPreference(
                                            key: AnchorPreferenceKey.self,
                                            value: .bounds
                                        ) { $0 }
                                }
                        }
                    }
                    .onChange(of: selectedTab, perform: { selectedTab in
                        let normalized: CGFloat = CGFloat(selectedTab) / CGFloat(tabs.count)
                        withAnimation(.easeInOut) {
                            scrollProxy.scrollTo(selectedTab, anchor: UnitPoint(x: normalized, y: 0))
                        }
                    })
                }
                .backgroundPreferenceValue(AnchorPreferenceKey.self) { anchor in
                    if let anchor {
                        GeometryReader { geometry in
                            VStack {
                                Spacer()
                                underline(bounds: geometry[anchor])
                            }
                        }
                    }
                }
                
                // MARK: - You can put views here
                TabView(selection: $selectedTab) {
                    // MARK: - Login View
                    LoginView(showProgressView: $showProgressView).tag(0)
                    
                    // MAKR: - Registration View
                    RegistrationView().tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .animation(.easeInOut, value: selectedTab)
            
            CircularLoadingView(isShowing: $showProgressView, content: {
                VStack { }
            }, text: "Loading...")
        }
    }
    
    private func tabButton(index: Int) -> some View {
        Button {
            selectedTab = index
        } label: {
            Text(tabs[index])
                .fontWeight(.bold)
                .foregroundColor(selectedTab == index ? .primary : .gray)
        }
        .id(index)
        .padding()
    }
    
    private func underline(bounds: CGRect) -> some View {
        let padding: CGFloat = 20
        return Rectangle()
            .fill(.red)
            .cornerRadius(5 / 2)
            .offset(x: bounds.minX + padding / 2, y: bounds.minY - 4)
            .frame(width: bounds.width - padding, height: 3)
    }
    
    private struct AnchorPreferenceKey: PreferenceKey {
        static var defaultValue: Anchor<CGRect>? = nil
        static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
            value = nextValue()
        }
    }
}

private extension View {
    @ViewBuilder func modifier<Content: View>(
        if shouldModify: Bool,
        modifier: (Self) -> Content
    ) -> some View {
        if shouldModify {
            modifier(self)
        } else { self }
    }
}

struct AuthorizationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationScreen()
    }
}


fileprivate struct HeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("Logo")
            Text("Mobio mobil ilovasiga xush\nkelibsiz")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
