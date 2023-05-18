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
                NavigationLink(destination: main_View(select_stage: $selected_STAGE), isActive: $showShould_main_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                NavigationLink(destination: shop_View(), isActive: $showShould_shop_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                NavigationLink(destination: dressing_up_View(), isActive: $showShould_dressing_up_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                
                HStack{
                    Text("シーズン１").fontWeight(.black).font(.system(size: 45, weight: .black, design: .default))
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
                            .shadow(radius: 20)
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
                            .shadow(radius: 20)
                    }
                }
                Spacer()
                HStack{
                    Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100)
                    Text("ひよこゲーム").font(.system(size: 50, weight: .black, design: .default)).foregroundColor(.yellow)
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
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.gray)
                                .frame(width: 250, height: 200)
                            VStack{
                                Text("STAGE3").font(.title2).fontWeight(.black)
                                stage_3_star_count()
                                Button(action: {
                                    selected_STAGE = 3
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
                                Text("STAGE4").font(.title2).fontWeight(.black)
                                stage_4_star_count()
                                Button(action: {
                                    selected_STAGE = 4
                                }) {
                                    HStack {
                                        Text("選択")
                                    }
                                }.buttonStyle(BlueButtonStyle())
                            }
                        }
                    }
                }.shadow(radius: 20)
                Spacer()
                //スタートボタン
                HStack{
                    VStack{
                        Text("選択されたSTAGE\(selected_STAGE)").font(.largeTitle).fontWeight(.black)
                        Button(action: {
                            showShould_main_View = true
                        }) {
                            Image("chick_game_start_button_image").resizable().scaledToFit()
                                .bold()
                                .padding()
                                .frame(width: 300, height: 150)
                                .foregroundColor(Color.white)
                                .background(Color.yellow)
                                .cornerRadius(10)
                        }
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
struct stage_3_star_count: View{
    var body: some View{
        //stage1の星の数
        HStack{
            let stage3_stars = number_of_stars_in_each_stage.suffix(from: 2)
            
            if stage3_stars.first == "3"{
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage3_stars.first == "2"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage3_stars.first == "1"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage3_stars.first == "0"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
            }
        }.foregroundColor(Color.yellow)
    }
}

struct stage_4_star_count: View{
    var body: some View{
        //stage1の星の数
        HStack{
            let stage4_stars = number_of_stars_in_each_stage.suffix(from: 3)
            
            if stage4_stars.first == "3"{
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage4_stars.first == "2"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage4_stars.first == "1"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage4_stars.first == "0"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
            }
        }.foregroundColor(Color.yellow)
    }
}

