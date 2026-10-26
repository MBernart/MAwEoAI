//
//  RootViewTableViewController.swift
//  StarWars
//
//  Created by student on 22/10/2026.
//

import UIKit

class RootViewTableViewController: UITableViewController {

    var dictionary: [String: Any] = [:]
    var movieCategories: [MovieCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        guard let bundleURL = Bundle.main.url(forResource: "movies", withExtension: "plist"),
              let plist = NSDictionary(contentsOf: bundleURL) as? [String: Any] else {
            return
        }

        dictionary = plist
        for key in dictionary.keys.sorted() {
            guard let category = dictionary[key] as? [String: Any] else {
                continue
            }

            var categoryMovies: [Movie] = []
            for movieTitle in category.keys.sorted() {
                guard let movieDictionary = category[movieTitle] as? [String: Any] else {
                    continue
                }
                categoryMovies.append(Movie(title: movieTitle, dictionary: movieDictionary))
            }
            movieCategories.append(MovieCategory(name: key, movies: categoryMovies))
        }
        self.title = "Star Wars movies"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return movieCategories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCategories[section].movies.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    // In a storyboard-based application, you will often want to do something in the destination view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
