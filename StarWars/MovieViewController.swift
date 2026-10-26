//
//  MovieViewController.swift
//  StarWars
//
//  Created by student on 22/10/2026.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movie: Movie?
    
    private weak var posterImageView: UIImageView?
    private weak var directorLabel: UILabel?
    private weak var runtimeLabel: UILabel?
    private weak var yearLabel: UILabel?
    private weak var castTableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        configureUI()
    }
    
    private func bindViews() {
        posterImageView = view.findSubview(ofType: UIImageView.self)
        
        let labels = view.findSubviews(ofType: UILabel.self)
        directorLabel = labels.first(where: { $0.text == "Director" })
        runtimeLabel = labels.first(where: { $0.text == "Rutnime" || $0.text == "Runtime" })
        yearLabel = labels.first(where: { $0.text == "Year" })
        
        castTableView = view.findSubview(ofType: UITableView.self)
        castTableView?.dataSource = self
        castTableView?.delegate = self
    }
    
    private func configureUI() {
        guard let movie else { return }
        
        title = movie.title
        posterImageView?.image = UIImage(named: movie.posterName)
        directorLabel?.text = movie.director
        runtimeLabel?.text = movie.runtime
        yearLabel?.text = String(movie.year)
        
        posterImageView?.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        posterImageView?.addGestureRecognizer(tapRecognizer)
        castTableView?.reloadData()
    }
    
    @objc private func imageTapped() {
        performSegue(withIdentifier: "Mw7-kI-fmr", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie?.cast.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "CastCell")
        
        guard let member = movie?.cast[indexPath.row] else {
            return cell
        }
        
        let labels = cell.contentView.subviews.compactMap { $0 as? UILabel }.sorted { $0.frame.minX < $1.frame.minX }
        if labels.count >= 2 {
            labels[0].text = member.name
            labels[1].text = member.character
        } else {
            cell.textLabel?.text = member.name
            cell.detailTextLabel?.text = member.character
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Mw7-kI-fmr",
              let movie else {
            return
        }
        
        let destination = segue.destination
        destination.loadViewIfNeeded()
        destination.title = movie.title
        
        if let imageView = destination.view.findSubview(ofType: UIImageView.self) {
            imageView.image = UIImage(named: movie.posterName)
            imageView.contentMode = .scaleAspectFit
        }
    }

}

private extension UIView {
    func findSubview<T: UIView>(ofType type: T.Type) -> T? {
        if let match = self as? T {
            return match
        }
        for child in subviews {
            if let match: T = child.findSubview(ofType: type) {
                return match
            }
        }
        return nil
    }
    
    func findSubviews<T: UIView>(ofType type: T.Type) -> [T] {
        var matches: [T] = []
        if let match = self as? T {
            matches.append(match)
        }
        for child in subviews {
            matches.append(contentsOf: child.findSubviews(ofType: type))
        }
        return matches
    }
}
