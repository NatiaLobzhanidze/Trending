//
//  LottieAnimatedScene.swift
//  Trending
//
//  Created by Natia's Mac on 12.02.23.
//

import UIKit
import Lottie

final class LottieAnimatedScene: UIViewController {
    
    private var lottieAnimation: LottieAnimationView?
    private var backLottieAnimation: LottieAnimationView?
    
    private let reTryBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("RETRY ", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.greenSea.cgColor
        btn.setTitleColor(.greenSea, for: .normal)
        
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending"
        view.backgroundColor = .white
        reTryBtn.addTarget(self, action: #selector(reTryBtnClicked), for: .touchUpInside)
        setUpLottie()
    }
    
    private func setUpLottie() {
         
        self.lottieAnimation = LottieAnimationView(name: "busy")
        self.lottieAnimation?.contentMode = .scaleAspectFit
        self.view.addSubview(self.lottieAnimation!)
        lottieAnimation?.centerY(inView: view)
        lottieAnimation?.centerX(inView: view)
        self.lottieAnimation?.loopMode = .loop
        self.lottieAnimation?.play()
        view.addSubview(reTryBtn)
        reTryBtn.anchor(top: lottieAnimation?.bottomAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor,
                        paddingTop: 30, paddingLeft: 30,
                        paddingRight: 30, height: 45)
       
    }
    
    @objc func reTryBtnClicked(){
        let vc = HomeSceneConfiguration.configure()
        self.navigationController?.pushViewController(vc, animated: true )
    }
}
