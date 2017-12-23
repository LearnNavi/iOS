//
//  DictionaryTableViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/29/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class DictionaryTableViewController: UITableViewController, UISearchResultsUpdating, UINavigationControllerDelegate {

    // MARK: Properties
    var dictionary : Dictionary!
    //var entries = [Entry]()
    var sections = [Section]()
    var filteredEntries = [Entry]()
    var filteredSections = [Section]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "Background-Resources")
        let imageView = UIImageView(image: backgroundImage)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        //blurView.alpha = 0.8
        blurView.frame = imageView.bounds
        
        //blurView.translatesAutoresizingMaskIntoConstraints = false
        //blurView.topAnchor.constraint(equalToConstant: 0).isActive = true
        //blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        //blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.autoresizesSubviews = true
        blurView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        imageView.addSubview(blurView)
        imageView.alpha = 0.6
        self.tableView.backgroundView = imageView
        self.tableView.backgroundColor = UIColor.black
        
        self.tableView.sectionIndexColor = UIColor.orange //UIColor(red: 120/255, green: 0.0, blue: 240/255, alpha: 1)
        //self.tableView.sectionIndexTrackingBackgroundColor
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dictionary = Dictionary.openDictionary()
        
        //loadEntries()
        loadSections()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Dictionary"
        searchController.searchBar.keyboardAppearance = UIKeyboardAppearance.dark
        
        definesPresentationContext = true
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
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
        if isFiltering() {
            return filteredSections.count
        } else {
            return sections.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return filteredSections[section].entries.count
        } else {
            return sections[section].entries.count
        }
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

        let entry: Entry
        
        if isFiltering() {
            entry = filteredSections[indexPath.section].entries[indexPath.row]
        } else {
            entry = sections[indexPath.section].entries[indexPath.row]
        }
        
        cell.lemmaLabel.text = "\(entry.navi):"
        cell.ipaLabel.text = "[ \(entry.ipa.utf8) ]"
        //let partOfSpeech = entry.partOfSpeech.replacingOccurrences(of: "^", with: "")
        //cell.posLabel.text = partOfSpeech
        cell.posLabel.text = entry.fancyPartOfSpeech
        cell.definitionLabel.text = entry.definition
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering() {
            return filteredSections[section].alpha
        } else {
            return sections[section].alpha
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isFiltering() {
            return filteredSections.map { section in
                return section.alpha
            }
        } else {
            return sections.map { section in
                return section.alpha
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.green
        header.textLabel?.font = UIFont.init(name: "Papyrus", size: 18.5)
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let searchTerms = searchText.components(separatedBy: " ")
        var localFilteredSections = sections
        for term in searchTerms {
            if(term == "") {
                continue
            }
            localFilteredSections = filterSections(sections: localFilteredSections, searchTerm: term)
        }
        
        filteredSections = localFilteredSections
        
        tableView.reloadData()
    }
    
    private func filterSections(sections: [Section], searchTerm: String) -> [Section] {
        // Create a new list of sections, filtering each section's list of entries by search term
        let sections = sections.map({( section: Section) -> Section in
            let entries = section.entries.filter({( entry : Entry) -> Bool in
                let term = searchTerm.lowercased()
                return entry.navi.lowercased().contains(term) ||
                        entry.definition.lowercased().contains(term) ||
                        entry.fancyPartOfSpeech.lowercased().contains(term) ||
                        entry.ipa.lowercased().contains(term) ||
                        entry.partOfSpeech.replacingOccurrences(of: "^", with: "").contains(term)
                
            })
            return Section(alpha: section.alpha, entries: entries)
        })
        
        // Strip out any sections that have 0 entries in them
        return sections.filter({( section : Section) -> Bool in
            return section.entries.count > 0
            //return candy.name.lowercased().contains(searchText.lowercased())
        })
    }
    
    /*private func loadEntries() {
        entries = dictionary.getEntries()
    }*/
    
    private func loadSections() {
        sections = dictionary.getSections()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDictionaryEntry" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let entry: Entry
                if isFiltering() {
                    entry = filteredSections[indexPath.section].entries[indexPath.row]
                } else {
                    entry = sections[indexPath.section].entries[indexPath.row]
                }
                let controller = segue.destination as! DictionaryViewController
                controller.entry = entry
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                //controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}
