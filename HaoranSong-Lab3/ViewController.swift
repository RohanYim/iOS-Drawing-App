//
//  ViewController.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 9/30/22.
//

import UIKit

extension UIBezierPath {
    func rotate(by angleRadians: CGFloat){
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: angleRadians)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        self.apply(transform)
    }
}

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var currentCircle: Circle?
    var currentRect: Rectangle?
    var currentTri: Triangle?
    var currentOutlineCircle: OutlineCircle?
    var currentOutlineRect: OutlineRectangle?
    var currentOutlineTri: OutlineTriangle?
    var currentIndex: Int = -1

    var shapeCanvas: DrawingView!
    var shapeValue = 0
    var funcValue = 0
    var formatValue = 0
    
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
    @IBAction func clearBtn(_ sender: Any) {
        shapeCanvas.items = []
    }
    
    
    @IBAction func shapeSelect(_ sender: UISegmentedControl) {
        shapeValue = sender.selectedSegmentIndex
    }
    
    @IBAction func funcSelect(_ sender: UISegmentedControl) {
        funcValue = sender.selectedSegmentIndex
    }
    @IBAction func formatSelect(_ sender: UISegmentedControl) {
        formatValue = sender.selectedSegmentIndex
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
    UIGestureRecognizer) -> Bool { true }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        shapeCanvas = DrawingView(frame: view.frame)
        drawingArea.addSubview(shapeCanvas)
        self.navigationItem.title = "Best Drawing APP"
        view.bringSubviewToFront(functionView)
        let pinchGes = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesFired(_:)))
        shapeCanvas.addGestureRecognizer(pinchGes)
        let rotateGes = UIRotationGestureRecognizer(target: self, action: #selector(rotateGesFired(_:)))
        shapeCanvas.addGestureRecognizer(rotateGes)
        shapeCanvas.isUserInteractionEnabled = true
    }
    
    @objc func pinchGesFired(_ gesture: UIPinchGestureRecognizer){
        if(funcValue==1 && shapeCanvas.items.count>0){
            let loc = gesture.location(in: drawingArea)
            for (index,item) in shapeCanvas.items.reversed().enumerated(){
                let res = item.contains(point: loc)
                if(res==true){
                    currentIndex = shapeCanvas.items.count-index-1
                }
            }
            if(type(of: shapeCanvas.items[currentIndex])==Circle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Circle {
                    temp.radius *= gesture.scale
                    shapeCanvas.items[currentIndex] = temp
                    gesture.scale = 1
                }
            }else if(type(of: shapeCanvas.items[currentIndex])==Triangle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Triangle {
                    temp.side *= gesture.scale
                    shapeCanvas.items[currentIndex] = temp
                    gesture.scale = 1
                }
            }else if(type(of: shapeCanvas.items[currentIndex])==Rectangle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Rectangle {
                    temp.side *= gesture.scale
                    shapeCanvas.items[currentIndex] = temp
                    gesture.scale = 1
                }
            }
        }
    }
    
    @objc func rotateGesFired(_ gesture: UIRotationGestureRecognizer){
        if(funcValue==1 && shapeCanvas.items.count>0){
            let loc = gesture.location(in: drawingArea)
            for (index,item) in shapeCanvas.items.reversed().enumerated(){
                let res = item.contains(point: loc)
                if(res==true){
                    currentIndex = shapeCanvas.items.count-index-1
                }
            }
            
            if(type(of: shapeCanvas.items[currentIndex])==Circle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Circle {
                    let rotate = temp.lastRotation + gesture.rotation
                    temp.lastRotation = rotate*0.5
                    shapeCanvas.items[currentIndex] = temp
                }
            }else if(type(of: shapeCanvas.items[currentIndex])==Triangle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Triangle {
                    let rotate = temp.lastRotation + gesture.rotation
                    temp.lastRotation = rotate*0.5
                    shapeCanvas.items[currentIndex] = temp

                }
            }else if(type(of: shapeCanvas.items[currentIndex])==Rectangle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Rectangle {
                    let rotate = temp.lastRotation + gesture.rotation
                    temp.lastRotation = rotate*0.5
                    shapeCanvas.items[currentIndex] = temp
                }
            }
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
        let touchPoint = touches.first?.location(in: drawingArea) as CGPoint?
        else{ return }
        
        if(funcValue==0){
            shapeCanvas.backgroundColor = UIColor.clear
            if(shapeValue==0){
                if(formatValue==0){
                    currentCircle = Circle(origin: touchPoint, color: currentLb.backgroundColor!)
                }
                else{
                    currentOutlineCircle = OutlineCircle(origin: touchPoint, color: currentLb.backgroundColor!)
                }
                
            }else if(shapeValue==1){
                if(formatValue==0){
                    currentTri = Triangle(origin: touchPoint, color: currentLb.backgroundColor!)
                }
                else{
                    currentOutlineTri = OutlineTriangle(origin: touchPoint, color: currentLb.backgroundColor!)
                }
            }else if(shapeValue==2){
                if(formatValue==0){
                    currentRect = Rectangle(origin: touchPoint, color: currentLb.backgroundColor!)
                }
                else{
                    currentOutlineRect = OutlineRectangle(origin: touchPoint, color: currentLb.backgroundColor!)
                }
            }
        }else if(funcValue==1){
            for (index,item) in shapeCanvas.items.reversed().enumerated(){
                let res = item.contains(point: touchPoint)
                if(res==true){
                    currentIndex = shapeCanvas.items.count-index-1
                }
            }
        }else if(funcValue==2){
            for (index,item) in shapeCanvas.items.reversed().enumerated(){
                let res = item.contains(point: touchPoint)
                if(res==true){
                    shapeCanvas.items.remove(at: shapeCanvas.items.count-index-1)
                    break
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
        let touchPoint = touches.first?.location(in: drawingArea) as CGPoint?
        else{ return }
        if(funcValue==1 && currentIndex != -1){
            if(type(of: shapeCanvas.items[currentIndex])==Circle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Circle{
                    temp.origin = touchPoint
                    shapeCanvas.items[currentIndex] = temp
                }
            }else if(type(of: shapeCanvas.items[currentIndex])==Triangle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Triangle{
                    temp.origin = touchPoint
                    shapeCanvas.items[currentIndex] = temp
                }
            }else if(type(of: shapeCanvas.items[currentIndex])==Rectangle.self){
                if let temp = shapeCanvas.items[currentIndex] as? Rectangle{
                    temp.origin = touchPoint
                    shapeCanvas.items[currentIndex] = temp
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(funcValue==0){
            if(shapeValue==0){
                if(formatValue==0){
                    if let newCircle = currentCircle {
                        shapeCanvas.items.append(newCircle)
                    }
                }
                else{
                    if let newCircle = currentOutlineCircle {
                        shapeCanvas.items.append(newCircle)
                    }
                }

            }else if(shapeValue==1){
                if(formatValue==0){
                    if let newTri = currentTri {
                        shapeCanvas.items.append(newTri)
                    }
                }
                else{
                    if let newTri = currentOutlineTri {
                        shapeCanvas.items.append(newTri)
                    }
                }
            }else if(shapeValue==2){
                if(formatValue==0){
                    if let newRect = currentRect {
                        shapeCanvas.items.append(newRect)
                    }
                }
                else{
                    if let newRect = currentOutlineRect {
                        shapeCanvas.items.append(newRect)
                    }
                }
            }
        }else if(funcValue==1){
            currentIndex = -1
        }
    }


}

