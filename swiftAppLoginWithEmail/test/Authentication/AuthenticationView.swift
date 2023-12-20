//
//  AuthenticationView.swift
//  test
//
//  Created by thrxmbxne on 20/12/23.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        VStack{
            NavigationLink{
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
        
    }
}

    struct AuthenticationView_Previews: PreviewProvider {
        static var previews: some View {
            let showSignInView = Binding.constant(false)

            return NavigationView {
                AuthenticationView(showSignInView: showSignInView)
                    .fullScreenCover(isPresented: showSignInView) {
                        AuthenticationView(showSignInView: showSignInView)
                    }
            }
        }
    }
