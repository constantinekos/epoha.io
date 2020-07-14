//
//  FAQView.swift
//  epoha.io
//
//  Created by constantine kos on 07.07.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import FirebaseAnalytics
import Combine


struct FAQView: View {
    @State var width = UIScreen.main.bounds.width
    
    @ObservedObject var userSettings = UserSettings()
    
    let url = "https://apple.com"
    var body: some View {
        
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .frame(width: 40, height: 8)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .shadow(color: Color("DarkShadow"), radius: 4, x: 4, y: 4)
                    .shadow(color: Color("LightShadow"), radius: 4, x: -4, y: -4)
                    .padding()
                
                CodexComponent()
                    .padding(.bottom)
                
                VStack {
                    HStack {
                        Text("Font")
                            .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .subheadline)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    Divider()
                        .background(Color("Golden"))
                        .padding(.horizontal)
                    
                    HStack {
                        Toggle(isOn: $userSettings.monkeyBusinessFont) {
                            Text("News Font")
                                .font(.custom("PlayfairDisplay-Regular", size: 16))
                        }
                    }
                    
                }
                .padding()
                .background(Color("Background"))
                .frame(width: self.width - 40)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .modifier(Shadows())
                
                
                MeaningsComponent()
                    .padding()
                
                Monetization()
                    .padding(.bottom)
                
                SecureDrop()
                
                PrivacyComponent()
                    .padding(.top, 20)
                
                TermsComponent()
                
                Text("2020 • powered by constantinekos")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding()
            }
            .frame(width: self.width - 40)
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}

struct MeaningsComponent: View {
    @ObservedObject var userSettings = UserSettings()
    
    @State var width = UIScreen.main.bounds.width
    var body: some View {
        VStack {
            HStack {
                Text("Meanings")
                    .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .subheadline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            Divider()
            .background(Color("Golden"))
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                
                Text("It means that we check the fact of that post")
                Spacer()
            }
            
            Divider()
            .background(Color("Golden"))
            .padding(.horizontal)
            
            HStack {
                Text("Keyword")
                    .foregroundColor(Color.white)
                    .padding(4)
                    .background(Color.green)
                    .cornerRadius(4)
                
                Text("It means that every post has different keyword")
                Spacer()
            }
        }
        .padding()
        .background(Color("Background"))
        .frame(width: self.width - 40)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(Shadows())
    }
}

struct CodexComponent: View {
    @ObservedObject var userSettings = UserSettings()
    @State var expand = false
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0) {
            //IMAGE
            Image("epohaLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            //TITLE
            Text("Codex – Україна")
                .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .body)
                .fontWeight(.bold)
                .padding()
            
            //BODY
            if self.expand {
                
                Divider()
                    .background(Color("Golden"))
                    .padding(.horizontal)
                
                Text("Body")
                    .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .body)
                    .padding()
            }
            
        }
        .background(Color("Background"))
        .frame(width: self.width - 36)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .modifier(Shadows())
        //.padding()
        .onTapGesture {
            withAnimation {
                DispatchQueue.main.async {
                    self.expand.toggle()
                }
            }
            Analytics.logEvent("codex_reading", parameters: nil)
        }.animation(.spring())
    }
}

struct PrivacyComponent: View {
    @State var expandPrivacyPolicy = false
    @State var width = UIScreen.main.bounds.width
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "lock.shield")
                Text("Privacy Policy")
                    .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .subheadline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            if self.expandPrivacyPolicy {
                Divider()
                    .background(Color("Golden"))
                    .padding(.horizontal)
                
                VStack {
                    Text(policy)
                        .font(.custom("PlayfairDisplay-Regular", size: 12))
                }
            }
            
        }
        .padding()
        .background(Color("Background"))
        .frame(width: self.width - 40)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(Shadows())
        .onTapGesture {
            withAnimation {
                DispatchQueue.main.async {
                    self.expandPrivacyPolicy.toggle()
                }
            }
            Analytics.logEvent("policy_reading", parameters: nil)
        }.animation(.spring())
        .padding()
    }
}

struct TermsComponent: View {
    @State var width = UIScreen.main.bounds.width
    @State var expandTerms = false
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "hand.raised")
                
                Text("Terms and Conditions")
                    .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .subheadline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            if self.expandTerms {
                Divider()
                    .background(Color("Golden"))
                    .padding(.horizontal)
                
                VStack {
                    Text(terms)
                        .font(.custom("PlayfairDisplay-Regular", size: 12))
                }
            }
        }
        .padding()
        .background(Color("Background"))
        .frame(width: self.width - 40)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(Shadows())
        .onTapGesture {
            withAnimation {
                DispatchQueue.main.async {
                    self.expandTerms.toggle()
                }
            }
            Analytics.logEvent("terms_reading", parameters: nil)
        }.animation(.spring())
    }
}

struct SecureDrop: View {
    @State var width = UIScreen.main.bounds.width
    @ObservedObject var userSettings = UserSettings()
    @State var secureMsg = ""
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "square.and.arrow.up.on.square")
                
                Text("SecureDrop")
                    .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .subheadline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            Divider()
                .background(Color("Golden"))
                .padding(.horizontal)
            
            TextField("Text your SecureDrop text here", text: $secureMsg)
            
            Divider()
                .background(Color("Golden"))
                .padding(.horizontal)
            
            Text("SecureDrop — система для безопасной связи источников с журналистами. Многие важные журналистские расследования начинаются с писем людей, которые становятся свидетелями несправедливости или чего-то противозаконного. Но иногда они не могут просто написать об этом по электронной почте или рассказать по телефону — вдруг кто-то узнает и начнутся неприятности?")
            
        }
        .padding()
        .background(Color("Background"))
        .frame(width: self.width - 40)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(Shadows())
    }
}

struct Monetization: View {
    @State var width = UIScreen.main.bounds.width
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "dollarsign.circle")
                
                Text("Monetization")
                    .font(userSettings.monkeyBusinessFont ? .custom("PlayfairDisplay-Regular", size: 16) : .subheadline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            Divider()
                .background(Color("Golden"))
                .padding(.horizontal)
            
            Text("We use Google Ads as the only way to monetize the content")
            
        }
        .padding()
        .background(Color("Background"))
        .frame(width: self.width - 40)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(Shadows())
    }
}



let terms = "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to Kostiantyn Nevinchanyi.\nKostiantyn Nevinchanyi is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\nThe epoha.io app stores and processes personal data that you have provided to us, in order to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the epoha.io app won’t work properly or at all.\nThe app does use third party services that declare their own Terms and Conditions.\nLink to Terms and Conditions of third party service providers used by the app\nAdMob\nGoogle Analytics for Firebase\nYou should be aware that there are certain things that Kostiantyn Nevinchanyi will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but Kostiantyn Nevinchanyi cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.\nIf you’re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\nAlong the same lines, Kostiantyn Nevinchanyi cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Kostiantyn Nevinchanyi cannot accept responsibility.\nWith respect to Kostiantyn Nevinchanyi’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavour to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Kostiantyn Nevinchanyi accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\nAt some point, we may wish to update the app. The app is currently available on iOS – the requirements for system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Kostiantyn Nevinchanyi does not promise that it will always update the app so that it is relevant to you and/or works with the iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.\nChanges to This Terms and Conditions\nI may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.\nThese terms and conditions are effective as of 2020-07-07\nContact Us\nIf you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at care@epoha.io."

let policy = "Kostiantyn Nevinchanyi built the epoha.io app as a Free app. This SERVICE is provided by Kostiantyn Nevinchanyi at no cost and is intended for use as is.\nThis page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at epoha.io unless otherwise defined in this Privacy Policy.\nInformation Collection and Use\nFor a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Location. The information that I request will be retained on your device and is not collected by me in any way.\nThe app does use third party services that may collect information used to identify you.\nLink to privacy policy of third party service providers used by the app\nAdMob\nGoogle Analytics for Firebase\nLog Data\nI want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.\nCookies\nCookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\nService Providers\nI may employ third-party companies and individuals due to the following reasons:\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nI want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\nSecurity\nI value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.\nLinks to Other Sites\nThis Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\nChildren’s Privacy\nThese Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.\nChanges to This Privacy Policy\nI may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2020-07-07\nContact Us\nIf you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at care@epoha.io."


class UserSettings: ObservableObject {
//    @Published var username: String {
//        didSet {
//            UserDefaults.standard.set(username, forKey: "username")
//        }
//    }
//
//    init() {
//        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
//    }
    
    @Published var monkeyBusinessFont: Bool {
        didSet {
            UserDefaults.standard.set(monkeyBusinessFont, forKey: "isAccountPrivate")
            if self.monkeyBusinessFont == true {
                Analytics.logEvent("monkeyBusinessFont_enabled", parameters: nil)
            } else {
                Analytics.logEvent("monkeyBusinessFont_disabled", parameters: nil)
            }
        }
       
    }
    
    init() {
        self.monkeyBusinessFont = UserDefaults.standard.object(forKey: "isAccountPrivate") as? Bool ?? true
    }
    
}
