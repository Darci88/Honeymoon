//
//  HeaderView.swift
//  Honeymoon
//
//  Created by user219285 on 4/5/23.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var showGuideView: Bool
    @Binding var showInfoView: Bool
    
    let haptics = UINotificationFeedbackGenerator()
    
    var body: some View {
        HStack {
            Button(action: {
                //print("Information")
                playSound(sound: "sound-click", type: "mp3")
                haptics.notificationOccurred(.success)
                showInfoView.toggle()
            }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(.primary)
            .sheet(isPresented: $showInfoView) {
                InfoView()
            }
            
            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button(action: {
                //print("Guide")
                haptics.notificationOccurred(.success)
                playSound(sound: "sound-click", type: "mp3")
                showGuideView.toggle()
            }) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(.primary)
            .sheet(isPresented: $showGuideView) {
                GuideView()
            }
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showGuide: Bool = false
    @State static var showInfo: Bool = false
    
    static var previews: some View {
        HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
    }
}
