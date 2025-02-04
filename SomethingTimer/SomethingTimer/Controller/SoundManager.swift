//
//  SoundManager.swift
//  SomethingTimer
//
//  Created by 김용해 on 2/4/25.
//
import AVFoundation

struct SoundManager {
    static var shared: SoundManager = SoundManager() // 싱글톤
    private init() {} // 생성자 불가
    var player: AVAudioPlayer?
    
    mutating func playSound(fileName: String, type: String) throws {
        guard let url = Bundle.main.path(forResource: fileName, ofType: type) else { return print("지정된 파일 위치가 아닙니다") }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
        } catch {
                print("error : \(error)")
        }
    }
    
    func play() {
        player?.play()
    }
}
