//
//  ViewController.swift
//  Homework-5
//
//  Created by Vsevolod Pavlovskyi on 28.01.2021.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Variables

    let data = [
        SnowViewController(),
        ConfettiViewController(),
        FireworksViewController(),
        ProgressViewController()
    ]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = view.frame.size
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = data.count

        if #available(iOS 13.0, *) {
            pageControl.pageIndicatorTintColor = UIColor.label.withAlphaComponent(0.2)
            pageControl.currentPageIndicatorTintColor = .label
        } else {
            pageControl.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
            pageControl.currentPageIndicatorTintColor = .black
        }

        pageControl.addTarget(nil, action: #selector(changePage), for: .valueChanged)

        pageControl.translatesAutoresizingMaskIntoConstraints = false

        return pageControl
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Setups

    private func setup() {

        if #available(iOS 13, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        view.addSubview(collectionView)
        view.addSubview(pageControl)
        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

extension ViewController {

    // MARK: - Actions

    @objc func changePage() {
        let indexPath = IndexPath(row: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {

    // MARK: - Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        let cellViewController = data[indexPath.row]

        addChild(cellViewController)

        cellViewController.view.frame = cell.bounds
        cell.addSubview(cellViewController.view)

        cellViewController.didMove(toParent: self)

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath) {

        cell.setNeedsLayout()
        cell.layoutIfNeeded()
    }
}

extension ViewController: UICollectionViewDelegate {

    // MARK: - Scroll View Delegate

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
