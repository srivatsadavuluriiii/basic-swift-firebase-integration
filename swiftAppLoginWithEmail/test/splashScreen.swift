//
//  SplashScreen.swift
//  test
//
//  Created by thrxmbxne on 20/12/23.
//

import SwiftUI

struct splashScreen: View {
    var body: some View {
        VStack {
            Image("your_custom_image_name") // Replace with your image name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100) // Adjust the size as needed
            
            Text("AppName")
                .font(.headline)
                .padding(.top, 16)
            
        }
        .onAppear {
            // Add a delay of 2 seconds before transitioning
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // Replace "RootView()" with your main screen
                // For example, if your main screen is ContentView(), replace it accordingly
                NavigationStack {
                    RootView()
                }
            }


        }
    }
}

struct splashScreen_Previews: PreviewProvider {
    static var previews: some View {
        splashScreen()
    }
}
