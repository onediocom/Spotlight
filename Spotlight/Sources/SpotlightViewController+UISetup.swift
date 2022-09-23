//
//  SpotlightViewController+UISetup.swift
//  Spotlight
//
//  Created by Lekshmi Raveendranathapanicker on 2/5/18.
//  Copyright © 2018 Lekshmi Raveendranathapanicker. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UI Setup

extension SpotlightViewController {
    func setup() {
        modalPresentationStyle = .overFullScreen
    }

    func setupSpotlightView() {
        spotlightView.frame = UIScreen.main.bounds
        spotlightView.backgroundColor = .clear
        spotlightView.alpha = Spotlight.alpha
        spotlightView.isUserInteractionEnabled = false
        guard let view = view else { return }
        view.insertSubview(spotlightView, at: 0)
        view.addConstraints([NSLayoutConstraint.Attribute.top, .bottom, .left, .right].map {
            NSLayoutConstraint(item: view, attribute: $0, relatedBy: .equal, toItem: spotlightView, attribute: $0, multiplier: 1, constant: 0)
        })
    }
    
    func setupInitView() {
        let imageView = UIImageView()
        
        initialButton = createInitialButton()
        initialButton.setTitle(Spotlight.initialButtonTitle, for: .normal)
        initialButton.isHidden = false
        let buttonStack = UIStackView(arrangedSubviews: [createSpacer(), initialButton, createSpacer()])
        buttonStack.axis = .vertical
        buttonStack.alignment = .center
        
        titleLabel = createInitTitle()
        infoLabel = createInitLabel()
        if let firstNode = spotlightNodes.first {
            imageView.image = firstNode.image
            titleLabel.text = firstNode.title
            infoLabel.text = firstNode.text
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.width * imageView.image!.size.height / imageView.image!.size.width ))
        imageView.contentMode = .scaleAspectFill
        imageView.tag = 101
        
        initStackView = UIStackView(arrangedSubviews: [titleLabel, infoLabel, buttonStack])
        initStackView.tag = 100
        initStackView.axis = .vertical
        initStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        initStackView.isLayoutMarginsRelativeArrangement = true
        initStackView.spacing = 16
        initStackView.layer.cornerRadius = 7

        view.addSubview(imageView)
        view.addSubview(initStackView)
        view.bringSubviewToFront(initStackView)

        
        initStackView.translatesAutoresizingMaskIntoConstraints = false
        initStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        initStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        initStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        initStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func setupInfoView(load: Bool = true) {
        let closeButton = createCloseButton()
        let closeStackView = UIStackView(arrangedSubviews: [createSpacer(), closeButton])
        closeStackView.axis = .horizontal
        closeStackView.alignment = .trailing
        closeStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        backButton = createBackButton()
        backButton.setTitle(Spotlight.backButtonTitle, for: .normal)
        backButton.isHidden = true // Will be shown later
        nextButton = createButton()
        nextButton.setTitle(Spotlight.nextButtonTitle, for: .normal)
        let buttonsStack = UIStackView(arrangedSubviews: [backButton, createSpacer(), nextButton])
        buttonsStack.axis = .horizontal

        titleLabel = createTitleLabel()
        infoLabel = createLabel()
        if let firstNode = spotlightNodes.first {
            infoLabel.text = firstNode.text
        }
        let combinedStackView = UIStackView(arrangedSubviews: [titleLabel, infoLabel, buttonsStack])
        combinedStackView.axis = .vertical
        combinedStackView.spacing = 16

        infoStackView = UIStackView(arrangedSubviews: [combinedStackView])
        infoStackView.axis = .vertical
        infoStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        infoStackView.isLayoutMarginsRelativeArrangement = true
        infoStackView.spacing = 16
        infoStackView.layer.cornerRadius = 7

        if Spotlight.showInfoBackground {
//            insertBackgroundBlur()
            infoStackView.backgroundColor = .white
//            UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        }

        if load == true {
            view.addSubview(infoStackView)
            infoStackView.translatesAutoresizingMaskIntoConstraints = false
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
            infoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            infoStackTopConstraint = infoStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 80)
            infoStackBottomConstraint = infoStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -80)
            infoStackTopConstraint.priority = .defaultLow
            infoStackBottomConstraint.priority = .defaultHigh
            infoStackTopConstraint.isActive = true
            infoStackBottomConstraint.isActive = true
        }
    }
    
    func loadInfoView() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        } else {
            print("DEBUG: tag not found")
        }
        
        if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
        } else {
            print("DEBUG: tag not found")
        }
        
        view.addSubview(infoStackView)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        infoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        infoStackTopConstraint = infoStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 120)
        infoStackBottomConstraint = infoStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -120)
        infoStackTopConstraint.priority = .defaultLow
        infoStackBottomConstraint.priority = .defaultHigh
        infoStackTopConstraint.isActive = true
        infoStackBottomConstraint.isActive = true
        
    }
    
    func createInitialButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 39/255, green: 108/255, blue: 217/255, alpha: 1)
        button.titleLabel?.font = Spotlight.font.withSize(16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 7.0
        button.widthAnchor.constraint(equalToConstant: 158).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(self, action: #selector(SpotlightViewController.buttonPressed(_:)), for: .touchUpInside)

        return button
    }

    func createButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 39/255, green: 108/255, blue: 217/255, alpha: 1)
        button.titleLabel?.font = Spotlight.font.withSize(12)
        button.setTitleColor(.white, for: .normal)
//        button.layer.borderColor = Spotlight.textColor.cgColor
        button.layer.cornerRadius = 7.0
//        button.layer.borderWidth = 1.0
        button.widthAnchor.constraint(equalToConstant: 76).isActive = true
        button.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        button.addTarget(self, action: #selector(SpotlightViewController.buttonPressed(_:)), for: .touchUpInside)

        return button
    }
    
    func createBackButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        button.titleLabel?.font = Spotlight.font.withSize(12)
//        button.titleLabel?.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
        button.setTitleColor(UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1), for: .normal)
//        button.layer.borderColor = Spotlight.textColor.cgColor
        button.layer.cornerRadius = 7.0
//        button.layer.borderWidth = 1.0
        button.widthAnchor.constraint(equalToConstant: 76).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        button.addTarget(self, action: #selector(SpotlightViewController.buttonPressed(_:)), for: .touchUpInside)

        return button
    }

    func createCloseButton() -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "Close", in: Bundle(for: type(of: self)), compatibleWith: nil)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = Spotlight.textColor
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        button.addTarget(self, action: #selector(SpotlightViewController.buttonPressed(_:)), for: .touchUpInside)

        return button
    }

    func createSpacer() -> UIView {
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    func createInitTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 39/255, green: 108/255, blue: 217/255, alpha: 1)
        label.textAlignment = .left
        return label
    }
    
    func createInitLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Spotlight.textColor
        label.textAlignment = .left
        return label
    }

    func insertBackgroundBlur() {
        if let gradient = Spotlight.infoBackgroundGradient {
            gradient.cornerRadius = 10.0
            infoStackView.layer.insertSublayer(gradient, at: 0)
            return
        }
        
        let blurEffect = UIBlurEffect(style: Spotlight.infoBackgroundEffect)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        blurredEffectView.layer.cornerRadius = 10.0
        vibrancyEffectView.layer.cornerRadius = 10.0
        blurredEffectView.clipsToBounds = true
        vibrancyEffectView.clipsToBounds = true
        blurredEffectView.embedAndpin(to: infoStackView)
        vibrancyEffectView.embedAndpin(to: infoStackView)
    }

    func setupTapGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SpotlightViewController.viewTapped(_:)))
        view.addGestureRecognizer(gesture)
    }
}
