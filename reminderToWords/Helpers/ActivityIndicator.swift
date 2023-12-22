//
//  ActivityIndicator.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 22.12.2023.
//

import UIKit

class ActivityIndicator: NSObject {
    // Static değişkenler tanımla
    static public var activityIndicator = UIActivityIndicatorView()
    static public var loadingView = UIView()

    // ActivityIndicator'ü başlatan static fonksiyon
    static func showSpinner(obj: UIViewController) {
        // ActivityIndicator özelliklerini ayarla
        activityIndicator.style = .large
        activityIndicator.center = obj.view.center
        activityIndicator.hidesWhenStopped = true
        // LoadingView özelliklerini ayarla
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = obj.view.center
        loadingView.backgroundColor = .clear
        // ActivityIndicator'ü ve LoadingView'i ekrana ekle
        obj.view.addSubview(loadingView)
        obj.view.addSubview(activityIndicator)
        // ActivityIndicator'ü çalıştır
        activityIndicator.startAnimating()
    }

    // ActivityIndicator'ü durduran static fonksiyon
    static func hideSpinner() {
        // ActivityIndicator'ü durdur
        activityIndicator.stopAnimating()
        // ActivityIndicator'ü ve LoadingView'i ekrandan kaldır
        activityIndicator.removeFromSuperview()
        loadingView.removeFromSuperview()
    }
}

