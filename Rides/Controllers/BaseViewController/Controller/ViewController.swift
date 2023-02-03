//
//  ViewController.swift
//  Rides
//
//  Created by ShanuGeet on 2023-01-29.
//

import UIKit


class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
           
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleListVC") as? VehicleListVC
          
            self.navigationController?.pushViewController(vc!, animated: true)
            self.player?.pause()
            self.playerLayer?.removeFromSuperlayer()
        }
        
    }


}

