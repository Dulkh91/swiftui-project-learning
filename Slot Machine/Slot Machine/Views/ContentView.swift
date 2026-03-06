//
//  ContentView.swift
//  Slot Machine
//
//  Created by Ros Dul on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTY
    let symbols = ["gfx-bell","gfx-cherry", "gfx-coin","gfx-grape","gfx-seven", "gfx-strawberry"]
    
    @State private var hightScore: Int = UserDefaults.standard.integer(forKey: "HightScore")
    @State private var coins: Int = 100
    @State private var betAmoun: Int = 10
    @State private var reels: Array = [0,1,2]
    
    @State private var isShowingInfo: Bool = false
    @State private var isActiveBet20: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isShowingModel: Bool = false
    @State private var animateSymbol: Bool = false
    @State private var animateModel: Bool = false
     
    //MARK: - FUNCTION
    func spinReels(){
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
        playerAudio(soundName: "spin", type: "mp3")
    }
    
    //MARK: - CHECKWINNER
    func checkWinning(){
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2]{
            //PLAYER WINS
            playerWin()
            //NEW HIGHT SCORE
            if coins > hightScore{
                newHightScore()
            }else{
                playerAudio(soundName: "win", type: "mp3")
            }
        }else{
            //PLAYER LOSE
            playerLose()
        }
    }
    
    func playerWin(){
        coins += betAmoun * 10
        
        //playerAudio(soundName: "win", type: "mp3")
    }
    
    func newHightScore(){
        hightScore = coins
        UserDefaults.standard.set(hightScore, forKey: "HightScore")
        playerAudio(soundName: "high-score", type: "mp3")
    }
    
    func playerLose(){
        coins -= betAmoun
        
    }
    
    func activeBet20(){
        betAmoun = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    func activeBet10(){
        betAmoun = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    
    func isGameOver(){
        if coins <= 0{
            // SHOW MODEL WINDOW
            isShowingModel = true
            playerAudio(soundName: "game-over", type: "mp3")
        }
    }
    
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "HightScore")
        coins = 100
        hightScore = 0
        playerAudio(soundName: "chimeup", type: "mp3")
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack{
            // Background color
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"),Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            
            //MARK: - INTERFACE
            VStack{
            //MARK: - HEADER
                LogoView()
                Spacer()
            //MARK: - SCORE
                HStack {
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack{
                        Text("\(hightScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("Hight\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                        
                    }
                    .modifier(ScoreContainerModifier())
                }
                
               
            //MARK: - SLOT MACHINE
                VStack{
                    //MARK: - REEL #1
                    ZStack{
                        ReelView()
                        
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            
                            .offset(y: animateSymbol ? 0 : -50)
                            .opacity(animateSymbol ? 1 : 0 )
                            .animation(.easeIn(duration: Double.random(in: 0.5...0.7)),
                                       value: animateSymbol)
                            .onAppear {
                                self.animateSymbol.toggle()
                                playerAudio(soundName: "riseup", type: "mp3")
                            }
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        //MARK: - REEL #2
                        ZStack{
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animateSymbol ? 1 : 0)
                                .offset(y: animateSymbol ? 0 : -50)
                                .animation(.easeInOut(duration: Double.random(in: 0.7...0.9)),
                                           value: animateSymbol)
                                .onAppear {
                                    self.animateSymbol.toggle()
                                }
                        }
                        
                        Spacer()
                        //MARK: - REEL #3
                        ZStack{
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animateSymbol ? 1 : 0)
                                .offset(y: animateSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)),
                                           value: animateSymbol)
                                .onAppear {
                                    self.animateSymbol.toggle()
                                }
                        }
                    }//: HSTACK
                    
                    //MARK: - SPIN
                    Button {
                        // animate of SLOT MACHIN while click spin
                        withAnimation {
                            self.animateSymbol = false
                        }
                        
                        
                       //SPIN THE REELS
                        spinReels()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                            withAnimation {
                                self.animateSymbol = true
                            }
                        }
                        
                        
                        // CHECK WINNING
                        self.checkWinning()
                        
                        // GameOver
                        isGameOver()
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }

                    
                }//: VSTACK
                
            //MARK: - FOOTER
                HStack {
                    // BET 20
                    Button {
                        withAnimation(.spring) {
                            self.activeBet20()
                            playerAudio(soundName: "casino-chips", type: "mp3")
                        }
                    } label: {
                        Text("20")
                            .fontWeight(.heavy)
                            .foregroundColor(isActiveBet20 ? Color.yellow : Color.white)
                            .modifier(BetNumberModifier())
                        
                    }
                    .modifier(BetCapsuleModifier())
                    
                    // Casino chips
                    Image("gfx-casino-chips")
                        .resizable()
                        .opacity(isActiveBet20 ? 1 : 0)
                        .modifier(CasinoChipsModifier())
                    
                    
                    // Casino chips
                    Image("gfx-casino-chips")
                        .resizable()
                        .opacity(isActiveBet10 ? 1 : 0)
                        .modifier(CasinoChipsModifier())
                    // BET 10
                    Button {
                        withAnimation(.spring) {
                            self.activeBet10()
                            playerAudio(soundName: "casino-chips", type: "mp3")
                        }
                    } label: {
                        Text("10")
                            .fontWeight(.heavy)
                            .foregroundColor(isActiveBet10 ? Color.yellow : Color.white)
                            .modifier(BetNumberModifier())
                        
                    }
                    .modifier(BetCapsuleModifier())
                    
                    
                }//: Hstack

                Spacer()
            }//: Vstack
            .overlay(alignment: .top){
                // RESET
                HStack {
                    Button {
                       resetGame()
                        
                    } label: {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle")
                            .modifier(ButtonModifier())
                    }
                    Spacer()
                    // INFO
                    Button {
                        isShowingInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .modifier(ButtonModifier())
                    }
                    
                }//: Hstack
            }//: Overlay
            .padding()
            .blur(radius: $isShowingModel.wrappedValue ? 5 : 0 , opaque: false)
            
            //MARK: - POPUP
            if $isShowingModel.wrappedValue{
                ZStack{
                    Color("ColorTransparentBlack").ignoresSafeArea(.all)
                    
                    VStack{
                        Text("game over".uppercased())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        
                        Spacer()
                        VStack{
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 72)
                            
                            Text("Bad luck! You lose of the coins. \nLet's play again.")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button {
                                self.isShowingModel = false
                                self.animateModel = false
                                activeBet10()
                                self.coins = 100
                            } label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .accentColor(Color("ColorPink"))
                                    .frame(minWidth: 120)
                                    .padding(.horizontal,12)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule()
                                            .stroke(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                                    
                            }

                        }
                        Spacer()
                        
                    }
                    .frame(minWidth: 280,
                           idealWidth: 280,
                           maxWidth: 320,
                           minHeight: 260,
                           idealHeight: 280,
                           maxHeight: 320,
                           alignment: .center
                    )
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6,x:0,y: 8)
                    .opacity($animateModel.wrappedValue ? 1:0)
                    .offset(y: $animateModel.wrappedValue ? 0: -100)
                    .animation(.spring(response: 0.6, dampingFraction: 1.0,blendDuration: 1.0), value: animateModel)
                    .onAppear {
                        self.animateModel = true
                    }
                }
            }
            
        }//: Zstack
        .sheet(isPresented: $isShowingInfo) {
            InforView()
        }
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}

