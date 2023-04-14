//
//  FooterView.swift
//  Honeymoon
//
//  Created by user219285 on 4/5/23.
//

import SwiftUI

struct FooterView: View {
    
    @Binding var showBookingAlert: Bool
    
    let haptics = UINotificationFeedbackGenerator()
    
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 40, weight: .light))
            
            Spacer()
            
            Button(action: {
                //print("Succes")
                playSound(sound: "sound-click", type: "mp3")
                haptics.notificationOccurred(.success)
                showBookingAlert.toggle()
            }) {
                Text("Book Destination".uppercased())
                    .font(.system(.subheadline, design: .rounded, weight: .heavy))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .accentColor(.pink)
                    .background(
                        Capsule()
                            .stroke(.pink, lineWidth: 2)
                    )
            }
            
            Spacer()
            
            Image(systemName: "heart.circle")
                .font(.system(size: 40, weight: .light))
        }
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    @State static var showAlert: Bool = false
    static var previews: some View {
        FooterView(showBookingAlert: $showAlert)
    }
}
