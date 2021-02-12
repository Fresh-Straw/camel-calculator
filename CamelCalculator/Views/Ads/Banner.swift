//
//  https://github.com/MichaelBarney/SwiftUI_AdMob/blob/master/Banner.swift
//

import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {
    private let bannerID: String
    
    init(bannerID: String) {
        self.bannerID = bannerID
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        view.adUnitID = bannerID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    var bannerID: String
    
    var body: some View{
        HStack{
            Spacer()
            BannerVC(bannerID: bannerID).frame(width: 320, height: 50, alignment: .center)
            Spacer()
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner(bannerID: "")
    }
}
