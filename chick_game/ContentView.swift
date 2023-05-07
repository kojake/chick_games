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
    @State private var showShould_shop_View = false
    @State private var showShould_dressing_up_View = false
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: main_View(), isActive: $showShould_main_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                NavigationLink(destination: shop_View(), isActive: $showShould_shop_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                NavigationLink(destination: dressing_up_View(), isActive: $showShould_dressing_up_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                
                HStack{
                    Spacer()
                    Button(action: {
                        showShould_shop_View = true
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
                        showShould_dressing_up_View = true
                    }) {
                        Image(systemName: "arrow.left.arrow.right.square.fill")
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
                Text("ステージ選択").padding().fontWeight(.black).font(.largeTitle)
                ScrollView(.horizontal) {
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.gray)
                                .frame(width: 250, height: 200)
                            VStack{
                                Text("STAGE1").font(.title2).fontWeight(.black)
                                stage_1_star_count()
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
                                stage_2_star_count()
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
                VStack{
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

//各ステージの星の数
struct stage_1_star_count: View{
    var body: some View{
        //stage1の星の数
        HStack{
            let stage1_stars = number_of_stars_in_each_stage[0]
            
            if stage1_stars == "3"{
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage1_stars == "2"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage1_stars == "1"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage1_stars == "0"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
            }
        }.foregroundColor(Color.yellow)
    }
}
struct stage_2_star_count: View{
    var body: some View{
        //stage1の星の数
        HStack{
            let stage2_stars = number_of_stars_in_each_stage.suffix(from: 1)
            
            if stage2_stars.first == "3"{
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage2_stars.first == "2"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage2_stars.first == "1"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage2_stars.first == "0"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
            }
        }.foregroundColor(Color.yellow)
    }
}
