//
//  PostView.swift
//  epoha.io
//
//  Created by constantine kos on 07.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI

struct PostView: View {
    @State private var isSharePost = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image("3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                    Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    .padding()
                }
                Text("Коронавирус. В Украине впервые за три дня выявили менее 500 новых заболевших")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Divider()
                
                Text("В Украине впервые за три дня выявили менее 500 случаев COVID-19, общее число заболевших 26 999. Об говорят данные, опубликованные Советом нацбезопасности и обороны. За последние сутки зафиксировано 485 новых заболевших (сутками ранее - 550), 242 пациента выздоровели (сутками ранее - 440), 11 пациентов умерли (сутками ранее - 15). Всего с начала эпидемии в Украине выявлено 26 999 заболевших, 11 812 человек выздоровели, 788 пациентов скончались. 20 мая правительство продлило карантин в Украине до 22 июня. Он будет адаптивным - это значит, что в каждом регионе будут действовать разные ограничения в зависимости от эпидемиологической ситуации. С 5 июня запланировано новое смягчение ограничений. Главный санврач Виктор Ляшко не исключает, что если заболеваемость будет оставаться на прежнем уровне, то карантин могут продлить и после 22 июня, но с изменениями. 3 июня ВОЗ отметила, что Украина выходит на путь постепенной стабилизации по заболеваемости коронавирусом. Читайте также: Хроника коронавируса в Украине и мире - LIVE Друзья, мы запустили систему Donations. Вот 5 причин поддержать LIGA.net У нас нет джинсы, мы не продвигаем чьи-либо политические или бизнес-интересы. Учитываем только один интерес — ваш, читательский. Более 20 лет мы придерживаемся самого высокого качества работы. По данным рейтинга ИМИ, мы лучшие в Украине по соблюдению журналистских стандартов. Если вы читаете новости бесплатно, значит кто-то заплатил за то, чтобы вы их читали. Вы уверены, что знаете кто и зачем? Donations снимает такие вопросы. Медиа, финансируемые Ахметовым, Коломойским, Медведчуком, Путиным, будут работать в любой кризис, а мы без вашей помощи — нет. Карантин и кризис обрушили рекламный рынок. Наши доходы от рекламы (то есть почти все) упали вдвое. Без вашей помощи мы не сможем долго работать. Слишком маленькой помощи не бывает — поддержите LIGA.net.")
                    .padding(.horizontal)
                
                Text("Here should be a video")
                
                Divider()
                
                Button(action: sharePost) {
                    HStack {
                        Text("Share")
                        
                        Image(systemName: "square.and.arrow.up")
                        
                    }
                    .foregroundColor(Color("Golden"))
                    .frame(width: UIScreen.main.bounds.width - 200, height: 52)
                    .background(Color("Background"))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .shadow(color: Color("DarkShadow"), radius: 6, x: 6, y: 6)
                    .shadow(color: Color("LightShadow"), radius: 6, x: -6, y: -6)
                    
                }.padding()
            }.background(Color("Background"))
        }.edgesIgnoringSafeArea(.all)
    }
    func sharePost() {
        isSharePost.toggle()
        
        let url = URL(string: "https://epoha.io/samplepost")
        let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }

}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
