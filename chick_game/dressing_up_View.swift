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
    //選択されているひよこを回す
    @State private var degrees = 0.0
    //現在装着されているひよこを検知する
    @State var Currently_worn_skin = "赤ひよこ"
    //装着されているひよこの色に合わせて背景を変える
    @State var Attachment_confirmation_background_color = Color.red
    
    var body: some View {
        NavigationView{
            VStack{
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
                        .fill(Attachment_confirmation_background_color)
                        .frame(width:390,height: 260)
                        .shadow(radius: 30)
                    HStack{
                        Image("hiyoko") // 回転させる画像の名前を指定
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
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
                                Text("\(Currently_worn_skin)").font(.largeTitle).fontWeight(.black).foregroundColor(Attachment_confirmation_background_color)
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
                                    .fill(Color.red)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("赤ひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        Currently_worn_skin = "赤ひよこ"
                                        Attachment_confirmation_background_color = Color.red
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
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.blue)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("青ひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        Currently_worn_skin = "青ひよこ"
                                        Attachment_confirmation_background_color = Color.blue
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
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.yellow)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("黄ひよこ").font(.largeTitle).fontWeight(.black)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80)
                                    Button(action: {
                                        Currently_worn_skin = "黄ひよこ"
                                        Attachment_confirmation_background_color = Color.yellow
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
                        }
                    }
                }
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}
struct dressing_up_View_Previews: PreviewProvider {
    static var previews: some View {
        dressing_up_View()
    }
}
