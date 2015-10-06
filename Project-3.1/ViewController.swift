//
//  ViewController.swift
//  Project-3.1
//
//  Created by Chris Mikelson on 10/5/15.
//  Copyright © 2015 Chris Mikelson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mailboxScrollView: UIScrollView!
    
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet var messagePanGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var feedImage: UIImageView!

    @IBOutlet weak var laterNavIcon: UIImageView!
    @IBOutlet weak var archiveNavIcon: UIImageView!
    @IBOutlet weak var deleteNavIcon: UIImageView!
    @IBOutlet weak var listNavIcon: UIImageView!
    
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    let bgGrey = UIColor.lightGrayColor()
    let bgYellow = UIColor.yellowColor()
    let bgGreen = UIColor.greenColor()
    let bgRed = UIColor.redColor()
    let bgBrown = UIColor.brownColor()
    
    var messageOriginalCenter: CGPoint!
    var laterNavIconOriginalCenter: CGPoint!
    var listNavIconOriginalCenter: CGPoint!
    var archiveNavIconOriginalCenter: CGPoint!
    var deleteNavIconOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mailboxScrollView.contentSize = CGSize(width: 320, height: 1432)
        
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        messageContainerView.backgroundColor = bgGrey;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onMessageSwipe(sender: UIPanGestureRecognizer) {
        
//        let point = messagePanGestureRecognizer.locationInView(view)
        let translation = sender.translationInView(view)
//        var velocity = sender.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            messageOriginalCenter = messageImage.center
            archiveNavIconOriginalCenter = archiveNavIcon.center
            deleteNavIconOriginalCenter = deleteNavIcon.center
            laterNavIconOriginalCenter = laterNavIcon.center
            listNavIconOriginalCenter = listNavIcon.center
        
        } else if sender.state == UIGestureRecognizerState.Changed {
            
//            print("Moved: \(translation.x)")
            
            messageImage.center.x = messageOriginalCenter.x + translation.x
            
            switch translation.x {
                case -screenWidth ... -260:
                    
                    listNavIcon.center.x = listNavIconOriginalCenter.x + translation.x + 60
                    
                    listNavIcon.alpha = 1.0;
                    deleteNavIcon.alpha = 0;
                    laterNavIcon.alpha = 0;
                    archiveNavIcon.alpha = 0;
                    
                    self.messageContainerView.backgroundColor = self.bgBrown;
                
                case -260 ... -60:
                
                    laterNavIcon.center.x = laterNavIconOriginalCenter.x + translation.x + 60
                    
                    listNavIcon.alpha = 0;
                    deleteNavIcon.alpha = 0;
                    laterNavIcon.alpha = 1.0;
                    archiveNavIcon.alpha = 0;
                    
                    self.messageContainerView.backgroundColor = self.bgYellow;
                
                case 60 ... 260:
                
                    archiveNavIcon.center.x = archiveNavIconOriginalCenter.x + translation.x - 60
                    
                    listNavIcon.alpha = 0;
                    deleteNavIcon.alpha = 0;
                    laterNavIcon.alpha = 0;
                    archiveNavIcon.alpha = 1.0;
                    
                    self.messageContainerView.backgroundColor = self.bgGreen;
                
                case 260 ... screenWidth:
                    
                    deleteNavIcon.center.x = deleteNavIconOriginalCenter.x + translation.x - 60
                    
                    listNavIcon.alpha = 0;
                    deleteNavIcon.alpha = 1.0;
                    laterNavIcon.alpha = 0;
                    archiveNavIcon.alpha = 0;
                    
                    self.messageContainerView.backgroundColor = self.bgRed;
            
                default:
                    
                    listNavIcon.alpha = 0;
                    deleteNavIcon.alpha = 0;
                    laterNavIcon.alpha = 0.1;
                    archiveNavIcon.alpha = 0.1;
                    
                    self.messageContainerView.backgroundColor = self.bgGrey;
                
            }
        
        } else if sender.state == UIGestureRecognizerState.Ended {
            
                switch translation.x {
                    case -screenWidth ... -260:
                        print("-320 ... -260")
        
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            self.messageImage.center.x = -self.screenWidth/2;
                            self.listNavIcon.alpha = 0;
                            
                            }, completion: { (completed) -> Void in
                                UIView.animateWithDuration(0.25, animations: { () -> Void in
                                    self.listImage.alpha = 1;
                                })
                        })
                    
                    
                
                    case -260 ... -60:
                        print("-260 ... -60")
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            
                            self.messageImage.center.x = -self.screenWidth/2;
                            self.laterNavIcon.center = self.laterNavIconOriginalCenter
                            self.listNavIcon.center = self.listNavIconOriginalCenter
                            
                            }, completion: { (completed) -> Void in
                                UIView.animateWithDuration(0.25, animations: { () -> Void in
                                    self.rescheduleImage.alpha = 1;
                                })
                        })
                    
                    case 60 ... 260:
                        print("60 ... 260")
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            
                            self.messageImage.center.x = self.screenWidth*2;
                            self.listNavIcon.alpha = 0;
                            
                            }, completion: { (completed) -> Void in
                                UIView.animateWithDuration(0.25, animations: { () -> Void in
                                    self.messageContainerView.center.y -= self.messageImage.center.y*2
                                    self.messageContainerView.alpha = 0
                                    self.feedImage.center.y -= self.messageImage.center.y*2
                                })                        })
                    
                    case 260 ... screenWidth:
                        print("260 ... 320")
                    
                    
                    default:
                
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                            self.messageImage.center.x = self.messageOriginalCenter.x
                    
                        })
                    }
        
        }
        
    }
    @IBAction func rescheduleImageTapRecognizer(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.25) { () -> Void in
            self.rescheduleImage.alpha = 0;
            self.messageContainerView.center.y -= self.messageImage.center.y*2
            self.messageContainerView.alpha = 0
            self.feedImage.center.y -= self.messageImage.center.y*2
        }
        
    }
    @IBAction func listImageTapRecognizer(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.listImage.alpha = 0;
            self.messageContainerView.center.y -= self.messageImage.center.y*2
            self.messageContainerView.alpha = 0
            self.feedImage.center.y -= self.messageImage.center.y*2
        }
    }
}

