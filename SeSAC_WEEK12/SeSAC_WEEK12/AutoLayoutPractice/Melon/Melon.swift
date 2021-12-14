//
//  Melon.swift
//  SeSAC_WEEK12
//
//  Created by SEUNGMIN OH on 2021/12/14.
//

import UIKit
import SnapKit

class MelonViewController: UIViewController {
    // MARK: GradientBackgorundView
    let gradientBackgroundView = UIView()
    
    func setGradiendBackgroundViewUI() {
        let firstColor = UIColor(named: "gradient_first")!
        let secondColor = UIColor(named: "gradient_second")!
        let layer = makeGradientLayer(firstColor: firstColor, secondColor: secondColor)
        layer.frame = gradientBackgroundView.bounds
        gradientBackgroundView.layer.addSublayer(layer)
    }
    
    private func makeGradientLayer(firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        return layer
    }
    
    func setGradientBackgroundViewConstraint() {
        view.addSubview(gradientBackgroundView)
        gradientBackgroundView.frame = view.bounds
        gradientBackgroundView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.52)
        }
    }
    
    // MARK: TitleContainer
    let titleContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    let songIcon: UIImageView = {
        let tmp = UIImageView()
        tmp.image = UIImage(systemName: "music.note")
        tmp.tintColor = .systemGray2
        return tmp
    }()
    
    let titleLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "strawberry moon"
        tmp.font = .boldSystemFont(ofSize: 17)
        tmp.textColor = .white
        return tmp
    }()
    
    let singerLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "아이유"
        tmp.font = .systemFont(ofSize: 13)
        tmp.textColor = .systemGray2
        return tmp
    }()
    
    let foldButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        tmp.tintColor = .systemGray5
        return tmp
    }()
    
    let aboutButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        tmp.tintColor = .systemGray5
        return tmp
    }()
    
    func setTitleContainerConstraint() {
        view.addSubview(titleContainer)
        titleContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(55)
            make.left.right.equalTo(view).inset(13)
        }
        titleContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleContainer)
        }
        
        titleContainer.addSubview(songIcon)
        songIcon.snp.makeConstraints { make in
            make.size.equalTo(titleLabel.snp.height)
            make.right.equalTo(titleLabel.snp.left).offset(-5)
            make.centerY.equalTo(titleLabel)
        }
        
        titleContainer.addSubview(singerLabel)
        singerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleContainer)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        titleContainer.addSubview(foldButton)
        foldButton.snp.makeConstraints { make in
            make.top.right.equalTo(titleContainer)
            make.size.equalTo(songIcon)
        }
        
        titleContainer.addSubview(aboutButton)
        aboutButton.snp.makeConstraints { make in
            make.bottom.right.equalTo(titleContainer)
            make.size.equalTo(songIcon)
        }
    }
    
    
    // MARK: PlayerBackgroundView
    let playerBackgroundView: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = .black
        
        return tmp
    }()
    
    func setPlayerBackgroundViewConstraint() {
        view.addSubview(playerBackgroundView)
        playerBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(gradientBackgroundView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    // MARK: AlbumImageView
    let albumImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.image = UIImage(named: "strawberry_moon")
        tmp.layer.cornerRadius = 4
        tmp.layer.masksToBounds = true
        return tmp
    }()
    
    func setAlbumImageViewConstraint() {
        view.addSubview(albumImageView)
        albumImageView.snp.makeConstraints { make in
            make.width.equalTo(albumImageView.snp.height).multipliedBy(1.0 / 1.0)
            make.left.right.equalTo(view).inset(30)
            make.bottom.equalTo(playerBackgroundView.snp.top).inset(30)
        }
    }
    
    // MARK: SongInfoContainer
    let songInfoContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    let heartToggleButton: UIButton = {
        let tmp = UIButton(type: .custom)
        tmp.setImage(UIImage(systemName: "heart"), for: .normal)
        tmp.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        tmp.contentMode = .scaleAspectFit
        tmp.tintColor = .systemGray2
        tmp.addTarget(self, action: #selector(heartToggleButtonTapped), for: .touchUpInside)
        return tmp
    }()
    
    @objc
    func heartToggleButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    let heartCountLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "101,354"
        tmp.textColor = .systemGray2
        tmp.font = .boldSystemFont(ofSize: 15)
        return tmp
    }()
    
    let similarSongButton: UIButton = {
        let tmp = UIButton()
        tmp.setTitle("유사곡", for: .normal)
        tmp.titleLabel?.font = .systemFont(ofSize: 12)
        tmp.tintColor = .systemGray5
        tmp.layer.borderWidth = 1
        tmp.layer.borderColor = UIColor.darkGray.cgColor
        tmp.layer.cornerRadius = 5
        return tmp
    }()
    
    let instagramButton: UIButton = {
        let tmp = UIButton()
        tmp.setImage(UIImage(named: "icon_instagram"), for: .normal)
        return tmp
    }()
    
    func setSongInfoContainerConstraint() {
        view.addSubview(songInfoContainer)
        songInfoContainer.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(16)
            make.height.equalTo(35)
            make.left.right.equalTo(view).inset(25)
        }
        
        songInfoContainer.addSubview(heartToggleButton)
        heartToggleButton.snp.makeConstraints { make in
            make.left.centerY.equalTo(songInfoContainer)
            make.size.equalTo(songInfoContainer.snp.height)
        }
        
        songInfoContainer.addSubview(heartCountLabel)
        heartCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(songInfoContainer)
            make.left.equalTo(heartToggleButton.snp.right).offset(3)
        }
        
        songInfoContainer.addSubview(instagramButton)
        instagramButton.snp.makeConstraints { make in
            make.centerY.equalTo(songInfoContainer)
            make.right.equalTo(songInfoContainer)
            make.size.equalTo(songInfoContainer.snp.height)
        }
        
        songInfoContainer.addSubview(similarSongButton)
        similarSongButton.snp.makeConstraints { make in
            make.centerY.equalTo(songInfoContainer)
            make.right.equalTo(instagramButton.snp.left).offset(-7)
            make.width.equalTo(55)
            make.height.equalTo(25)
        }
        
    }
    
    // MARK: LyricConatiner
    let lyricContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    func setLyricContainerConstraint() {
        view.addSubview(lyricContainer)
        lyricContainer.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(8)
            make.top.equalTo(songInfoContainer.snp.bottom)
            make.bottom.equalTo(statusContainer.snp.top)
        }
    }
    
    let lyric: UILabel = {
        let tmp = UILabel()
        tmp.text = "달이 익어가니 서둘러 젊은 피야\n민들레 한 송이 들고"
        tmp.textColor = .systemGray2
        tmp.font = .boldSystemFont(ofSize: 15)
        tmp.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: tmp.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        tmp.attributedText = attrString
        tmp.textAlignment = .center
        return tmp
    }()
    
    func setLyricConstraint() {
        lyricContainer.addSubview(lyric)
        lyric.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(lyricContainer)
        }
    }
    
    // MARK: statusContainer
    let statusContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    let repeatButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        tmp.tintColor = .systemGray2
        return tmp
    }()
    
    let progressBar: UIProgressView = {
        let tmp = UIProgressView()
        tmp.tintColor = .systemGreen
        tmp.progress = 0.2
        return tmp
    }()
    
    let currentTimeLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "0:04"
        tmp.font = .boldSystemFont(ofSize: 11)
        tmp.textColor = .systemGreen
        return tmp
    }()
    
    let runningTimeLabel: UILabel = {
        let tmp = UILabel()
        tmp.text = "1:00"
        tmp.font = .boldSystemFont(ofSize: 11)
        tmp.textColor = .systemGray2
        return tmp
    }()
    
    let shuffleButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "shuffle"), for: .normal)
        tmp.tintColor = .systemGray2
        return tmp
    }()
    
    func setStatusContainerConstraint() {
        view.addSubview(statusContainer)
        statusContainer.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(13)
            make.height.equalTo(35)
            make.bottom.equalTo(controlContainer.snp.top).offset(-16)
        }
        
        statusContainer.addSubview(repeatButton)
        repeatButton.snp.makeConstraints { make in
            make.left.centerY.equalTo(statusContainer)
            make.width.equalTo(35)
            make.height.equalTo(16)
        }
        
        statusContainer.addSubview(shuffleButton)
        shuffleButton.snp.makeConstraints { make in
            make.right.centerY.equalTo(statusContainer)
            make.width.equalTo(35)
            make.height.equalTo(16)
        }
        
        statusContainer.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.centerX.equalTo(statusContainer)
            make.top.equalTo(repeatButton)
            make.left.equalTo(repeatButton.snp.right).inset(-10)
            make.right.equalTo(shuffleButton.snp.left).inset(-10)
        }
        
        statusContainer.addSubview(currentTimeLabel)
        currentTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar).offset(8)
            make.left.equalTo(progressBar)
        }
        statusContainer.addSubview(runningTimeLabel)
        runningTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar).offset(8)
            make.right.equalTo(progressBar)
        }
    }
    
    // MARK: controlContainer
    let controlContainer: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = nil
        return tmp
    }()
    
    let listButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "music.note.list"), for: .normal)
        tmp.tintColor = .white
        return tmp
    }()
    
    let previousButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        tmp.tintColor = .white
        return tmp
    }()
    
    let playPauseButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "play.fill"), for: .normal)
        tmp.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        tmp.tintColor = .white
        tmp.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return tmp
    }()
    
    @objc
    func playPauseButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    let nextButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        tmp.tintColor = .white
        return tmp
    }()
    
    let EQButton: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setImage(UIImage(systemName: "speaker.badge.exclamationmark"), for: .normal)
        tmp.tintColor = .white
        return tmp
    }()
    
    func setControlContainerConstraint() {
        view.addSubview(controlContainer)
        controlContainer.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(13)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(50)
        }
        
        controlContainer.addSubview(listButton)
        listButton.snp.makeConstraints { make in
            make.left.centerY.equalTo(controlContainer)
            make.size.equalTo(30)
        }
        controlContainer.addSubview(playPauseButton)
        playPauseButton.snp.makeConstraints { make in
            make.center.equalTo(controlContainer)
            make.size.equalTo(70)
        }
        controlContainer.addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            make.centerY.equalTo(controlContainer)
            make.right.equalTo(playPauseButton.snp.left).inset(-20)
            make.size.equalTo(30)
        }
        controlContainer.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(controlContainer)
            make.left.equalTo(playPauseButton.snp.right).inset(-20)
            make.size.equalTo(30)
        }
        controlContainer.addSubview(EQButton)
        EQButton.snp.makeConstraints { make in
            make.right.centerY.equalTo(controlContainer)
            make.size.equalTo(30)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackgroundViewConstraint()
        setGradiendBackgroundViewUI()
        setPlayerBackgroundViewConstraint()
        
        setTitleContainerConstraint()
        
        setAlbumImageViewConstraint()
        
        setSongInfoContainerConstraint()
        setControlContainerConstraint()
        setStatusContainerConstraint()
        setLyricContainerConstraint()
        setLyricConstraint()
    }
}
