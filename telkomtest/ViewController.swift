//
//  ViewController.swift
//  telkomtest
//
//  Created by Muhammad Firman Nur on 05/10/22.
//

import UIKit
import Alamofire
import AlamofireMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchData()
    }
    
    private func fetchData() {
        let url = "https://apimocha.com/telkom/v2/products"
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { [weak self] (response: DataResponse<ProductResponse>) in
            if let data = response.result.value {
                self?.products = data.data ?? []
            } else {
                print("error")
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCollectionViewCell", for: indexPath) as! DataCollectionViewCell
        cell.productLabel.text = products[indexPath.row].productName
        cell.productImage.downloaded(from: products[indexPath.row].productLogo)
        cell.backgroundColor = UIColor(hexString: products[indexPath.row].colorTheme)
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 8, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 4, bottom: 0, right: 4)
    }
}
