//
//  ViewController.swift
//  diffableDataSourceExample
//
//  Created by Ivan Dario Mosquera Trivino on 5/01/23.
//

import UIKit

class ViewController: UIViewController {
    var data: [ProductModel] = []
    private weak var collectionView: UICollectionView!
    
    private lazy var collectionViewDatSource: UICollectionViewDiffableDataSource<ProductsSection, ProductModel> = {
        let dataSource = UICollectionViewDiffableDataSource<ProductsSection, ProductModel>(collectionView: collectionView) {
            collectionView, indexPath, model -> UICollectionViewCell in
            // Configure and return cell.
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCollectionCell.self), for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell() }
            cell.updateData(model: model)
            return cell
        }
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupData()
        setupUI()
    }

    func setupUI() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteProduct))
        navigationItem.rightBarButtonItems = [add, delete]
        setupCollectionView()
        configInitialSnapshot()
    }
    
    func setupData() {
        let product1 = ProductModel(id: 0, name: "Product 1", price: "1000", status: "Sold")
        data = [product1]
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 100.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCollectionCell.self, forCellWithReuseIdentifier: String(describing: ProductCollectionCell.self))
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        collectionView.delegate = self
        self.collectionView = collectionView
    }
    
    func configInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ProductsSection, ProductModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        collectionViewDatSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc
    func addProduct() {
        var oldSnapshot = collectionViewDatSource.snapshot()
        let newProductId = (oldSnapshot.itemIdentifiers.last?.id ?? 0) + 1
        var newProduct = ProductModel(id: newProductId, name: "New Product \(newProductId)", price: "9999", status: "Available")
        oldSnapshot.appendItems([newProduct], toSection: .main)
        collectionViewDatSource.apply(oldSnapshot, animatingDifferences: true)
    }
    
    @objc
    func deleteProduct() {
        var oldSnapshot = collectionViewDatSource.snapshot()
        guard let removeItem = oldSnapshot.itemIdentifiers.last else { return }
        oldSnapshot.deleteItems([removeItem])
        collectionViewDatSource.apply(oldSnapshot, animatingDifferences: true)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        var oldSnapshot = collectionViewDatSource.snapshot()
        guard let productToUpdate = collectionViewDatSource.itemIdentifier(for: indexPath) else { return }
        productToUpdate.name = productToUpdate.name.appending("*")
        oldSnapshot.reconfigureItems([productToUpdate])
        collectionViewDatSource.apply(oldSnapshot, animatingDifferences: true)
    }
}

