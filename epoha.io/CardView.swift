//
//  CardView.swift
//  epoha.io
//
//  Created by constantine kos on 07.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack {
            
            //IMAGE
            ZStack(alignment: .bottomTrailing) {
                Image("3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    Text("Keyword")
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.green)
                        .cornerRadius(4)
                    
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                    
                }.padding()
            }
            
            //TITLE
            Text("title")
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding()
            
        }
        .background(Color("Background"))
        .frame(width: UIScreen.main.bounds.width - 40)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color("DarkShadow"), radius: 6, x: 8, y: 8)
        .shadow(color: Color("LightShadow"), radius: 6, x: -8, y: -8)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
