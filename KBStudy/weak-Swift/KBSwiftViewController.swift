//
//  KBSwiftViewController.swift
//  KBStudy
//
//  Created by 韩金波 on 2018/12/27.
//  Copyright © 2018 韩金波. All rights reserved.
//

import UIKit

class KBSwiftViewController: UIViewController {

    let view2 = KBSwiftSubview()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        let view = KBSwiftSubview()
        self.view.addSubview(view)
        view.bolck = { [weak self] (a: Int, b: Int)  in
            guard let weakSelf = self else {
                return
            }
            weakSelf.view2.bolck = { (a: Int, b: Int)  in
                weakSelf.load()
            }
        }
//        view.bolck = { (a: Int, b: Int)  in
//
//            self.load()
//        }

        
    }
    
    func load() -> Void {
        
    }
    
    deinit {
        print("deinit")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class KBSwiftSubview: UIView {
    var bolck : ((_:Int, _:Int) -> (Void))?
    
    
}
