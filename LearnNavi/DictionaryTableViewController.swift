//
//  DictionaryTableViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/29/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class DictionaryTableViewController: UITableViewController {

    // MARK: Properties
    var dictionary : Dictionary!
    var entries = [Entry]()
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "Background-Resources")
        let imageView = UIImageView(image: backgroundImage)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        //blurView.alpha = 0.8
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        imageView.alpha = 0.6
        self.tableView.backgroundView = imageView
        self.tableView.backgroundColor = UIColor.black
        
        self.tableView.sectionIndexColor = UIColor.orange //UIColor(red: 120/255, green: 0.0, blue: 240/255, alpha: 1)
        //self.tableView.sectionIndexTrackingBackgroundColor
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dictionary = Dictionary.openDictionary()
        
        loadEntries()
        loadSections()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].entries.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EntryTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EntryTableViewCell else {
            fatalError("The dequeued cell is not an instance of EntryTableViewCell")
        }
        
        cell.backgroundColor = .clear

        let entry = sections[indexPath.section].entries[indexPath.row]
        
        cell.lemmaLabel.text = "\(entry.navi):"
        cell.ipaLabel.text = "[ \(entry.ipa.utf8) ]"
        //let partOfSpeech = entry.partOfSpeech.replacingOccurrences(of: "^", with: "")
        //cell.posLabel.text = partOfSpeech
        cell.posLabel.text = entry.fancyPartOfSpeech
        cell.definitionLabel.text = entry.definition
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].alpha
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map { section in
            return section.alpha
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.green
        header.textLabel?.font = UIFont.init(name: "Papyrus", size: 18.5)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    private func loadEntries() {
        entries = dictionary.getEntries()
    }
    
    private func loadSections() {
        sections = dictionary.getSections()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDictionaryEntry" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let entry = sections[indexPath.section].entries[indexPath.row]
                let controller = segue.destination as! DictionaryViewController
                controller.entry = entry
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                //controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}
