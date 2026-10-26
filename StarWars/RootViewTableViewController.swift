//
//  RootViewTableViewController.swift
//  StarWars
//
//  Created by student on 22/10/2026.
//

import UIKit

class RootViewTableViewController: UITableViewController {

    var movieCategories: [MovieCategory] = []
    private var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let bundleURL = Bundle.main.url(forResource: "movies", withExtension: "plist")
                ?? Bundle.main.url(forResource: "movies", withExtension: "plist", subdirectory: "Resource"),
              let plist = NSDictionary(contentsOf: bundleURL) as? [String: Any] else {
            return
        }
        
        var parsedCategories: [MovieCategory] = []
        for key in plist.keys.sorted() {
            guard let category = plist[key] as? [String: Any] else {
                continue
            }
            
            var movies: [Movie] = []
            for movieTitle in category.keys {
                guard let movieDictionary = category[movieTitle] as? [String: Any] else {
                    continue
                }
                movies.append(Movie(title: movieTitle, dictionary: movieDictionary))
            }
            
            let orderedMovies = movies.sorted {
                if $0.year == $1.year {
                    return $0.title < $1.title
                }
                return $0.year < $1.year
            }
            parsedCategories.append(MovieCategory(name: key, movies: orderedMovies))
        }
        
        movieCategories = parsedCategories.sorted {
            ($0.movies.first?.year ?? Int.max) < ($1.movies.first?.year ?? Int.max)
        }
        
        self.title = "Star Wars movies"
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return movieCategories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCategories[section].movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieCategories[indexPath.section].movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "MovieCell")
        
        cell.textLabel?.text = movie.title
        cell.textLabel?.numberOfLines = 1
        
        let thumbnailView = UIImageView(image: UIImage(named: movie.thumbnailName))
        thumbnailView.contentMode = .scaleAspectFit
        thumbnailView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        cell.accessoryView = thumbnailView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieCategories[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movieCategories[indexPath.section].movies[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Ehr-E0-1di",
              let destination = segue.destination as? MovieViewController else {
            return
        }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.movie = movieCategories[indexPath.section].movies[indexPath.row]
        } else {
            destination.movie = selectedMovie
        }
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

    // In a storyboard-based application, you will often want to do something in the destination view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
