//
//  ContentView.swift
//  epoha.io
//
//  Created by constantine kos on 03.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import FirebaseAnalytics

struct Home: View {
   
    @State var showMenu = true
    
    @ObservedObject var currency = CurrenciesRate()
    
    @State var newsData: [SampleNews] = [
        SampleNews(title: "Кодекс редакции Медуза", keyword: "meduza – keyword", body: "«Медуза» — международное русскоязычное издание. Каждый день наши сотрудники рассказывают о событиях в России и мире — и стараются делать это максимально достоверно, беспристрастно и непредвзято. Мы действуем осознанно и ответственно; даем возможность быть услышанными тем, кого не слышат; заботимся о том, чтобы наши публикации не ухудшили положение тех, кому и так непросто. Мы изучаем претензии, поступающие в редакцию, со всей тщательностью. Мы уважаем наших читателей. В своей ежедневной работе «Медуза» стремится соответствовать международным профессиональным стандартам. Права и свободы человека, изложенные во Всеобщей декларации прав человека, для нас — абсолютная ценность. Предмет нашего особого внимания — право людей на свободу слова и свободное распространение информации. Набор принципов и правил, на которые мы ориентируемся в своей повседневной деятельности, изложен в кодексе «Медузы». Мы считаем журналистами всех сотрудников редакции, а также сотрудников других подразделений, создающих редакционный продукт, в том числе разработчиков и дизайнеров; их работа тоже регулируется этим кодексом.", image: "3", verifiedBadge: true, postUrl: "https://meduza.io/pages/codex", showPost: false),
        SampleNews(title: "Нормальные люди» — экранизация бестселлера Салли Руни и один из самых обсуждаемых сериалов мая Мы поговорили с режиссером Ленни Абрахамсоном о неожиданном успехе шоу", keyword: "Сериал", body: "«Нормальные люди» — это сериал Ленни Абрахамсона (номинант на «Оскар» за фильм «Комната») и Хетти Макдональд, снятый по одноименному роману ирландской писательницы Салли Руни. Книга об отношениях двух непохожих друг на друга подростков сразу же стала сверхпопулярной во всем мире — Hulu и «Би-Би-Си» выкупили права ее на экранизацию еще до появления книги на прилавках магазинов (в России сериал можно посмотреть на «КиноПоиск HD»). Специально для «Медузы» журналист Жанна Присяжная поговорила с режиссером и продюсером шоу Ленни Абрахамсоном — и расспросила, почему его задела история, зачем на съемочной площадке понадобился секс-координатор и как изменились зрительские вкусы во время пандемии коронавируса.", image: "1", verifiedBadge: true, postUrl: "https://meduza.io/feature/2020/06/05/normalnye-lyudi-ekranizatsiya-bestsellera-salli-runi-i-odin-iz-samyh-obsuzhdaemyh-serialov-maya", showPost: false),
        SampleNews(title: "Та же несправедливость, с которой боролись прадедушки и прабабушки Уже почти две недели Америка охвачена протестами. Репортаж «Медузы» из Вашингтона", keyword: "Black Lives Matter", body: "В США с 25 мая проходят массовые протесты против полицейского насилия и расизма. Мирные демонстрации сопровождаются стычками с полицией и отрядами национальной гвардии, грабежами и поджогами магазинов. В американской столице Вашингтоне обстановка накалилась настолько, что в город ввели войска, а президенту Дональду Трампу даже пришлось ненадолго спрятаться в бункере Белого дома. Впрочем, активная фаза протестов уже пошла на спад. По просьбе «Медузы» журналистка Мария Данилова сходила на очередную демонстрацию в Вашингтоне и узнала у протестующих, чего они добиваются.", image: "2", verifiedBadge: false, postUrl: "https://meduza.io/feature/2020/06/06/ta-zhe-nespravedlivost-s-kotoroy-borolis-pradedushki-i-prababushki", showPost: false),
        SampleNews(title: "Crew Dragon сильно лучше «Союза»? Роскосмос теперь обанкротится? А новые российские корабли когда-нибудь полетят на МКС? Стыдные вопросы о пилотируемой космонавтике после успеха SpaceX", keyword: "SpaceX", body: "Когда говорят о том, что запуск космического корабля Crew Dragon с экипажем — это историческое событие, — многие задаются вопросом, в чем же именно состоит его значение. Формально запуск не стал революцией в науке и технике; не будет ею и полет к Луне американских астронавтов в 2023-24 годах в рамках программы «Артемида». Все это человечество уже делало. Запуск не стал и возвратом утраченных технологий: последнее десятилетие, когда не летали американские пилотируемые космические корабли, к МКС регулярно отправлялись российские «Союзы», так же, как в космосе бывали космонавты КНР. Однако полет Crew Dragon стал прорывом с организационной точки зрения — 30 мая компания SpaceX официально стала первой в мире частной фирмой, которая владеет пилотируемым космическим транспортным средством и вольна распоряжаться им по собственному усмотрению. Это кардинально меняет будущее пилотируемых полетов. Теперь компания использует наработки для новейшего корабля Starship, а значит, нас, вероятно, ждет революция в пилотируемой космонавтике.", image: "4", verifiedBadge: true, postUrl: "https://meduza.io/feature/2020/06/05/crew-dragon-silno-luchshe-soyuza-roskosmos-teper-obankrotitsya-a-novye-rossiyskie-korabli-kogda-nibud-poletyat-na-mks", showPost: false),
        SampleNews(title: "Кого спасать первым, а кого — вторым Максим Трудолюбов — о том, как врачи и политики во время кризиса руководствуются принципом «как на войне». И к чему это приводит", keyword: "Коронавирус", body: "Во время нынешнего кризиса, вызванного пандемией, доктора и политики действуют по принципу «как на войне» — принимают сложные решения о том, кого спасать в первую очередь. Разговор об этической стороне этого принципа свидетельствует об ответственности властей и возвращении к мирному времени. О том, почему в России подобного обсуждения нет, рассказывает колумнист New York Times и редактор The Russia File Максим Трудолюбов (а также рекомендует несколько книг об утилитаристском подходе к оказанию помощи).", image: "5", verifiedBadge: false, postUrl: "https://meduza.io/feature/2020/06/05/kogo-spasat-pervym-a-kogo-vtorym", showPost: false)
    ]
    
    @State var hero = false
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                HStack {
                    if showMenu {
                        ShimmerLogoOff()
                        Divider()
                            .frame(height: 20)
                        
                        //CURRENCIES NOW
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("$ \(currency.udsNow, specifier: "%.2f") • € \(currency.eurNow, specifier: "%.2f") • zł \(currency.złNow, specifier: "%.2f")")
                        }
                        
                    } else {
                        HeaderBar()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "command")
                            .modifier(SquereButtons())
                    }
                    
                    }.padding()
                
                VStack(spacing: 20) {
                    
                    ForEach(self.newsData) { post in
                        
                        //CARD VIEW STARTS HERE
                        VStack {
                            //IMAGE
                            ZStack(alignment: .bottomTrailing) {
                                Image(post.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                                HStack {
                                    Text(post.keyword)
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(Color.green)
                                        .cornerRadius(4)
                                    if post.verifiedBadge {
                                        Image(systemName: "checkmark.seal.fill")
                                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                                    }
                                    
                                }.padding()
                            }
                            
                            //TITLE
                            Text(post.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            //BODY
                            if self.hero && post.showPost {
                                Divider()
                                
                                Text(post.body)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                
                                Divider()
                                //SHARE POST BUTTON
                                Button(action: {
                                    post.sharePost()
                                }) {
                                    HStack {
                                        Text("Share")
                                        Image(systemName: "square.and.arrow.up")
                                        
                                    }
                                    .foregroundColor(Color("Golden"))
                                    .frame(width: self.width - 200)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("Golden")))
                                }
                                .padding()
                            
                            }
                        }
                        .background(Color("Background"))
                        .frame(width: self.width - 40)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color("DarkShadow"), radius: 6, x: 8, y: 8)
                        .shadow(color: Color("LightShadow"), radius: 6, x: -8, y: -8)
                        .onTapGesture {
                            withAnimation {
                                self.hero.toggle()
                                post.expandBody()
                            }
                        }.animation(.spring())
                            //END OF CARD VIEW
                            .padding()
                    }
                    
                }
            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//LOGO
struct ShimmerLogoOff: View {
    @State var show = false
    
    var body: some View {
        ZStack{
            Text("meduza.io")
                .foregroundColor(Color("MainBlack"))
                .font(.title)
                .fontWeight(.bold)
            
            Text("meduza.io")
                .foregroundColor(Color("Golden"))
                .font(.title)
                .fontWeight(.bold)
                .modifier(ShimmerEffectOff())
            
        }
    }
}



