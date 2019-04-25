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
    var month = calendar.component(.month, from: date) - 1
    var year = calendar.component(.year, from: date)
    var currentMonth = String()
    var startingDayOfWeek = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        GetStartDateDayPosition()
    }
    
    func GetStartDateDayPosition() {
        startingDayOfWeek = getDayOfWeek(year: year, month: month)
    }

    @IBAction func Next(_ sender: Any) {
        updateSelectedDate(monthCheck: "December", monthReset: 0, updateValue: 1)
    }
    
    @IBAction func Back(_ sender: Any) {
        updateSelectedDate(monthCheck: "January", monthReset: 11, updateValue: -1)
    }
    
    func updateSelectedDate(monthCheck: String, monthReset: Int, updateValue: Int){
        if currentMonth == monthCheck{
            month = monthReset
            year += updateValue
            checkAndUpdateLeapYear()
        }else{
            month += updateValue
        }
        
        getStartDateAndUpdateMonth()
    }
    
    func getStartDateAndUpdateMonth(){
        GetStartDateDayPosition()
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
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
    

    // Return the number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return startingDayOfWeek + DaysInMonths[month]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCell
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = UIColor.black
        cell.Circle.isHidden = true
        
        cell.isHidden = indexPath.row < startingDayOfWeek
        
        let day_number = indexPath.row + 1 - startingDayOfWeek
        cell.DateLabel.text = "\(day_number)"

        if month == todaysMonth && year == todaysYear && day == day_number{
            cell.Circle.isHidden = false
            cell.DrawCircle()
        }
        return cell
    }
}

