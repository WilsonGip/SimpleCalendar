import UIKit


let calendar = Calendar.current
let date = Date()

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    let day = calendar.component(.day , from: date)
    let todaysMonth = calendar.component(.month, from: date) - 1
    let todaysYear = calendar.component(.year, from: date)
    
    let Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]

    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    var current_month = calendar.component(.month, from: date) - 1
    var year = calendar.component(.year, from: date)
    var startingDayOfWeek = 0
    var cellsArray: [UICollectionViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MonthLabel.text = "\(Months[current_month]) \(year)"
        getStartDateDayPosition()
    }
    
    func getStartDateDayPosition() {
        startingDayOfWeek = getDayOfWeek(year: year, month: current_month)
    }

    @IBAction func _Next(_ sender: Any) {
        updateSelectedDate(monthCheck: "December", monthReset: 0, updateValue: 1)
        animateLabelMoveHorizontal(Label: MonthLabel, directionValue: 70)
    }
    
    @IBAction func _Back(_ sender: Any) {
        updateSelectedDate(monthCheck: "January", monthReset: 11, updateValue: -1)
        animateLabelMoveHorizontal(Label: MonthLabel, directionValue: -70)
    }
    
    func updateSelectedDate(monthCheck: String, monthReset: Int, updateValue: Int){
        if Months[current_month] == monthCheck{
            current_month = monthReset
            year += updateValue
            checkAndUpdateLeapYear()
        }else{
            current_month += updateValue
        }
        
        getStartDateAndUpdateMonth()
    }
    
    func getStartDateAndUpdateMonth(){
        getStartDateDayPosition()
        MonthLabel.text = "\(Months[current_month]) \(year)"
        cellsArray.removeAll()
        Calendar.reloadData()
    }
   
    func checkAndUpdateLeapYear(){
        DaysInMonths[1] = year % 4 == 0 && year % 100 != 0 || year % 400 == 0 ? 29 : 28
    }
    
    func getDayOfWeek(year: Int, month: Int) -> Int{
        let t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
        let y = month < 2 ? year - 1 : year
        return (y + Int(y/4) - Int(y/100) + Int(y/400) + t[month] + 1) % 7
    }
    

    func animateLabelMoveHorizontal(Label : UILabel, directionValue: CGFloat){
        let xCenter = Label.center.x
        let yCenter = Label.center.y
        let animatePos = CABasicAnimation(keyPath: "position")
        animatePos.fromValue = NSValue(cgPoint: CGPoint(x: xCenter + directionValue, y: yCenter))
        animatePos.toValue = NSValue(cgPoint: CGPoint(x: xCenter, y: yCenter))
        animatePos.duration = 0.3
        
        let animateFade = CABasicAnimation(keyPath: "opacity")
        animateFade.fromValue = 0
        animateFade.toValue = 1
        animateFade.duration = 0.3
        
        Label.layer.add(animatePos, forKey: nil)
        Label.layer.add(animateFade, forKey: nil)
    }
    
    // Return the number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return startingDayOfWeek + DaysInMonths[current_month]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCell
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = UIColor.black
        cell.Circle.isHidden = true
        
        cell.isHidden = indexPath.row < startingDayOfWeek
        
        let day_number = indexPath.row + 1 - startingDayOfWeek
        cell.DateLabel.text = "\(day_number)"

        if current_month == todaysMonth && year == todaysYear && day == day_number{
            cell.Circle.isHidden = false
            cell.DrawCircle()
        }
        cellsArray.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        for x in cellsArray{
            let currentCell: UICollectionViewCell = x
            UIView.animate(withDuration: 1, delay: 0.01 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                currentCell.alpha = 1
                currentCell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        }
    }
}

