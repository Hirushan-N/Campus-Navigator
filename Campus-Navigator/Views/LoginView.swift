//
//  LoginView.swift
//  Campus-Navigator
//
//  Created by Nadeesh Hirushan on 2025-02-23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isHomeActive = false
    @State private var rememberMe = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Spacer(minLength: 50)

                // Logo with rounded corners (No extra padding or separate rectangle)
                Image("navigation_logo") // Ensure the logo is added in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100) // Maintain the correct size
                    .cornerRadius(20) // Apply rounded corners directly to the image
                    .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4) // Optional shadow
                    .padding(.bottom, 15)

                // "Hello" (Blue) and "There!" (Black, Bold)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Hello")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("There!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 30)

                // Description text centered
                Text("Sign in now and start exploring all that our app has to offer. We're excited to welcome you to our community!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 30)

                Spacer(minLength: 10)

                // Email Input Field
                VStack(alignment: .leading, spacing: 5) {
                    Text("Enter Email")
                        .font(.footnote)
                        .foregroundColor(.black)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Enter your email address", text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
                }
                .padding(.horizontal, 30)

                // Password Input Field
                VStack(alignment: .leading, spacing: 5) {
                    Text("Enter Password")
                        .font(.footnote)
                        .foregroundColor(.black)

                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("Enter your password", text: $password)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
                }
                .padding(.horizontal, 30)

                // Remember Me & Forgot Password
                HStack {
                    Toggle(isOn: $rememberMe) {
                        Text("Remember me")
                            .font(.footnote)
                    }
                    .toggleStyle(CheckboxToggleStyle())

                    Spacer()

                    Button(action: {
                        // Forgot Password Action
                    }) {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 30)

                // Sign In Button
                Button(action: {
                    isHomeActive = true
                }) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(30) // Fully rounded corners
                        .padding(.horizontal, 30)
                }
                .padding(.top, 10)

                Spacer(minLength: 40) // Bottom spacing
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(destination: HomeView(), isActive: $isHomeActive) {
                    EmptyView()
                }
            )
        }
    }
}

// Custom Checkbox Toggle Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
