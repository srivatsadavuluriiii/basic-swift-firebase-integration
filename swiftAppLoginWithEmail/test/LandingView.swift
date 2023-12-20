//
//  LandingView.swift
//  test
//
//  Created by thrxmbxne on 20/12/23.
//

import SwiftUI

struct LandingView: View {
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Demo App")
                .font(.title)
                .padding()
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    showSignInView = true
                }
            }) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LandingView(showSignInView: .constant(false))
        }
    }
}
