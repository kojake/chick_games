//
//  menu_View.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI

struct menu_View: View {
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss
    
    //本当にやめるのかalert
    @State private var finish_ok_alert = false
    
    @Binding var interrupt_the_game: Int
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.opacity(0.5).ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("MENU").font(.largeTitle).fontWeight(.black)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("再開する")
                            .bold()
                            .padding()
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        finish_ok_alert = true
                    }) {
                        Text("やめる")
                            .bold()
                            .padding()
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
            .alert(isPresented: $finish_ok_alert) {
                        Alert(title: Text("警告"),
                              message: Text("本当にやめますか？"),
                              primaryButton: .cancel(Text("やめない")),
                              secondaryButton: .default(Text("やめる"),
                                                      action: {
                            quit_the_game()
                            dismiss()
                        }))
                    }
        }.navigationBarBackButtonHidden(true)
    }
    func quit_the_game(){
        interrupt_the_game = 1
    }
}
