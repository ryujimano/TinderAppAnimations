//
//  CardsViewController.swift
//  TinderApp
//
//  Created by Ryuji Mano on 4/6/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var cardOriginalCenter: CGPoint!
    var cardChangingCenter: CGPoint!

    @IBOutlet weak var profileView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didDragCard(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        let velocity = sender.velocity(in: self.view)
        let translation = sender.translation(in: self.view)
        
        if sender.state == .began {
            cardOriginalCenter = profileView.center
            cardChangingCenter = profileView.center
            profileView.transform = CGAffineTransform(rotationAngle: 0)
        }
        else if sender.state == .changed {
            profileView.center = CGPoint(x: cardOriginalCenter.x + translation.x, y: cardOriginalCenter.y + translation.y)
            
            if cardChangingCenter.x < profileView.center.x {
                if cardOriginalCenter.y < location.y {
                    profileView.transform = profileView.transform.rotated(by: CGFloat(M_PI.divided(by: -180)))
                }
                else {
                    profileView.transform = profileView.transform.rotated(by: CGFloat(M_PI.divided(by: 180)))
                }
            }
            else {
                if cardOriginalCenter.y < location.y {
                    profileView.transform = profileView.transform.rotated(by: CGFloat(M_PI.divided(by: 180)))
                }
                else {
                    profileView.transform = profileView.transform.rotated(by: CGFloat(M_PI.divided(by: -180)))
                }
            }
            
            cardChangingCenter = profileView.center
        }
        else if sender.state == .ended {
            if profileView.center.x - cardOriginalCenter.x > 100 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.profileView.center.x = self.cardOriginalCenter.x.multiplied(by: 4)
                }, completion: { (completed) in
                    sleep(1)
                    self.profileView.center = self.cardOriginalCenter
                    self.profileView.transform = CGAffineTransform.identity
                })
            }
            else if profileView.center.x - cardOriginalCenter.x < -100 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.profileView.center.x = self.cardOriginalCenter.x.multiplied(by: -2)
                }, completion: { (completed) in
                    sleep(1)
                    self.profileView.center = self.cardOriginalCenter
                    self.profileView.transform = CGAffineTransform.identity
                })
            }
            else {
                profileView.center = cardOriginalCenter
                profileView.transform = CGAffineTransform.identity
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
