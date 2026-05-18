//
//  SettingViewModel.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import Foundation
import Combine

final class SettingViewModel: ObservableObject{
    func sigOut()throws{
       try AuthenticationManager.shared.sigOut()
    }
}
