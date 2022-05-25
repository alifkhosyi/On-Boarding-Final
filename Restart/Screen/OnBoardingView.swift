//
//  OnBoardingView.swift
//  Restart
//
//  Created by Alif Khosyi Rahmatullah on 04/01/22.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onBoarding") var onBoardingIsActive : Bool = true
    
    @State private var buttonWidth : CGFloat = UIScreen.main.bounds.width - 80
    @State private var buttonOffset : CGFloat = 0
    @State private var isAnimation : Bool  = false
    @State private var imageOffset : CGSize = CGSize(width: 0, height: 0)
    @State private var indicatorOppacity : Double = 1.0
    @State private var indicatorTitle : String = "Share It."
    
    var body: some View {
        ZStack{
            Color("BlueColor")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing:20){
                
            VStack{
                Text(indicatorTitle)
                    .font(.system(size: 60))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .transition(.opacity)
                    .id(indicatorTitle)
                
                Text("Its not how much we give but how much love we put into giving")
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                }
            .opacity(isAnimation ? 1 : 0)
            .offset(y: isAnimation ? 0 : -15)
            .animation(.easeOut(duration: 1), value: isAnimation)
                
                ZStack {
                    ZStack{
                        Circle()
                            .stroke(Color.white, lineWidth: 40)
                            .opacity(0.2)
                            .frame(width: 260, height: 260, alignment: .center)
                        Circle()
                            .stroke(Color.white, lineWidth: 80)
                            .opacity(0.2)
                            .frame(width: 260, height: 260, alignment: .center)
                    }
                    .blur(radius: isAnimation ? 0 : 10)
                    .opacity(isAnimation ? 1 : 0)
                    .scaleEffect(isAnimation ? 1 : 0.5)
                    .animation(.easeOut(duration: 1), value: isAnimation)
                    .offset(x: imageOffset.width * -1)
                    .blur(radius: abs(imageOffset.width/5))
                    .animation(.easeOut(duration: 1), value: imageOffset)
                    .onAppear(perform: {
                        isAnimation = true
                    })
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimation ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimation)
                        .offset(x : imageOffset.width * 1.2, y: 0 )
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(DragGesture()
                                    .onChanged { gesture in
                                        if abs(imageOffset.width) <= 150 {
                                            imageOffset = gesture.translation
                                            
                                            withAnimation (.linear(duration: 0.25)){
                                                indicatorOppacity = 0
                                                indicatorTitle = "Give."
                                            }
                                        }
                                    }
                                    .onEnded({ _ in
                                        imageOffset = .zero
                                        
                                        withAnimation (.linear(duration: 0.25)){
                                            indicatorOppacity = 1
                                            indicatorTitle = "Share It."
                                        }
                                    })
                        ).animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 34, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 10)
                        .opacity(isAnimation ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimation)
                        .opacity(indicatorOppacity)
                    ,alignment: .bottom
                )
                
                ZStack{
                    Capsule()
                        .fill(Color.white)
                        .opacity(0.2)
                    Capsule()
                        .fill(Color.white)
                        .opacity(0.2)
                        .padding(8)
                    
               
                        HStack{
                           Capsule()
                            .fill(Color("RedColor"))
                            .frame(width: buttonOffset + 80 )
                            
                            Spacer()
                        }
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("RedColor"))
                            Circle()
                                .fill(Color.black)
                                .opacity(0.2)
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                                
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                        DragGesture()
                            .onChanged{ gesture in
                                if gesture.translation.width > 0 &&
                                    buttonOffset <= buttonWidth - 80 {
                                    buttonOffset = gesture.translation.width
                                }
                            }.onEnded{ _ in
                                withAnimation(Animation.easeOut(duration: 0.5)){
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        onBoardingIsActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                }
                            }
                        )
                        Spacer()
                    }
                    Text("Get Started")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .offset(x: 20)
               
                    
                }
                .frame(width: buttonWidth ,height: 80, alignment: .center)
                .opacity(isAnimation ? 1 : 0)
                .offset(y: isAnimation ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimation)
                .padding()
            }
            .padding()
            
            
        }
        .onAppear(perform: {
            isAnimation = true
        })
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
