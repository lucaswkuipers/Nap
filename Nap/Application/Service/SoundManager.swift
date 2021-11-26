import AVFoundation

final class SoundManager {
    static let shared = SoundManager()
    static var player: AVAudioPlayer?

    enum Sound: String {
        case alarm = "early_riser"
        case empty = "empty"

        var fileName: String {
            return self.rawValue
        }

        var fileExtension: String {
            switch self {
            case .alarm:
                return "mp3"
            case .empty:
                return "wav"
            }
        }
    }

    static func play(sound: Sound) {
        let fileName = sound.fileName
        let fileExtension = sound.fileExtension
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }

    static func stop() {
        player?.stop()
    }
}
