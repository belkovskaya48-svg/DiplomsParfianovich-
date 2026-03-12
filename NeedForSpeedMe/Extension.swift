import UIKit
extension UIView {
    
    func roundCorners (radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func dropShadow(radius: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        
        layer.shadowPath = UIBezierPath(ovalIn: bounds).cgPath
        layer.shouldRasterize = true
    }
    func addGradient () {
        let gradient = CAGradientLayer()
        
        gradient.colors = [
            UIColor.systemPink.cgColor,
            UIColor.white.cgColor,
            UIColor.blue.cgColor
        ]
        gradient.opacity = 0.8
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = self.bounds
        gradient.cornerRadius = 10
        self.layer.insertSublayer(gradient, at: 0)
    }
}
