//
//  ContentView.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI

struct ContentView: View {
    //選択されたステージ
    @State var selected_STAGE = 1
    //画面遷移
    @State private var showShould_main_View = false
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: main_View(), isActive: $showShould_main_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                
                HStack{
                    Image("money").resizable().frame(width: 70, height: 70)
                    Text("\(coin)").font(.largeTitle).fontWeight(.black)
                    Spacer()
                    Button(action: {
                        print("Button")
                    }) {
                        Image(systemName: "cart.fill")
                            .padding()
                            .frame(width: 70, height: 70)
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                    Button(action: {
                        print("Button")
                    }) {
                        Image(systemName: "gearshape.fill")
                            .padding()
                            .frame(width: 70, height: 70)
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                Spacer()
                HStack{
                    Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100)
                    Text("ひよこゲーム").font(.largeTitle).fontWeight(.black).foregroundColor(.yellow)
                    Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).rotation3DEffect(.degrees(180), axis: (0, 1, 0))
                }
                Text("ステージ選択").padding().fontWeight(.black)
                ScrollView(.horizontal) {
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.gray)
                                .frame(width: 250, height: 200)
                            VStack{
                                Text("STAGE1").font(.title2).fontWeight(.black)
                                Button(action: {
                                    selected_STAGE = 1
                                }) {
                                    HStack {
                                        Text("選択")
                                    }
                                }.buttonStyle(BlueButtonStyle())
                            }
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.gray)
                                .frame(width: 250, height: 200)
                            VStack{
                                Text("STAGE2").font(.title2).fontWeight(.black)
                                Button(action: {
                                    selected_STAGE = 2
                                }) {
                                    HStack {
                                        Text("選択")
                                    }
                                }.buttonStyle(BlueButtonStyle())
                            }
                        }
                    }
                }
                Spacer()
                //スタートボタン
                Text("STAGE\(selected_STAGE)").font(.largeTitle).fontWeight(.black)
                Button(action: {
                    showShould_main_View = true
                }) {
                    Text("START")
                        .bold()
                        .padding()
                        .frame(width: 200, height: 100)
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight:.bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(5)
            .background(Color.blue.opacity(0.8))
            .cornerRadius(20)
            .shadow(color:.black, radius: 4)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
