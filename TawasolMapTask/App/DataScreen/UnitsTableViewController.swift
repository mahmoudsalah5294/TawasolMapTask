//
//  UnitsTableViewController.swift
//  TawasolMapTask
//
//  Created by Mahmoud Mohamed on 15/11/2021.
//

import UIKit

protocol UnitsTableViewProtocol:AnyObject{
    func updateAddress(address:[String])
    func updateUnits(units:[Item])
    func updateSensorsState(sensors:SensorsValuesModel)
}

class UnitsTableViewController: UITableViewController,UnitsTableViewProtocol {
    
    var token = ""
    private var timer : DispatchSourceTimer!
    private var myUnits:[Item]?
    private var myAddress:[String] = []
    private var mySensors:[SensorsValuesModel] = []
    private var presenter:UnitsPresenter?
    
    func updateUnits(units: [Item]) {
        myUnits?.removeAll()
        myUnits = units
        self.tableView.reloadData()
    }
    
    
    func updateAddress(address: [String]) {
        myAddress.append(contentsOf: address) 
        self.tableView.reloadData()
    }
    
    func updateSensorsState(sensors: SensorsValuesModel) {
        mySensors.append(sensors)
        self.tableView.reloadData()
    }
    

    var units:[MyUnit]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        let datasource = APIDataSource()
        presenter = UnitsPresenter(datasource: datasource, view: self)
        startTimer()
        }
        
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myUnits?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCustomTableViewCell

        
        if let myUnits = myUnits,!myUnits.isEmpty{
            let myUnit = myUnits[indexPath.row]
            cell.uName.text = myUnit.nm
            cell.uSpeed.text = String(myUnit.pos.s)
            
            for (key,value) in myUnit.sens{
                switch(key){
                case "1":
                    cell.uEngine.text = value.n
                case "2":
                    cell.uSensors1.text = value.n
                case "3":
                    cell.uSensors2.text = value.n
                default:
                    print("")
            }
        }
        }
        
        if !myAddress.isEmpty {
            if myAddress.count-1 >= indexPath.row{
            cell.uAddress.text = myAddress[indexPath.row]
            }
        }
        
        if !mySensors.isEmpty{
            if mySensors.count-1 >= indexPath.row{
            let mySen = mySensors[indexPath.row]
            for (key,value) in mySen{
                var type = ""
                if value > 0{
                    type = "ON"
                }else{
                    type = "OFF"
                }
                switch(key){
                case "1":
                    cell.engineType.text = type
                case "2":
                    cell.uSensors1Type.text = type
                case "3":
                    cell.sensor2Type.text = type
                default:
                    print("")
            }
            }
        }
        }
        return cell
    
    
        }
    
    
    func startTimer()
    {
        print("Timer started")
        if timer == nil {
            timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: .now(), repeating: 5)
            timer.setEventHandler {
                self.callAPI()
            }
            timer.activate()
        } else {
            timer.schedule(deadline: .now(), repeating: 5)
        }
    }
            
       func callAPI(){
           myAddress.removeAll()
           mySensors.removeAll()
                print("execute")
                presenter?.fetchData(token: token)
                print(token)
            }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
