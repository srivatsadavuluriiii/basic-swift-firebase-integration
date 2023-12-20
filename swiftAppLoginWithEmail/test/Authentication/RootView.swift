//
// RootView.swift
// test
//
// Created by thrxmbxne on 20/12/23.


import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false

    var body: some View {
        NavigationStack {
            if !AuthenticationManager.shared.isSignedOut {
                // User is signed in, navigate to SettingsView
                Settingsview(showSignInView: $showSignInView)
            } else {
                // User is signed out, show AuthenticationView
                AuthenticationView(showSignInView: $showSignInView)
                    .onAppear {
                        // Check if user is already signed in
                        checkSignInStatus()
                    }
            }
        }
        .fullScreenCover(isPresented: $showSignInView) {
            if showSignInView {
                NavigationStack {
                    AuthenticationView(showSignInView: $showSignInView)
                }
            }
        }
    }

    private func checkSignInStatus() {
        do {
            _ = try AuthenticationManager.shared.getAuthenticatedUser()
            // User is already signed in, update isSignedOut accordingly
            AuthenticationManager.shared.updateSignInStatus(isSignedOut: false)
        } catch {
            // User is signed out, update isSignedOut accordingly
            AuthenticationManager.shared.updateSignInStatus(isSignedOut: true)
        }
    }
}

#Preview {
    RootView()
}
