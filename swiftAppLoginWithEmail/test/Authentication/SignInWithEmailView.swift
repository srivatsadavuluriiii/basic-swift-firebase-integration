//
//  SignInEmailView.swift
//  test
//
//  Created by thrxmbxne on 20/12/23.
//

import SwiftUI
import FirebaseAuth
@MainActor
final class SignInWithEmailViewModel: ObservableObject {
    //for email and password tetx fields
    @Published var email = ""
    @Published var password = ""
    
    func signUp(onSuccess: @escaping () -> Void) async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No email and password found."])
        }

        do {
            // Continue with the account creation and sign-in process
            let returnedUserData = try await AuthenticationManager.shared.createAccountAndSignIn(email: email, password: password)
            print("Success")
            print(returnedUserData)

            // Call the onSuccess closure
            onSuccess()
        } catch let error as NSError {
            if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                throw NSError(domain: "", code: AuthErrorCode.emailAlreadyInUse.rawValue, userInfo: [NSLocalizedDescriptionKey: "Account already exists for this email."])
            } else {
                throw error
            }
        }
    }
    
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else{
            print("No email and passowrd found.")
            return
        }
        do {
            let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
            print("Success")
            print(returnedUserData)
        }
        catch {
            print("Error :\(error)")
        }
    }
}


struct SignInEmailView: View {
    @Binding var showSignInView: Bool
    
    // initialize class
    @StateObject private var ViewModel = SignInWithEmailViewModel()
    var body: some View {
        VStack{
            
            TextField("email ...", text: $ViewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("password...", text: $ViewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        // Perform the sign-up operation
                        try await ViewModel.signUp {
                            // Handle success, for example, navigate to the next screen
                            // NavigationStack { NextScreen() }
                            showSignInView = false
                        }
                    } catch {
                        // Handle any errors that might occur during the sign-up
                        print("Error during sign-up: \(error)")
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
            
        }.navigationTitle("Sign In with Email")
        .padding()
       
    }
}



struct SignInEmailView_Previews: PreviewProvider{
    static var previews: some View{
        SignInEmailView(showSignInView: .constant(false))
    }
}


