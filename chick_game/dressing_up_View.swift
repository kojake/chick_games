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
                Spacer()
                Text("ひよこ着せ替え").font(.largeTitle).fontWeight(.black)
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
