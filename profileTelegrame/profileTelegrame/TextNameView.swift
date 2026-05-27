//
//  TextNameView.swift
//  profileTelegrame
//
//  Created by Ros Dul on 26/5/26.
//

import SwiftUI

struct TextNameView: View {
    var isCircleShape: Bool
    var body: some View {
        VStack{
            Text("Name Dul")
        }
        .foregroundColor(isCircleShape ? Color.primary : .white )
        .font(.system(size: isCircleShape ? 30 : 25))
        .fontWeight(.bold)
        
        //គ្រប់គ្រង Alignment និងទំហំប្រអប់
        .frame(maxWidth: .infinity, alignment: isCircleShape ? .center : .leading)
        .padding(isCircleShape ? 0: 20)
        
        //បន្ថែមការលាក់ Background ពេលជារង្វង់មូល (ព្រោះ Telegram ពេលរួមតូចគឺអត់មាន Background ទេ)
//        .background(isCircleShape ? AnyShapeStyle(.clear) : AnyShapeStyle(.ultraThinMaterial))
        
//        .padding(.horizontal, isCircleShape ? 0 : 20)
        
        .background {
                if !isCircleShape {
                    ZStack {
                        // Layer 1: Blur material
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                        
                        // Layer 2: Gradient mask ពីលើ transparent → ក្រោម opaque
                        LinearGradient(
                            colors: [
                                Color.clear,
                                Color.black.opacity(0.1),
                                Color.black.opacity(0.15)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                }
            }
        
        //រៀបចំ Offset ឱ្យត្រូវកន្លែង៖
        .offset(x: 0, y: -5)
        .zIndex(2)
        
        // Animate
        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isCircleShape)
    }
}

struct CustomBlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterialLight
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    TextNameView(isCircleShape: false)
}
