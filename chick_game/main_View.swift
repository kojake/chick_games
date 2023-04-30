//
//  main_View.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI
import UIKit

struct main_View: View {
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss2
    //menu画面へ遷移
    @State private var showShould_menu_View = false
    //ゲーム中断
    @State var interrupt_the_game = 0
    //button_color
    @State private var isTapped = true
    @State private var isTapped2 = true
    //ひよこ座標
    @State var x_position = 200
    @State var y_position = 430
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: menu_View(interrupt_the_game: $interrupt_the_game), isActive: $showShould_menu_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                HStack{
                    Text("ステージ名").font(.largeTitle).fontWeight(.black)
                    Spacer()
                    Button(action: {
                        showShould_menu_View = true
                    }) {
                        Text("MENU")
                            .fontWeight(.black)
                            .padding()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                
                VStack{
                    Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(x_position), y: CGFloat(y_position))
                }
                
                Spacer()
                HStack{
                    Button(action: {
                        self.isTapped.toggle()
                    }) {
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(isTapped ? Color.green : Color.red)

                    }
                    .simultaneousGesture(LongPressGesture().onChanged { _ in
                        self.isTapped = false
                        y_position += 10
                    }.onEnded { _ in
                        self.isTapped = true
                    })
                    
                    Button(action: {
                        self.isTapped2.toggle()
                    }) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(isTapped2 ? Color.green : Color.red)

                    }
                    .simultaneousGesture(LongPressGesture().onChanged { _ in
                        self.isTapped2 = true
                        y_position -= 10
                    }.onEnded { _ in
                        self.isTapped2 = false
                    })
                }
            }.onAppear{
                print("反応")
                print(interrupt_the_game)
                if interrupt_the_game == 1{
                    interrupt_the_game = 0
                    dismiss2()
                    sleep(1)
                    dismiss2()
                }
            }
        }
    }
}

struct main_View_Previews: PreviewProvider {
    static var previews: some View {
        main_View()
    }
}
