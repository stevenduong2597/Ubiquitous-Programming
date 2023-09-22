//
//  ViewController.swift
//  ExamPractice1
//
//  Created by Steven Duong on 9/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    let topicImages: [UIImage] = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3")]
    let cardLabels: [String] = ["View Controler", "UIKit", "UIAlertControler"]
    let cardContent = [
                       "View Controler": ["defines the behavior for common VCs",
                                                "updates the content of the view",
                                                "responding to user interactions",
                                                "resizing views and layout mgmnt",
                                                "coordinating with other objects"],
                       "UIKit": ["provides required iOS infrastructure",
                                       "window and view architecture",
                                       "event handling for milti-touch and etc",
                                       "manages interation with system",
                                       "a lot of features incl. resource mgmnt"],
                       "UIAlertControler": ["configure alerts and action sheets",
                                                  "intended to be used as-is",
                                                  "does not support sibclassing",
                                                  "inherits from UIViewController",
                                            "support text fields to the alert interface "]]
    
    var cardIdx = 0
    
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardFirstContent: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLabelAndFirstContent()
        displayContent()
    }
    
    func displayLabelAndFirstContent(){
        //display first content
        let starAttachment = NSTextAttachment()
        starAttachment.image = UIImage(systemName: "star.fill")
        let starString = NSAttributedString(attachment: starAttachment)
        var textString = NSAttributedString(string: cardContent[cardLabels[cardIdx]]![0])
        var combinedString = NSMutableAttributedString(attributedString: starString)
        combinedString.append(textString)
        cardFirstContent.attributedText=combinedString
        
        //display label text
        cardLabel.text = "Card: \(cardLabels[cardIdx])"
    }

    func displayContent(){
        var previousLabel:UILabel=cardFirstContent

        for (_,contentText) in cardContent[cardLabels[cardIdx]]!.dropFirst().enumerated(){
            var newContent=UILabel()
            
            //Make label with star icon
            let starAttachment = NSTextAttachment()
            starAttachment.image = UIImage(systemName: "star.fill")
            let starString = NSAttributedString(attachment: starAttachment)
            var textString = NSAttributedString(string: contentText)
            var combinedString = NSMutableAttributedString(attributedString: starString)
            combinedString.append(textString)
            
            // Copy properties from the lastLabel
            newContent.frame.size = previousLabel.frame.size
            newContent.font = previousLabel.font
            newContent.textAlignment = previousLabel.textAlignment
            newContent.textColor = previousLabel.textColor
            newContent.backgroundColor = previousLabel.backgroundColor
            // The below properties put long text in 2 ines
            newContent.numberOfLines = previousLabel.numberOfLines // 2 lines
            newContent.lineBreakMode = previousLabel.lineBreakMode //truncate tail
            newContent.adjustsFontSizeToFitWidth = true //similar to autoshrink in storyboard
            // Set the text to the new value
            newContent.attributedText = combinedString
            
            // Position the new label directly below the last label
            newContent.frame.origin.x = previousLabel.frame.origin.x
            newContent.frame.origin.y = previousLabel.frame.origin.y + previousLabel.frame.size.height
            
            // Add the new label to the view
            self.view.addSubview(newContent)
             previousLabel = newContent
            
        }
    }
    
    @IBAction func randomCard(_ sender: Any) {
        var randomIdx = Int.random(in: 0 ... 2)
        cardIdx = randomIdx
        displayLabelAndFirstContent()
        displayContent()
    }
    
    @IBAction func nextCard(_ sender: Any) {
        cardIdx = (cardIdx+1)%cardLabels.count
        displayLabelAndFirstContent()
        displayContent()
    }
    
    @IBAction func cardSelector(_ sender: Any) {
        let actionSheetAlert = UIAlertController(title: "Pick a card", message: "", preferredStyle: .actionSheet)
        for label in cardLabels {
            actionSheetAlert.addAction(UIAlertAction(title: label, style: .default, handler: {_ in
                self.cardIdx = self.cardLabels.firstIndex(of: label)!
                self.viewDidLoad()
            }))
        }
        actionSheetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(actionSheetAlert, animated: true, completion: nil)
    }
    
    
    

}

