//
//  InfoView.swift
//  Honeymoon
//
//  Created by user219285 on 4/5/23.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                
                Spacer(minLength: 10)
                
                Text("App Info")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                AppInfoView()
                
                Text("Credits")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                CreditsView()
                
                Spacer(minLength: 10)
                
                Button(action: {
                    //print("A button was tapped")
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Continue".uppercased())
                        .modifier(ButtonModifier())
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        }
    }
}

struct AppInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RowAppInfoView(firstItem: "Application", secondItem: "Honeymon")
            RowAppInfoView(firstItem: "Compatibility", secondItem: "iPhone & iPad")
            RowAppInfoView(firstItem: "Developer", secondItem: "Daria")
            RowAppInfoView(firstItem: "Designer", secondItem: "Robert Petras")
            RowAppInfoView(firstItem: "Website", secondItem: "swiftuimasterclass.com")
            RowAppInfoView(firstItem: "Version", secondItem: "1.0.0")
        }
    }
}

struct RowAppInfoView: View {
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        VStack {
            HStack {
                Text(firstItem).foregroundColor(.gray)
                Spacer()
                Text(secondItem)
            }
            Divider()
        }
    }
}

struct CreditsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Photos").foregroundColor(.gray)
                Spacer()
                Text("Unsplash")
            }
            
            Divider()
            
            Text("Photographers").foregroundColor(.gray)
            
            Text("Shifaaz Shamoon (Maldives), Grillot Edouard (France), Evan Wise (Greece), Christoph Schulz (United Arab Emirates), Andrew Coelho (USA), Damiano Baschiera (Italy), Daniel Olah (Hungary), Andrzej Rusinowski (Poland), Lucas Miguel (Slovenia), Florencia Potter (Spain), Ian Simmonds (USA), Ian Keefe (Canada), Denys Nevozhai (Thailand), David Köhler (Italy), Andre Benz (USA), Alexandre Chambon (South Korea), Roberto Nickson (Mexico), Ajit Paul Abraham (UK), Jeremy Bishop (USA), Davi Costa (Brazil), Liam Pozz (Australia)")
                .multilineTextAlignment(.leading)
                .font(.footnote)
        }
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}



