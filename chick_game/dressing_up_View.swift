//
//  dressing_up_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/04.
//

import SwiftUI

struct dressing_up_View: View {
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss
    //画面遷移
    @State private var showShould_shop_View = false
    //選択されているひよこを回す
    @State private var degrees = 0.0
    //現在装着されているひよこを検知する
    @State var Currently_worn_skin = "ひよこ"
    //装着されているひよこの色に変える
    @State var chick_color = Color.white
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: shop_View(), isActive: $showShould_shop_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                HStack{
                    Button(action: {
                        dismiss()
                    }) {
                        Text("戻る")
                            .bold()
                            .padding()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.white)
                            .background(Color.yellow)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                Text("現在きているひよこのスキン").font(.title).fontWeight(.black)
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .frame(width:390,height: 260)
                        .shadow(radius: 30)
                    HStack{
                        Image("hiyoko") // 回転させる画像の名前を指定
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .colorMultiply(chick_color)
                            .rotationEffect(.degrees(degrees)) // 回転角度を適用
                            .animation(.default) // アニメーションを適用
                            .onAppear { // 画面が開かれたときの挙動を定義
                                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                                    degrees += 1 // 10度回転させる
                                }
                            }
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.black)
                                .frame(width:200,height: 200)
                                .shadow(radius: 30)
                            VStack{
                                Text("\(Currently_worn_skin)").font(.largeTitle).fontWeight(.black).foregroundColor(chick_color)
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
                Text("ひよこ着せ替え").font(.largeTitle).fontWeight(.black)
                ScrollView(.horizontal) {
                    VStack{
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.gray)
                                    .frame(width:240,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("ノーマルひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        Currently_worn_skin = "ひよこ"
                                        chick_color = Color.white
                                        chick_selected_color = Color.white
                                    }) {
                                        Text("装着する")
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .padding()
                                        .background(Color.black)
                                        .cornerRadius(40)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .overlay(
                                        RoundedRectangle(cornerRadius: 60)
                                            .stroke(Color.black, lineWidth: 5)
                                        )
                                    }
                                }
                            }
                            //赤ひよこ
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.red)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("赤ひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        let (red_chick, red_chick_value) = chicks_that_are_getting_or_not.first(where: { _ in true })!
                                        
                                        if red_chick_value == "get"{
                                            Currently_worn_skin = "赤ひよこ"
                                            chick_color = Color.red
                                            chick_selected_color = Color.red
                                        }
                                        else{
                                            showShould_shop_View = true
                                        }
                                    }) {
                                        let (red_chick, red_chick_value) = chicks_that_are_getting_or_not.first(where: { _ in true })!
                                        
                                        if red_chick_value == "get"{
                                            Text("装着する")
                                            .fontWeight(.bold)
                                            .font(.title2)
                                            .padding()
                                            .background(Color.black)
                                            .cornerRadius(40)
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .overlay(
                                            RoundedRectangle(cornerRadius: 60)
                                                .stroke(Color.black, lineWidth: 5)
                                            )
                                        }
                                        else if red_chick_value == "not_get"{
                                            Text("shopに行く")
                                            .fontWeight(.bold)
                                            .font(.title2)
                                            .padding()
                                            .background(Color.black)
                                            .cornerRadius(40)
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .overlay(
                                            RoundedRectangle(cornerRadius: 60)
                                                .stroke(Color.black, lineWidth: 5)
                                            )
                                        }
                                    }
                                }
                            }
                            //青ひよこ
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.blue)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("青ひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        let (blue_chick, blue_chick_value) = chicks_that_are_getting_or_not.dropFirst().first(where: { _ in true })!
                                        
                                        if blue_chick_value == "get"{
                                            Currently_worn_skin = "青ひよこ"
                                            chick_color = Color.blue
                                            chick_selected_color = Color.blue
                                        }
                                        else{
                                            showShould_shop_View = true
                                        }
                                    }) {
                                        let (blue_chick, blue_chick_value) = chicks_that_are_getting_or_not.dropFirst().first(where: { _ in true })!
                                        
                                        if blue_chick_value == "get"{
                                            Text("装着する")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                        else if blue_chick_value == "not_get"{
                                            Text("shopに行く")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                    }
                                }
                            }
                            //黄ひよこ
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.yellow)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("黄ひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        let yellow_chick_value = chicks_that_are_getting_or_not["黄ひよこ"]
                                        
                                        if yellow_chick_value == "get"{
                                            Currently_worn_skin = "黄ひよこ"
                                            chick_color = Color.yellow
                                            chick_selected_color = Color.yellow
                                        }
                                        else{
                                            showShould_shop_View = true
                                        }
                                    }) {
                                        let yellow_chick_value = chicks_that_are_getting_or_not["黄ひよこ"]
                                        if yellow_chick_value == "get"{
                                            Text("装着する")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                        else if yellow_chick_value == "not_get"{
                                            Text("shopに行く")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                    }
                                }
                            }
                            //緑ひよこ
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.green)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("緑ひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        let green_chick_value = chicks_that_are_getting_or_not["緑ひよこ"]
                                        
                                        if green_chick_value == "get"{
                                            Currently_worn_skin = "黄ひよこ"
                                            chick_color = Color.green
                                            chick_selected_color = Color.green
                                        }
                                        else{
                                            showShould_shop_View = true
                                        }
                                    }) {
                                        let green_chick_value = chicks_that_are_getting_or_not["緑ひよこ"]
                                        if green_chick_value == "get"{
                                            Text("装着する")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                        else if green_chick_value == "not_get"{
                                            Text("shopに行く")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                    }
                                }
                            }
                            //ピンクひよこ
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.pink)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("ピンクひよこ").font(.title).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        let pink_chick_value = chicks_that_are_getting_or_not["ピンクひよこ"]
                                        
                                        if pink_chick_value == "get"{
                                            Currently_worn_skin = "ピンクひよこ"
                                            chick_color = Color.pink
                                            chick_selected_color = Color.pink
                                        }
                                        else{
                                            showShould_shop_View = true
                                        }
                                    }) {
                                        let pink_chick_value = chicks_that_are_getting_or_not["ピンクひよこ"]
                                        if pink_chick_value == "get"{
                                            Text("装着する")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                        else if pink_chick_value == "not_get"{
                                            Text("shopに行く")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                    }
                                }
                            }
                            //オレンジひよこ
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.pink)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("オレンジひよこ").font(.title).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        let orange_chick_value = chicks_that_are_getting_or_not["オレンジひよこ"]
                                        
                                        if orange_chick_value == "get"{
                                            Currently_worn_skin = "オレンジひよこ"
                                            chick_color = Color.orange
                                            chick_selected_color = Color.orange
                                        }
                                        else{
                                            showShould_shop_View = true
                                        }
                                    }) {
                                        let orange_chick_value = chicks_that_are_getting_or_not["オレンジひよこ"]
                                        if orange_chick_value == "get"{
                                            Text("装着する")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                        else if orange_chick_value == "not_get"{
                                            Text("shopに行く")
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .padding()
                                                .background(Color.black)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 60)
                                                        .stroke(Color.black, lineWidth: 5)
                                                )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}
