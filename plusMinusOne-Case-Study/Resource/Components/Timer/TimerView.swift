import UIKit
import KDCircularProgress

final class TimerView: UIView {
    private let progress = KDCircularProgress()
    private let countdownLabel = UILabel()
    
    var initialTotalTime: Int = 60 {
        didSet {
            time = initialTotalTime
        }
    }
    
    private var time: Int? {
        didSet {
            countdownLabel.text = "\(time ?? 0)"
        }
    }
    
    private var countdownTimer: Timer?
    
    var retryClosure: (() -> Void)?

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
        progress.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        progress.startAngle = -90
        progress.progressThickness = 0.45
        progress.trackThickness = 0.35
        progress.trackColor = UIColor.systemGray5
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
            progress.angle = ((360 * Double(remainingTime - 1)) / Double(initialTotalTime))
            time = remainingTime - 1
        } else {
            startCountdown()
            time = initialTotalTime
            retryClosure?()
        }
    }
}
