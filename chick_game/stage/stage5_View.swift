//
//  stage5_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/20.
//

import SwiftUI

//ステージ5
struct Card: Identifiable {
    let id = UUID()
    var imageName: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

struct stage5: View{
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss2
    //menu画面へ遷移
    @State private var showShould_Content_View = false
    //ゲーム中断
    @State var interrupt_the_game = 0
    //clear_alert
    @State private var clear_alert = false
    @State var alert_message = ""
    //timer
    @State var timer_count = 15
    //result_View
    @State private var showShould_result_View = false
    //結果
    @State var result = ""
    @State var clear_or_not_clear = ""
    //スターの数
    @State var star_count = 3
    //選択されたステージを取得する
    @Binding var select_stage: Int
    //カード
    @State var each_card_list = ["","","","","",""]
    let card_random_list = ["神経衰弱_カード_1","神経衰弱_カード_2","神経衰弱_カード_3"]
    @State private var cards: [Card] = [
        Card(imageName: ""),
        Card(imageName: ""),
        Card(imageName: ""),
        Card(imageName: ""),
        Card(imageName: ""),
        Card(imageName: ""),
    ]
    @State private var selectedCardIndices: [Int] = []
    
    //カードめくりアニメーション
    @State var isFront1 = false
    @State var isFront2 = false
    @State var isFront3 = false
    @State var isFront4 = false
    @State var isFront5 = false
    @State var isFront6 = false
    
    var body: some View{
        NavigationView{
            VStack{
                ZStack{
                    Color.green.ignoresSafeArea()
                    VStack{
                        NavigationLink(destination: ContentView(), isActive: $showShould_Content_View) {
                            EmptyView()
                        }.navigationBarBackButtonHidden(true)
                        NavigationLink(destination: result_View(result: $result, remaining_timer: $timer_count, result_star_count: $star_count, select_stage: $select_stage), isActive: $showShould_result_View) {
                            EmptyView()
                        }.navigationBarBackButtonHidden(true)
                        HStack{
                            VStack{
                                Text("STAGE5").font(.title3).fontWeight(.black)
                                Text("ひよこを揃えながら").font(.title).fontWeight(.black)
                            }
                            Spacer()
                            Button(action: {
                                showShould_Content_View = true
                                result = "interruption"
                            }) {
                                Text("ゲーム中断")
                                    .bold()
                                    .padding()
                                    .frame(width: 140, height: 50)
                                    .foregroundColor(Color.white)
                                    .background(Color.purple)
                                    .cornerRadius(10)
                            }
                        }
                        Spacer()
                        VStack {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                                ForEach(cards) { card in
                                    Button(action: {
                                        selectCard(card)
                                    }) {
                                        Flip(isFront: card.isFaceUp || card.isMatched,
                                             front: {
                                            Image(card.imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding(8)
                                        },
                                             back: {
                                            Image("card-back").resizable().scaledToFit()
                                        })
                                    }
                                    .disabled(card.isMatched)
                                }
                            }
                        }
                    }
                }
                Spacer()
                ZStack{
                    Color.green.ignoresSafeArea()
                    HStack{
                        Spacer()
                        VStack{
                            HStack{
                                if star_count == 3{
                                    Image(systemName: "star.fill").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                }
                                else if star_count == 2{
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                }
                                else if star_count == 1{
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                }
                                else if star_count == 0{
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star").font(.title)
                                }
                            }.foregroundColor(Color.yellow)
                            HStack{
                                Image(systemName: "clock").font(.largeTitle).fontWeight(.black)
                                Text("\(timer_count)").font(.title2).fontWeight(.black)
                            }
                        }.frame(width: 180, height: 130).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 5))
                        Spacer()
                    }
                }
            }.onAppear{
                //カードランダム関数実行
                card_decision()
                //timerstart
                var timer: Timer? = nil
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    timer_count -= 1
                    
                    if star_count == 3{
                        if timer_count == 0 {
                            timer = nil
                            timer_count = 15
                            star_count -= 1
                        }
                        else if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                        }
                        else if result == "collision"{
                            timer?.invalidate()
                        }
                        else if result == "interruption"{
                            timer?.invalidate()
                        }
                    }
                    else if star_count == 2{
                        if timer_count == 0 {
                            timer = nil
                            timer_count = 15
                            star_count -= 1
                        }
                        else if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                        }
                        else if result == "collision"{
                            timer?.invalidate()
                        }
                        else if result == "interruption"{
                            timer?.invalidate()
                        }
                    }
                    else if star_count == 1{
                        if timer_count == 0 {
                            timer = nil
                            timer_count = 15
                            star_count -= 1
                        }
                        else if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                        }
                        else if result == "collision"{
                            timer?.invalidate()
                        }
                        else if result == "interruption"{
                            timer?.invalidate()
                        }
                    }
                    else if star_count == 0{
                        if timer_count == 0 {
                            timer?.invalidate()
                            timer = nil
                            clear_alert = true
                            alert_message = "時間切れになりました。リザルト画面に移動します"
                            result = "out_of_time"
                        }
                        else if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                        }
                        else if result == "collision"{
                            timer?.invalidate()
                        }
                        else if result == "interruption"{
                            timer?.invalidate()
                        }
                    }
                    if clear_or_not_clear == "clear"{
                        timer?.invalidate()
                        alert_message = "ゴール旗に触れましたクリアです、リザルト画面に移動します"
                        result = "clear"
                    }
                }
            }.navigationBarBackButtonHidden(true)
                .alert(isPresented: $clear_alert) {
                    Alert(title: Text("結果"),
                          message: Text(alert_message),
                          dismissButton: .default(Text("OK"),
                                                  action: {showShould_result_View = true}))
                }
        }.navigationBarBackButtonHidden(true)
    }
    func card_decision(){
        //カードランダム
        for i in 0..<7{
            let card_random_value_get = card_random_list.randomElement()
            if i == 1{
                each_card_list[0] = card_random_value_get!
                cards[0].imageName = each_card_list[0]
            }
            else if i == 2{
                if each_card_list[0] == "神経衰弱_カード_1"{
                    each_card_list[1] = "神経衰弱_カード_1"
                    cards[1].imageName = each_card_list[1]
                }
                else if each_card_list[0] == "神経衰弱_カード_2"{
                    each_card_list[1] = "神経衰弱_カード_2"
                    cards[1].imageName = each_card_list[1]
                }
                else if each_card_list[0] == "神経衰弱_カード_3"{
                    each_card_list[1] = "神経衰弱_カード_3"
                    cards[1].imageName = each_card_list[1]
                }
            }
            else if i == 3{
                each_card_list[2] = card_random_value_get!
                cards[2].imageName = each_card_list[2]
            }
            else if i == 4{
                if each_card_list[2] == "神経衰弱_カード_1"{
                    each_card_list[3] = "神経衰弱_カード_1"
                    cards[3].imageName = each_card_list[3]
                }
                else if each_card_list[2] == "神経衰弱_カード_2"{
                    each_card_list[3] = "神経衰弱_カード_2"
                    cards[3].imageName = each_card_list[3]
                }
                else if each_card_list[2] == "神経衰弱_カード_3"{
                    each_card_list[3] = "神経衰弱_カード_3"
                    cards[3].imageName = each_card_list[3]
                }
            }
            else if i == 5{
                each_card_list[4] = card_random_value_get!
                cards[4].imageName = each_card_list[4]
            }
            else if i == 6{
                if each_card_list[4] == "神経衰弱_カード_1"{
                    each_card_list[5] = "神経衰弱_カード_1"
                    cards[5].imageName = each_card_list[5]
                }
                else if each_card_list[4] == "神経衰弱_カード_2"{
                    each_card_list[5] = "神経衰弱_カード_2"
                    cards[5].imageName = each_card_list[5]
                }
                else if each_card_list[4] == "神経衰弱_カード_3"{
                    each_card_list[5] = "神経衰弱_カード_3"
                    cards[5].imageName = each_card_list[5]
                }
            }
            print(each_card_list)
        //カードランダムがおかしくなっていたら
            var random_list = [1,2,3]
            if each_card_list[0] == each_card_list[2]{
                if each_card_list[0] == "神経衰弱_カード_1"{
                    random_list.remove(at: 0)
                    let random = random_list.randomElement()
                    if random == 2{
                        each_card_list[2] = "神経衰弱_カード_2"
                        each_card_list[3] = "神経衰弱_カード_2"
                    }
                    else if random == 3{
                        each_card_list[2] = "神経衰弱_カード_3"
                        each_card_list[3] = "神経衰弱_カード_3"
                    }
                }
                if each_card_list[0] == "神経衰弱_カード_2"{
                    random_list.remove(at: 1)
                    let random = random_list.randomElement()
                    if random == 1{
                        each_card_list[2] = "神経衰弱_カード_1"
                        each_card_list[3] = "神経衰弱_カード_1"
                    }
                    else if random == 3{
                        each_card_list[2] = "神経衰弱_カード_3"
                        each_card_list[3] = "神経衰弱_カード_3"
                    }
                }
                if each_card_list[0] == "神経衰弱_カード_3"{
                    random_list.remove(at: 2)
                    let random = random_list.randomElement()
                    if random == 1{
                        each_card_list[2] = "神経衰弱_カード_1"
                        each_card_list[3] = "神経衰弱_カード_1"
                    }
                    else if random == 2{
                        each_card_list[2] = "神経衰弱_カード_2"
                        each_card_list[3] = "神経衰弱_カード_2"
                    }
                }
                //変更した内容を代入する
                cards[2].imageName = each_card_list[2]
                cards[3].imageName = each_card_list[3]
            }
            if each_card_list[0] == each_card_list[4]{
                if each_card_list[0] == "神経衰弱_カード_1"{
                    random_list.remove(at: 0)
                    let random = random_list.randomElement()
                    if random == 2{
                        each_card_list[4] = "神経衰弱_カード_2"
                        each_card_list[5] = "神経衰弱_カード_2"
                    }
                    else if random == 3{
                        each_card_list[4] = "神経衰弱_カード_3"
                        each_card_list[5] = "神経衰弱_カード_3"
                    }
                }
                if each_card_list[0] == "神経衰弱_カード_2"{
                    random_list.remove(at: 1)
                    let random = random_list.randomElement()
                    if random == 1{
                        each_card_list[4] = "神経衰弱_カード_1"
                        each_card_list[5] = "神経衰弱_カード_1"
                    }
                    else if random == 3{
                        each_card_list[4] = "神経衰弱_カード_3"
                        each_card_list[5] = "神経衰弱_カード_3"
                    }
                }
                if each_card_list[0] == "神経衰弱_カード_3"{
                    random_list.remove(at: 2)
                    let random = random_list.randomElement()
                    if random == 1{
                        each_card_list[4] = "神経衰弱_カード_1"
                        each_card_list[5] = "神経衰弱_カード_1"
                    }
                    else if random == 2{
                        each_card_list[4] = "神経衰弱_カード_2"
                        each_card_list[5] = "神経衰弱_カード_2"
                    }
                }
            }
            //変更した内容を代入する
            cards[4].imageName = each_card_list[4]
            cards[5].imageName = each_card_list[5]
            
            print(each_card_list)
        }
    }
    
    //カードが揃っているか
    private func selectCard(_ card: Card) {
        guard let selectedIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[selectedIndex].isFaceUp,
              !cards[selectedIndex].isMatched else {
            return
        }
        
        cards[selectedIndex].isFaceUp = true
        selectedCardIndices.append(selectedIndex)
        
        if selectedCardIndices.count == 2 {
            let firstIndex = selectedCardIndices[0]
            let secondIndex = selectedCardIndices[1]
            
            if cards[firstIndex].imageName == cards[secondIndex].imageName {
                cards[firstIndex].isMatched = true
                cards[secondIndex].isMatched = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                cards[firstIndex].isFaceUp = false
                cards[secondIndex].isFaceUp = false
                selectedCardIndices.removeAll()
            }
        }
        
        if cards.allSatisfy({ $0.isMatched }) {
            // すべてのカードが揃った時の処理
            result = "clear"
            showShould_result_View = true
        }
    }
}
//ステージ5のカードめくりアニメーション
struct Flip<Front: View, Back: View>: View {
    var isFront: Bool
    @State var canShowFrontView: Bool
    let duration: Double
    let front: () -> Front
    let back: () -> Back
    
    init(isFront: Bool,
         duration: Double = 1.0,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back) {
        self.isFront = isFront
        self._canShowFrontView = State(initialValue: isFront)
        self.duration = duration
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            if self.canShowFrontView {
                front()
            }
            else {
                back()
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .onChange(of: isFront, perform: {
            value in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration/2.0) {
                self.canShowFrontView = value
            }
        })
        .animation(nil)
        .rotation3DEffect(isFront ? Angle(degrees: 0): Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
        .animation(.easeInOut(duration: duration))
    }
}
