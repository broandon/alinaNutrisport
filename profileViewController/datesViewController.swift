//
//  datesViewController.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 07/07/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import FSCalendar
import TableViewReloadAnimation

class datesViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Outlets
    
    @IBOutlet weak var logoBackround: UIView?
    @IBOutlet weak var logoImage: UIImageView?
    @IBOutlet weak var containerView1Dates: UIView?
    @IBOutlet weak var containerView2Calendar: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var newAppointment: UIButton?
    @IBOutlet weak var calendario: FSCalendar?
    @IBOutlet weak var textInputHour: UITextField?
    @IBOutlet weak var segmentedController: UISegmentedControl?
    
    var appointments: [Dictionary<String, Any>] = []
    let reuseDocument = "DocumentCell3"
    var laMiaHora: String = ""
    var laMiaFecha: String = ""
    let UserID = UserDefaults.standard.string(forKey: "IDUser")
    
    private let pickerDataSourceLunVier : [(name: String, number: String)] = [("8:00 AM", "8:00"), ("8:15 AM", "8:15"), ("8:30 AM", "8:30"), ("8:45 AM", "8:45"), ("9:00 AM", "9:00"), ("9:15 AM", "9:15"), ("9:30 AM", "9:30"), ("9:45 AM", "9:45"), ("10:00 AM", "10:00"), ("10:15 AM", "10:15"), ("10:30 AM", "10:30"), ("10:45 AM", "10:45"), ("11:00 AM", "11:00"), ("11:15 AM", "11:15"), ("11:30 AM", "11:30"), ("11:45 AM", "11:45"), ("12:00 PM", "12:00"), ("12:15 PM", "12:15"), ("12:30 PM", "12:30"), ("12:45 PM", "12:45"), ("1:00 PM", "13:00"), ("1:15 PM", "13:15"), ("1:30 PM", "13:30"), ("1:45 PM", "13:45"), ("4:00 PM", "16:00"), ("4:15 PM", "16:15"), ("4:30 PM", "16:30"), ("4:45 PM", "16:45"), ("5:00 PM", "17:00"), ("5:15 PM", "17:15"), ("5:30 PM", "17:30"), ("5:45 PM", "17:45"), ("6:00 PM", "18:00"), ("6:15 PM", "18:15"), ("6:30 PM", "18:30"), ("6:45 PM", "18:45")]
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        downloadJson()
        setupTableView()
        setupCalendarAndPicker()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshInfo), name: Notification.Name("newDateAdded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeSegment), name: Notification.Name("ChangeValue"), object: nil)
    }
    
    //MARK: Funcs
    
    func setupTableView() {
        let documentXib = UINib(nibName: "datesTableViewCell", bundle: nil)
        tableView?.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.allowsSelection = false
    }
    
    func setupCalendarAndPicker() {
        calendario?.locale = Locale.init(identifier: "es-MX")
        calendario?.delegate = self
        calendario?.dataSource = self
        textInputHour?.delegate = self
        let thePicker = UIPickerView()
        textInputHour?.inputView = thePicker
        thePicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSourceLunVier.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSourceLunVier[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textInputHour?.text = pickerDataSourceLunVier[row].name
        let hora = pickerDataSourceLunVier[row].number
        self.laMiaHora = hora
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return self.gregorian.isDateInToday(date) ? "HOY" : nil
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2030/10/30")!
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return CheckSatSunday(today: date)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFinal2 = self.formatter.string(from: date)
        self.laMiaFecha = dateFinal2
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func CheckSatSunday(today:Date) ->Bool{
        var DayExist:Bool
        let calendar = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
        let components = calendar!.components([.weekday], from: today)
        
        if components.weekday == 1 {
            print("Hello Sunday")
            DayExist = true
            textInputHour?.text = "Sin horarios disponibles."
            textInputHour?.isUserInteractionEnabled = false
        } else if components.weekday == 7 {
            print("Hello Saturday")
            DayExist = true
            textInputHour?.text = "Seleccionar horario..."
            textInputHour?.isUserInteractionEnabled = true
        } else {
            DayExist = true
            print("It's not Saturday or Sunday")
            textInputHour?.text = "Seleccionar horario..."
            textInputHour?.isUserInteractionEnabled = true
        }
        print("weekday :\(String(components.weekday!)) ")
        return DayExist
    }
    
    func setupView() {
        logoBackround?.layer.backgroundColor = UIColor.white.cgColor
        logoBackround?.layer.borderColor = UIColor.lightGray.cgColor
        logoBackround?.layer.borderWidth = 0.0
        logoBackround?.layer.cornerRadius = 84.5
        logoBackround?.layer.masksToBounds = false
        logoBackround?.layer.shadowRadius = 3.5
        logoBackround?.layer.shadowColor = UIColor.gray.cgColor
        logoBackround?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        logoBackround?.layer.shadowOpacity = 1.0
        logoImage?.layer.backgroundColor = UIColor.white.cgColor
        logoImage?.layer.borderColor = UIColor.lightGray.cgColor
        logoImage?.layer.borderWidth = 0.0
        logoImage?.layer.cornerRadius = 84.5
        logoImage?.layer.masksToBounds = true
        newAppointment?.layer.cornerRadius = 15
        containerView1Dates?.alpha = 0
        containerView2Calendar?.alpha = 1
    }
    
    func downloadJson() {
        appointments.removeAll()
        let url = URL(string: "http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let postString = "funcion=getAppointments&id_user=\(UserID!)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil, response != nil else {
                return
            }
            
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                if let dictionary = json as? Dictionary<String, Any> {
                    for d in dictionary["data"] as! [Dictionary<String, Any>] {
                        self.appointments.append(d)
                    }
                }
                DispatchQueue.main.async {
                    
                    if self.appointments.count > 0 {
                        self.tableView?.reloadData(with: .simple(duration: 0.45, direction: .top(useCellsFrame: true), constantDelay: 0))
                    }
                }
            }
        }.resume()
    }
    
    @objc func refreshInfo() {
        appointments.removeAll()
        DispatchQueue.main.async {
            self.tableView?.reloadData()
            print("Refreshed 1")
        }
        downloadJson()
        DispatchQueue.main.async {
            self.tableView?.reloadData()
            print("Refreshed 2")
        }
    }
    
    @objc func changeSegment() {
        segmentedController?.selectedSegmentIndex = 0
        containerView1Dates?.alpha = 0
        containerView2Calendar?.alpha = 1
    }
    
    //MARK: Buttons
    
    @IBAction func changedSection(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            containerView1Dates?.alpha = 0
            containerView2Calendar?.alpha = 1
        }
        
        if sender.selectedSegmentIndex == 1 {
            containerView1Dates?.alpha = 1
            containerView2Calendar?.alpha = 0
        }
    }
    
    @IBAction func getOut(_ sender: Any) {
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.hero.modalAnimationType = .pageOut(direction: .right)
        self.hero.replaceViewController(with: newViewController)
    }
    
    @IBAction func saveNewAppointment(_ sender: Any) {
        textInputHour?.resignFirstResponder()
        appointments.removeAll()
        
        if laMiaFecha.isEmpty == true {
            displayMessage(userMessage: "Debes elegir una fecha.")
            return
        }
        
        if laMiaHora.isEmpty == true {
            displayMessage(userMessage: "Debes elegir una hora.")
            return
        }
        let url = URL(string:"http://alinanutrisport.com.mx/sistema/webservice/controller_last.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Headers
        request.httpMethod = "POST" // Metodo
        let String1 = "funcion=NewAppointment&id_user=\(UserID!)"
        let String2 = "&date=\(laMiaFecha)"+" "+"\(laMiaHora)"
        let postString = "\(String1)\(String2)"
        request.httpBody = postString.data(using: .utf8) // SE codifica a UTF-8
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            
            if let dictionary = json {
                
                if let state = dictionary["state"] {
                    let status = "\(state)"
                    
                    if status == "200" {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "newDateAdded"), object: nil)
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "¡Éxito!", message: "Tu cita ha sido guardada.", preferredStyle:UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                            { action -> Void in
                                
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "ChangeValue"), object: nil)
                                
                            })
                            self.present(alertController, animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "¡Oh, no!", message: "Hubo un error al guardar tu cita. Por favor intenta de nuevo mas tarde.", preferredStyle:UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                            { action -> Void in
                            })
                            self.present(alertController, animated: true)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

extension datesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alerta", message: userMessage, preferredStyle: .alert)
            let OkAction = UIAlertAction (title: "OK", style: .default)
            { (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true,
                         completion:nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appointments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let document = appointments[indexPath.row]
        let fecha  = document["fecha"] as? String ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath)
        
        if let cell = cell as? datesTableViewCell {
            DispatchQueue.main.async {
                cell.fecha.text = fecha
                cell.tipoTratamiento.text = "Tratamiento"
                cell.tratamiento.text = "Agendada"
            }
            return cell
        }
        return UITableViewCell()
    }
}
