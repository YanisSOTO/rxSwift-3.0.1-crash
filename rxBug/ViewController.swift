//
//  ViewController.swift
//  rxBug
//
//  Created by Soto Yanis on 07/01/2017.
//  Copyright © 2017 Soto Yanis. All rights reserved.
//

import RxSwift
import RxDataSources
import RxCocoa

class ViewController: UIViewController{

    var disposeBag = DisposeBag()

    var viewModel = ViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, CollectionCellModel>>! = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, CollectionCellModel>>()


    

    override func viewDidLoad() {
        super.viewDidLoad()
        //setBindings() This resolve the crash in 3.0.1 
        //setSubView()
        setSubView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBindings()
    }

    func setSubView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let size = layout.itemSize
            let scale = 1000 / 320
            let layout = SRCollectionViewStackLayout();
            layout.itemSize = size.applying(CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale)))
           layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionView.collectionViewLayout = layout
        }
    }
    
    func setBindings() {
        
        dataSource.configureCell = {(_, tv, indexPath, element) in

            let cellViewModel = element
            
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? CollectionCell else {return CollectionCell()}
            
            cellViewModel.text.asObservable().observeOn(MainScheduler.instance).bindTo(cell.textLabel.rx.text).addDisposableTo(cell.disposeBag)
            
            return cell
        }
        
        viewModel.cellsViewModel
            .asObservable().observeOn(MainScheduler.instance)
            .bindTo(collectionView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        
        collectionView
            .rx.delegate
            .setForwardToDelegate(self, retainDelegate: false)

    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

