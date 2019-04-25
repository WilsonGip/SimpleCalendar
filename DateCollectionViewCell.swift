

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var Circle: UIView!
    
    
    func DrawCircle() {
        
        let circleCenter = Circle.center
        
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: (Circle.bounds.width/2 - 5), startAngle: -CGFloat.pi/2, endAngle: (2 * CGFloat.pi), clockwise: true)
        
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
