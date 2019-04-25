

import UIKit

class DateCell: UICollectionViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var Circle: UIView!
    
    
    func DrawCircle() {
        let bWidth = Circle.bounds.width
        let circlePath = UIBezierPath(arcCenter: Circle.center, radius: (bWidth/2 - bWidth/7), startAngle: CGFloat(0), endAngle: CGFloat(CGFloat.pi * 2), clockwise: true)
        
        let CircleLayer = CAShapeLayer()
        CircleLayer.path = circlePath.cgPath
        CircleLayer.strokeColor = #colorLiteral(red: 0.05882352941, green: 0.843, blue: 1, alpha: 1)
        CircleLayer.lineWidth = 2
        CircleLayer.strokeEnd = 1
        CircleLayer.fillColor = UIColor.clear.cgColor
        CircleLayer.lineCap = CAShapeLayerLineCap.round
        
        Circle.layer.addSublayer(CircleLayer)
        Circle.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
}
