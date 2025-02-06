//
//  ConvertImageData.swift
//  SomethingTimer
//
//  Created by 김용해 on 2/7/25.
//

import SwiftUI
import UIKit


struct ConvertImageData {
    static let shared: ConvertImageData = ConvertImageData() // 싱글 톤
    
    private init() {} // 초기화 제거
    
    
    /// ** uiImage를 Data로 변환시키는 함수입니다 **
    func convertImageData(uiImage: UIImage?) -> Data {
        guard let image = uiImage else { return Data() }
        return image.jpegData(compressionQuality: 1.0)!
    }
    
    /// ** Data 를 Uiimage로 변환하는 함수입니다 **
    func convertDataImage(data: Data) -> UIImage? {
        return UIImage(data: data)!
    }
}
