//
//  AnimatedText.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import UIKit

protocol AnimatedTextViewManagerProtocol {
    func startCycling()
}

class AnimatedTextViewManager {
    // MARK: - Private Properties
    private let texts: [String]
    private weak var label: UILabel?
    private var currentIndex: Int = 0
    private var updater: DispatchSourceTimer?
    
    // MARK: - Initializer & Deinitializer
    init(texts: [String],
         label: UILabel) {
        self.texts = texts
        self.label = label
    }
    
    deinit {
        stopCycling()
    }
}

extension AnimatedTextViewManager: AnimatedTextViewManagerProtocol {
    func startCycling() {
        stopCycling()
        let updater = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        updater.schedule(deadline: .now(),
                         repeating: 2.5)
        updater.setEventHandler { [weak self] in
            self?.updateLabelText()
        }
        self.updater = updater
        updater.resume()
    }
    
    private func stopCycling() {
        updater?.cancel()
        updater = nil
    }
    
    private func updateLabelText() {
        guard !texts.isEmpty,
              let label = label else { return }
        
        UIView.transition(with: label,
                          duration: 1.0,
                          options: .transitionFlipFromTop,
                          animations: {
            label.text = self.texts[self.currentIndex]
        })
        
        currentIndex = (currentIndex + 1) % texts.count
    }
}
