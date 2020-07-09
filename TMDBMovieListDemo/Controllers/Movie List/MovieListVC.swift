//
//  MovieListVC.swift
//  TMDBMovieListDemo
//
//  Created by Aarsh Parekh on 09/07/20.
//  Copyright © 2020 Aarsh. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {

    
    lazy var moviewListTableView: UITableView = {
        let tblView = UITableView(frame: CGRect.zero, style: .plain)
        tblView.register(UINib(nibName: MovieListCell.identifier, bundle: nil), forCellReuseIdentifier: MovieListCell.identifier)
        tblView.backgroundColor = .black
        tblView.separatorStyle = .none
        tblView.translatesAutoresizingMaskIntoConstraints = false
        return tblView
    }()
    
    var viewModel: MovieListViewModel!
    private let controllerTitle = "Movies"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func refreshTableView() {
        moviewListTableView.reloadData()
    }
}

private extension MovieListVC {
    func setupUI() {
        title = controllerTitle
        viewModel = MovieListViewModel(withParentReference: self)
        setupTableView()
        fetchMoviewData()
    }
    
    func setupTableView() {
        let safeLayout = view.safeAreaLayoutGuide
        self.view.addSubview(moviewListTableView)
        NSLayoutConstraint.activate([
            moviewListTableView.topAnchor.constraint(equalTo: safeLayout.topAnchor, constant: 0),
            moviewListTableView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor, constant: 0),
            moviewListTableView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor, constant: 0),
            moviewListTableView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor, constant: 0)
        ])
        moviewListTableView.delegate = self
        moviewListTableView.dataSource = self
    }
    
    func fetchMoviewData() {
        guard viewModel.currentPage < viewModel.totalPageCount else { return }
        viewModel.getMovieList(withPageNumber: String(viewModel.currentPage + 1))
    }
    
    func makeMoviewListCell(withIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let movieListCell = moviewListTableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        movieListCell.movieData = viewModel.movieListArray[indexPath.row]
        return movieListCell
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return makeMoviewListCell(withIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 263
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MovieListVC: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            self.fetchMoviewData()
        }
    }
}
