//
//  ContentView.swift
//  profileTelegrame
//
//  Created by Ros Dul on 23/5/26.
//

import SwiftUI

struct ContentView: View {
    private let imageHeight: CGFloat = 360
    
    // សម្គាល់ស្ថានភាពរាង (false = បួនជ្រុង, true = រង្វង់)
    @State private var isCircleShape: Bool = false
    
    var body: some View {
        ZStack {
            // ពណ៌ផ្ទៃខាងក្រោយសន្លឹកអូស
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // ផ្នែក Header រូបភាព
                    GeometryReader { geo in
                        // ទាញយកទីតាំងអូសធៀបនឹងអេក្រង់ទូរស័ព្ទ (.global)
                        let minY = geo.frame(in: .global).minY
                        let screenWidth = geo.size.width
                        
                        // កំណត់ទំហំរូបភាព៖ បើជារង្វង់ឱ្យតូច (100) បើបួនជ្រុងឱ្យរីកធំតាមការអូស
                        let currentSize = isCircleShape ? 100 : (imageHeight + (minY > 0 ? minY : 0))
                        
                        // ហៅ ImageView មកប្រើ
                        ImageView(
                            size: currentSize,
                            imageShap: isCircleShape ? AnyShape(.circle) : AnyShape(.rect)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        // Effect Parallax: រក្សារូបភាពកុំឱ្យហើរបាត់ពេលអូសចុះក្រោម
                        .offset(y: (minY > 0 && !isCircleShape) ? -minY : 0)
                        .frame(width: screenWidth, height: imageHeight + (minY > 0 ? minY : 0))
                        .clipped()
                        
                        // កន្លែងឆែកលក្ខខណ្ឌ៖ ប្រើ .onChange ជាប់នឹង View នេះតែម្តង ដើម្បីកុំឱ្យគាំង
                        .onChange(of: minY) { _, newValue in
                            if newValue < -5 {
                                // បើអូសឡើងលើហួស -20 ឱ្យទៅជារង្វង់
                                if !isCircleShape {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                        isCircleShape = true
                                    }
                                }
                            } else if newValue > 10 {
                                // ទាល់តែទាញចុះក្រោមមកវិញខ្លាំង (លើសពី 40) ទើបទៅជាបួនជ្រុងវិញ
                                if isCircleShape {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                        isCircleShape = false
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: imageHeight)
                    .zIndex(1)
                    
                    // ផ្នែកទិន្នន័យខាងក្រោម (សម្រាប់ឱ្យមានកន្លែងអូស Scroll)
                    VStack(spacing: 15) {
                        ForEach(1...10, id: \.self) { index in
                            Text("អត្ថបទ ឬព័ត៌មានទី \(index)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .zIndex(0)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    ContentView()
}
