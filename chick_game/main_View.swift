//
//  main_View.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI
import UIKit

struct main_View: View {
    //選択されたステージを取得する
    @Binding var select_stage: Int
    
    var body: some View{
        NavigationView{
            VStack{

            }
        }.navigationBarBackButtonHidden(true)
    }
}

