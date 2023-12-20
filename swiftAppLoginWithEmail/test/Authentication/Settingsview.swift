//
//  Settingsview.swift
//  test
//
//  Created by thrxmbxne on 20/12/23.
//

import SwiftUI
@MainActor
final class SettingsViewModel: ObservableObject {

    func signOut() throws {
        print("Trying to sign out...")
        try AuthenticationManager.shared.signOut()
        print("Signed out successfully.")
    }

    func resetPassword() async throws {
        print("Trying to reset password...")
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
        print("Password Reset Successfully.. ")
    }
}

struct Settingsview: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationView {
            List {
                Button("Sign Out") {
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInView = true
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .fullScreenCover(isPresented: $showSignInView) {
            LandingView(showSignInView: $showSignInView)
        }
    }
}


#Preview {
    Settingsview(showSignInView: .constant(false))
}
