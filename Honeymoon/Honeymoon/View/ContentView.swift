//
//  ContentView.swift
//  Honeymoon
//
//  Created by user219285 on 4/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @GestureState private var dragState = DragState.inactive
    
    private var dragAreaTreshold: CGFloat = 65.0
    
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    
    //MARK: - Card Views
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        return views
    }()
    
    //MARK: - Drag states
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    //MARK: - FUNCTIONS
    //MARK: - Top card
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    //MARK: - Move the card
    private func moveCards() {
        cardViews.removeFirst()
        
        self.lastCardIndex += 1
        
        let honeymoon = honeymoonData[lastCardIndex % honeymoonData.count]
        
        let newCardView = CardView(honeymoon: honeymoon)
        
        cardViews.append(newCardView)
    }
    
    var body: some View {
        VStack {
            //MARK: - Header
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: showInfo)
            
            Spacer()
            
            //MARK: - Cards
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width < -dragAreaTreshold && isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width > dragAreaTreshold && isTopCard(cardView: cardView) ? 1.0 : 0.0)
                            }
                        )
                    //MARK: - Moving card left/right
                        .offset(x: isTopCard(cardView: cardView) ? dragState.translation.width : 0, y: isTopCard(cardView: cardView) ? dragState.translation.height : 0)
                        .scaleEffect(dragState.isDragging && isTopCard(cardView: cardView) ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: isTopCard(cardView: cardView) ?  Double(self.dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: dragState.isDragging)
                    //MARK: - GESTURE
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: DragGesture())
                            .updating($dragState, body: { (value, state, transaction) in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                .onChanged({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragAreaTreshold {
                                        self.cardRemovalTransition = .leadingBottom
                                    }
                                    if drag.translation.width > self.dragAreaTreshold {
                                        self.cardRemovalTransition = .trailingBottom
                                    }
                                })
                                .onEnded({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragAreaTreshold || drag.translation.width > self.dragAreaTreshold {
                                        playSound(sound: "sound-rise", type: "mp3")
                                        self.moveCards()
                                    }
                                })
                        ).transition(cardRemovalTransition)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            //MARK: - Footer
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: showInfo)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("SUCCESS"),
                  message: Text("Wishing a lovely and most precious of the times together for the amazing couple."),
                  dismissButton: .default(Text("Happy Honeymoon!")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
