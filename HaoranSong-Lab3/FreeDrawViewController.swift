//
//  FreeDrawViewController.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 10/2/22.
//

import UIKit

class FreeDrawViewController: UIViewController {
    
    var shapeCanvas: DrawingView!
    var currentLine: Line?
    var points: [CGPoint] = []
    
    var funcValue = 0
    
    @IBOutlet weak var blackLb: UIButton!
    @IBOutlet weak var greenLb: UIButton!
    @IBOutlet weak var yellowLb: UIButton!
    @IBOutlet weak var redLb: UIButton!
    @IBOutlet weak var blueLb: UIButton!
    @IBOutlet weak var currentLb: UIButton!
    @IBAction func blackBtn(_ sender: Any) {
        currentLb.backgroundColor = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00)
    }
    @IBAction func yellowBtn(_ sender: Any) {
        currentLb.backgroundColor = UIColor(red: 0.96, green: 0.92, blue: 0.16, alpha: 1.00)
    }
    @IBAction func redBtn(_ sender: Any) {
        currentLb.backgroundColor = UIColor(red: 0.85, green: 0.12, blue: 0.02, alpha: 1.00)
    }
    @IBAction func greenBtn(_ sender: Any) {
        currentLb.backgroundColor = UIColor(red: 0.10, green: 0.98, blue: 0.16, alpha: 1.00)
    }
    @IBAction func blueBtn(_ sender: Any) {
        currentLb.backgroundColor = UIColor(red: 0.07, green: 0.59, blue: 0.86, alpha: 1.00)
    }
    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var drawingArea: UIView!
    @IBAction func clearBtn(_ sender: Any){
        shapeCanvas.items = []
    }
    @IBAction func funcSelect(_ sender: UISegmentedControl) {
        funcValue = sender.selectedSegmentIndex
    }
    @IBAction func funcSave(_ sender: Any) {
        if(shapeCanvas.items.count>0){
            let frame = drawingArea.frame
            UIGraphicsBeginImageContext(frame.size)
            drawingArea.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.loadImage(image: image!)
        }else{
            alert(title: "Error！", message: "Create some shapes before your save")
        }
    }
    
    func loadImage(image:UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(image: UIImage, didFinishSavingWithError: NSError?,contextInfo: AnyObject)
    {
        if didFinishSavingWithError != nil
        {
            alert(title: "Error！", message: "Unable to Save")
            return
        }
        alert(title: "Congratulations！", message: "Successfully Saved Shapes to Photo Library")
    }
    
    func alert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        shapeCanvas = DrawingView(frame: view.frame)
        drawingArea.addSubview(shapeCanvas)
        view.bringSubviewToFront(functionView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
        let touchPoint = touches.first?.location(in: drawingArea) as CGPoint?
        else{ return }
        
        if(funcValue==0){
            shapeCanvas.backgroundColor = UIColor.clear
            currentLine = Line(origin: touchPoint, color: currentLb.backgroundColor!)
            points.append(touchPoint)
            currentLine?.allPoints = points
            shapeCanvas.items.append(currentLine!)
        }else if(funcValue==1){
            if(shapeCanvas.items.count>0){
                shapeCanvas.items.removeLast()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
        let touchPoint = touches.first?.location(in: drawingArea) as CGPoint?
        else{ return }
        if(funcValue==0){
            points.append(touchPoint)
            if let temp = shapeCanvas.items.last as? Line{
                temp.allPoints = points
                shapeCanvas.items[shapeCanvas.items.endIndex-1] = temp
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(funcValue==0){
            points = []
        }
    }
}
