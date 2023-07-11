//
//  CustomTransition.swift
//  MobioOwn
//
//  Created by Oyatullo Koraboev on 11/07/23.
//

import SwiftUI

struct CubeRotationModifier: AnimatableModifier {
    enum SlideDirection {
        case enter
        case exit
    }
    
    var pct: Double
    var direction: SlideDirection
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    

    func calcRotation() -> Double {
        if direction == .enter {
            return 90 - (pct * 90)
        } else {
            return -1 * (pct * 90)
        }
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .rotation3DEffect(
                    Angle(degrees: calcRotation()),
                    axis: (x: 0.0, y: 1.0, z: 0.0),
                    anchor: direction == .enter ? .leading : .trailing,
                    anchorZ: 0,
                    perspective: 0.1
                ).transformEffect(.init(translationX: calcTranslation(geo: geo), y: 0))
        }
    }

    func calcTranslation(geo: GeometryProxy) -> CGFloat {
        if direction == .enter {
            return geo.size.width - (CGFloat(pct) * geo.size.width)
        } else {
            return -1 * (CGFloat(pct) * geo.size.width)
        }
    }
}


extension AnyTransition {
    static var cubeRotation: AnyTransition {
        get {
            AnyTransition.asymmetric(
                insertion: AnyTransition.modifier(active: CubeRotationModifier(pct: 0, direction: .enter), identity: CubeRotationModifier(pct: 1, direction: .enter)),
                removal: AnyTransition.modifier(active: CubeRotationModifier(pct: 1, direction: .exit), identity: CubeRotationModifier(pct: 0, direction: .exit)))
        }
    }
}
