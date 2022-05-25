//
//  ContentView.swift
//  Restart
//
//  Created by Alif Khosyi Rahmatullah on 04/01/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onBoarding") var onBoardingIsActive : Bool = true
    
    var body: some View {
        if onBoardingIsActive {
            OnBoardingView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
