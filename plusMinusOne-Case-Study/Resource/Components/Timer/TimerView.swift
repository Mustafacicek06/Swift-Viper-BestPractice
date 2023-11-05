import UIKit
import KDCircularProgress

final class TimerView: UIView {
    private let progress = KDCircularProgress()
    private let countdownLabel = UILabel()
    
    var initialTotalTime: Int? {
        didSet {
            time = initialTotalTime ?? 0
        }
    }
    
    private var time: Int? {
        didSet {
            countdownLabel.text = "\(time ?? 0)"
        }
    }
    
    private var countdownTimer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        // İlerleme çubuğu ayarları
        progress.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.35
        progress.trackColor = UIColor.gray
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.set(colors: UIColor.orange)
        progress.angle = 360
        addSubview(progress)
        
        countdownLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 20)
        countdownLabel.center = progress.center
        countdownLabel.textAlignment = .center
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 13)
        countdownLabel.textColor = UIColor.orange
        
        addSubview(countdownLabel)
    }

    func startCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateCountdown() {
        if let remainingTime = time, remainingTime > 0 {
            progress.angle = ((360 * Double(remainingTime - 1)) / Double(initialTotalTime ?? 0))
            time = remainingTime - 1
        } else {
            countdownTimer?.invalidate()
        }
    }
}
