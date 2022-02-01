//
//  ViewController.swift
//  UISlider
//
//  Created by MacBook on 28.01.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //Создаем Outlet слайдера громкости
    @IBOutlet weak var sliderBoard: UISlider!
    
    var player = AVAudioPlayer()
    let slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Создаем слайдер, прописали координаты и размер
        slider.frame = CGRect(x: 0, y: 0, width: 250, height: 29)
        self.slider.center = self.view.center
        self.view.addSubview(slider)
        //Назначили минимальное значение
        self.slider.minimumValue = 0.0
        //Назначили максимальное значение
        self.slider.maximumValue = 100.0
        //Меняем цвет ползунка
        self.slider.thumbTintColor = UIColor.systemGreen
        //Меняем цвет слайдера
        self.slider.maximumTrackTintColor = UIColor.systemRed
        
        //Добавляем таргет
        self.slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        do {
            //Добавили путь к аудио записи
            if let audioPath = Bundle.main.path(forResource: "Robertino", ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                //Установили продолжительность звука
                self.slider.maximumValue = Float(player.duration)
                }
        } catch {
            print("Error")
        }
        self.player.play()
    }
    //MARK: - Метод
    @objc func changeSlider(sender: UISlider) {
        if sender == slider {
            self.player.currentTime = TimeInterval(sender.value)
        }
    }
    //MARK: - Создали две кнопки и добавили Action
    @IBAction func playButton(_ sender: Any) {
        self.player.play()
    }
    @IBAction func PauseButton(_ sender: Any) {
        self.player.pause()
    }
    //Создали Action слайдера громкости
    @IBAction func sliderAction(_ sender: Any) {
        self.player.volume = self.sliderBoard.value
    }
}

