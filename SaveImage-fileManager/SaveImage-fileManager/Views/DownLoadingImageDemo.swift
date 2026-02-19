//
//  DownLoadingImageDemo.swift
//  SaveImage-fileManager
//
//  Created by Ros Dul on 19/2/26.
//

import SwiftUI
//background threat
//weak self
//Combine
//Publichers and Subscripts
//File Manage
//NSCache



struct DownLoadingImageDemo: View {
    @ObservedObject var vm = DownloadingImageViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationBarTitle("DownLoad Image")
        }
    }
}

#Preview {
    DownLoadingImageDemo()
}
