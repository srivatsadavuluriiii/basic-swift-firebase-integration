//
//  AuthenticationManager.swift
//  test
//
//  Created by thrxmbxne on 20/12/23.
//

import Foundation
import FirebaseAuth


struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoUrl: String?
    
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        
    }
}


final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    internal private(set) var isSignedOut: Bool = false

    // Method to update isSignedOut
    func updateSignInStatus(isSignedOut: Bool) {
        self.isSignedOut = isSignedOut
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func doesUserExist(email: String) async throws -> Bool {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: "")
            return true // User exists
        } catch let error as NSError {
            if error.code == AuthErrorCode.userNotFound.rawValue {
                return false // User does not exist
            } else {
                throw error
            }
        }
    }
    
    func createAccountAndSignIn(email: String, password: String) async throws -> AuthDataResultModel {
        do {
            // Check if the email already exists
            let userExists = try await doesUserExist(email: email)

            if userExists {
                throw NSError(domain: "", code: AuthErrorCode.emailAlreadyInUse.rawValue, userInfo: [NSLocalizedDescriptionKey: "Account already exists for this email."])
            }

            // Continue with the account creation and sign-in process
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            isSignedOut = false
            return AuthDataResultModel(user: authDataResult.user)
        } catch {
            throw error
        }
    }

    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        isSignedOut = false
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        isSignedOut = false
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        isSignedOut = true
    }
}

//final class AuthenticationManager{
//
//    // singleton
//    static let shared = AuthenticationManager()
//    private init() { }
//
//
//    //for logged in User
//    func getAuthenticatedUser() throws -> AuthDataResultModel {
//        guard let user = Auth.auth().currentUser else{
//            throw URLError(.badServerResponse)
//        }
//        return AuthDataResultModel(user: user)
//    }
//
//    //for new User
//    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
//        let AuthDataResult = try await Auth.auth().createUser(withEmail: email , password: password)
//        return AuthDataResultModel(user: AuthDataResult.user)
//    }
//
//
//    //for signing in
//    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
//        let AuthDataResult = try await Auth.auth().signIn(withEmail: email , password: password)
//        return AuthDataResultModel(user: AuthDataResult.user)
//
//
//    }
//
//    func resetPassword(email: String) async throws{
//        try await Auth.auth().sendPasswordReset(withEmail: email)
//    }
//
//
//
//    //for sign out/log out
//    func signOut() throws{
//        try Auth.auth().signOut()
//    }
//
//}
