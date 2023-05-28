//
//  ContentView.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
// コミットのテストのためにコメント

import SwiftUI

struct ContentView: View {
    //選択されたステージ
    @State var selected_STAGE = 5
    //画面遷移
    @State private var showShould_main_View = false
    @State private var showShould_shop_View = false
    @State private var showShould_dressing_up_View = false
    //加kステージの画面遷移
    @State private var showShould_stage1 = false
    @State private var showShould_stage2 = false
    @State private var showShould_stage3 = false
    @State private var showShould_stage4 = false
    @State private var showShould_stage5 = false
    // offset変数でメニューを表示・非表示するためのオフセットを保持します
    @State private var offset = CGFloat.zero
    @State private var closeOffset = CGFloat.zero
    @State private var openOffset = CGFloat.zero
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                NavigationView {
                    ZStack(alignment: .topLeading) {
                        // メインコンテンツ
                        VStack {
                            //各ステージの画面遷移
                            NavigationLink(destination: stage1(select_stage: $selected_STAGE), isActive: $showShould_stage1) {
                                EmptyView()
                            }.navigationBarBackButtonHidden(true)
                            NavigationLink(destination: stage2(select_stage: $selected_STAGE), isActive: $showShould_stage2) {
                                EmptyView()
                            }.navigationBarBackButtonHidden(true)
                            NavigationLink(destination: stage3(select_stage: $selected_STAGE), isActive: $showShould_stage3) {
                                EmptyView()
                            }.navigationBarBackButtonHidden(true)
                            NavigationLink(destination: stage4(select_stage: $selected_STAGE), isActive: $showShould_stage4) {
                                EmptyView()
                            }.navigationBarBackButtonHidden(true)
                            NavigationLink(destination: stage5(select_stage: $selected_STAGE), isActive: $showShould_stage5) {
                                EmptyView()
                            }.navigationBarBackButtonHidden(true)
                            //画面遷移
                            NavigationLink(destination: shop_View(), isActive: $showShould_shop_View) {
                                EmptyView()
                            }.navigationBarBackButtonHidden(true)
                            NavigationLink(destination: dressing_up_View(), isActive: $showShould_dressing_up_View) {
                                EmptyView()
                            }.navigationBarBackButtonHidden(true)
                            
                            HStack{
                                Text("Ver.1.0").fontWeight(.black).font(.system(size: 45, weight: .black, design: .default))
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
                            HStack{
                                Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100)
                                Text("ひよこゲーム").font(.system(size: 50, weight: .black, design: .default)).foregroundColor(.yellow)
                                Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).rotation3DEffect(.degrees(180), axis: (0, 1, 0))
                            }
                            //スタートボタン
                            VStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.gray)
                                        .frame(width:400, height: 300)
                                    
                                    HStack{
                                        Text("選択している\nSTAGE\(selected_STAGE)").font(.system(size: 50, weight: .black, design: .default))
                                        Spacer()
                                        if selected_STAGE == 1{
                                            Image("stage1_image").resizable().scaledToFit().frame(width: 200,height: 300)
                                        }
                                        else if selected_STAGE == 2{
                                            Image("stage2_image").resizable().scaledToFit().frame(width: 200,height: 300)
                                        }
                                        else if selected_STAGE == 3{
                                            Image("stage3_image").resizable().scaledToFit().frame(width: 200,height: 300)
                                        }
                                        else if selected_STAGE == 4{
                                            Image("stage4_image").resizable().scaledToFit().frame(width: 200,height: 300)
                                        }
                                        else if selected_STAGE == 5{
                                            Image("stage5_image").resizable().scaledToFit().frame(width: 200,height: 300)
                                        }
                                    }
                                }
                                HStack{
                                    Button(action: {
                                        //選択されたステージを表示する
                                        if selected_STAGE == 1{
                                            showShould_stage1 = true
                                        }
                                        else if selected_STAGE == 2{
                                            showShould_stage2 = true
                                        }
                                        else if selected_STAGE == 3{
                                            showShould_stage3 = true
                                        }
                                        else if selected_STAGE == 4{
                                            showShould_stage4 = true
                                        }
                                        else if selected_STAGE == 5{
                                            showShould_stage5 = true
                                        }
                                    }) {
                                        Image("chick_game_start_button_image").resizable().scaledToFit()
                                            .bold()
                                            .padding()
                                            .frame(width: 230, height: 150)
                                            .foregroundColor(Color.white)
                                            .background(Color.yellow)
                                            .cornerRadius(10)
                                    }
                                    Button(action: {
                                        if (self.offset == self.openOffset) {
                                            self.offset = self.closeOffset
                                        } else {
                                            self.offset = self.openOffset
                                        }
                                    }){
                                        Text("ステージ選択")
                                            .frame(width: 130, height: 130)
                                            .foregroundColor(Color.white)
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .shadow(radius: 20)
                                            .font(.title3)
                                            .fontWeight(.black)
                                    }
                                }
                            }
                        }
                        
                        .background(Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        // スライドメニューがでてきたらメインコンテンツをグレイアウトします
                        Color.gray.opacity(
                            Double((self.closeOffset - self.offset)/self.closeOffset) - 0.4
                        )
                        // スライドメニュー
                        select_stage_menu_View(selected_STAGE: $selected_STAGE)
                            .background(Color.white)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                        // 最初に画面のオフセットの値をスライドメニュー分マイナスします。
                            .onAppear(perform: {
                                self.offset = (geometry.frame(in: .global).origin.y + geometry.size.height) * -1
                                self.closeOffset = self.offset
                                self.openOffset = .zero
                            })
                            .offset(y: self.offset)
                        // スライドのアニメーションを設定します
                            .animation(.default)
                    }
                    // ジェスチャーに関する実装をします
                    // スワイプのしきい値を設定してユーザの思わぬメニューの出現を防ぎます
                    .gesture(DragGesture(minimumDistance: 5)
                        .onChanged{ value in
                            // メインコンテンツの縦方向のスクロールを妨げないためにstartLocationを使用します
                            // オフセットの値(メニューの位置)をスワイプした距離に応じて狭めていきます
                            if (self.offset != self.openOffset && value.startLocation.y < 60) {
                                self.offset = self.closeOffset + value.translation.height
                            }
                        }
                        .onEnded { value in
                            // スワイプ開始位置よりも終了位置が下だったらメニューを開く
                            if (value.startLocation.y < value.location.y) {
                                if (value.startLocation.y < 30) {
                                    self.offset = self.openOffset
                                }
                            } else {
                                self.offset = self.closeOffset
                            }
                        }
                    )
                    // 上部のNavigationBarに表示する項目を設定
                    .edgesIgnoringSafeArea(.bottom)
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

struct stage_5_star_count: View{
    var body: some View{
        //stage1の星の数
        HStack{
            let stage5_stars = number_of_stars_in_each_stage.suffix(from: 4)
            
            if stage5_stars.first == "3"{
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage5_stars.first == "2"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage5_stars.first == "1"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star.fill").font(.title)
            }
            else if stage5_stars.first == "0"{
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
                Image(systemName: "star").font(.title)
            }
        }.foregroundColor(Color.yellow)
    }
}

struct select_stage_menu_View: View{
    @Binding var selected_STAGE: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        Text("ステージ選択").padding().fontWeight(.black).font(.largeTitle)
        ScrollView(.horizontal) {
            HStack{
                Image("swipeuptoclose_image").resizable().scaledToFit().frame(width: 200, height: 200)
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
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.gray)
                        .frame(width: 250, height: 200)
                    VStack{
                        Text("STAGE5").font(.title2).fontWeight(.black)
                        stage_5_star_count()
                        Button(action: {
                            selected_STAGE = 5
                        }) {
                            HStack {
                                Text("選択")
                            }
                        }.buttonStyle(BlueButtonStyle())
                    }
                }
            }
        }.shadow(radius: 20)
    }
}
