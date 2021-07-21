//
//  ViewController.swift
//  lexer_imgur
//
//  Created by Alexey Il on 21.07.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgurs = [Imgur]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkService.shared.getImgurs { (response) in
            self.imgurs = response.imgurs
            self.collectionView.reloadData()
        }
        
        // Collection Cell two columns
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            let size = CGSize(width:(collectionView!.bounds.width-80)/2, height: 230)
            layout.itemSize = size
        }
        
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgurs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgurCell", for: indexPath) as? ImgurCell else { return UICollectionViewCell() }
        
        cell.configure(with: imgurs[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = imgurs[indexPath.item]
        goTosubVC(item)
    }
    
    
    
    // Mark - Navigation
    private func goTosubVC(_ item: Imgur) {
        let vc: ViewControllerDetail = UIStoryboard.controller(.main)
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    add white style status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    

}
