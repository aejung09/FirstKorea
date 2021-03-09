//
//  TableViewController.swift
//  TableControl
//
//  Created by 고종찬 on 2021/02/09.
//

import UIKit

// 변수 선언을 class 정의 전에 해야한다
var items = ["책 구매","철수와 약속","스터디 준비하기"]
var itemsImageFile = ["cart.png","clock.png","pencil.png"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Edit 버튼을 만들고 삭제 기능 추가하기, 왼쪽으로 배치
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    // 보통은 테이블안에 섹션이 1개
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 섹션당 열의 갯수는 item의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    //테이블 셀에 내용을 담아 버리기 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        return cell
    }
    
    // Table View에 추가된 내용 불러 들이기 생애 주기
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }
    
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    // 삭제 가능하게 하기
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
  
    // Delete를 삭제로 보이기
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

  
    // Override to support rearranging the table view.
    // 순서 바꾸게 하기
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //이동할 item의 위치
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        //이동할 image의 위치
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        //이동할 item을 삭제
        items.remove(at: (fromIndexPath as NSIndexPath).row)
        //이동할 image를 삭제
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        // items 삽입
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
        
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    // 버튼 을 클릭하면 segue로 연결한것을 전송 수신 하기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
//            detailView.receiveItem = items[(indexPath! as NSIndexPath).row]
            detailView.receiveItems(items[(indexPath! as NSIndexPath).row], imagePath: itemsImageFile[(indexPath! as NSIndexPath).row] )
        }
            
            
        
    }
   

}
