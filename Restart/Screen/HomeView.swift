//
//  HomeView.swift
//  Restart
//
//  Created by Alif Khosyi Rahmatullah on 04/01/22.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onBoarding") var onBoardingIsActive : Bool = false
    @State private var isAnimating : Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            ZStack {
                ZStack{
                    Circle()
                        .stroke(Color.gray, lineWidth: 40)
                        .opacity(0.2)
                        .frame(width: 260, height: 260, alignment: .center)
                    Circle()
                        .stroke(Color.gray, lineWidth: 80)
                        .opacity(0.2)
                        .frame(width: 260, height: 260, alignment: .center)
                }
                .blur(radius: isAnimating ? 0 : 10)
                .scaleEffect(isAnimating ? 1 : 0.5)
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeOut(duration: 1), value:  isAnimating)
                .onAppear(perform: {
                    isAnimating = true
                })
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 25 : -25)
                    .animation(Animation
                                .easeOut(duration: 4)
                                .repeatForever()
                ,value: isAnimating)
            }
            
            Text("The time that leads to mastery is dependent on the intensity of our focus")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                .onAppear(perform: {
                    isAnimating = true
                })
            
            Spacer()
            
            
            ZStack{
                Capsule()
                    .fill(Color("BlueColor"))
                
                HStack(spacing: 15){
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .font(.system(size: 24))
                    
                    Text("Restart")
                        .font(.system(size: 18))
                        .fontWeight(.heavy)
                    
                }
            }.frame(width: 150, height: 50, alignment: .center)
            .foregroundColor(.white)
            .onTapGesture {
                self.onBoardingIsActive = true
            }
        }
        .onAppear(perform: {
                isAnimating  = true
            
        })
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
