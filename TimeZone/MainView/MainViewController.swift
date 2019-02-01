//
//  MainViewController.swift
//  TimeZone
//
//  Created by arosenblatt on 11/12/18.
//  Copyright © 2018 InspiredClick. All rights reserved.
//

import UIKit

// Interaction -> View protocol
protocol MainViewType: class {
    var viewModel: MainViewModel? { get set }
    var delegate: MainViewInteractionType? { get set }
}

class MainViewController: UIViewController, MainViewType {
    
    struct Style {
        static let headerHeight: CGFloat = 60
        static let itemHeight: CGFloat = 100
    }
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var globeBackgroundImageView: UIImageView?
    var viewModel: MainViewModel? {
        didSet {
            bindViewModel()
        }
    }
    var delegate: MainViewInteractionType?
    var bgGradient: CAGradientLayer = TZStyle.backgroundGradient()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupDelegate()
    }
    
    private func setupDelegate() {
        delegate = MainViewInteraction(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TapEventCenter.register(self, selector: #selector(self.onTapCell(notification:)))
        
        collectionView?.register(TimeZoneCell.self)
        collectionView?.registerReusableView(TimeHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        
        styleNavBar()
        
        view.layer.insertSublayer(bgGradient, at: 0)
        
        updateGradientFrame(bgGradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = delegate?.loadTimeZones().done({ (viewModel) in
            self.viewModel = viewModel
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateGradientFrame(bgGradient)
        
        collectionView?.reloadData()
    }
    
    func bindViewModel() {
        collectionView?.reloadData()
    }

    @objc func onTapCell(notification: Notification) {
        delegate?.toggleMilitaryTime()
        collectionView?.reloadData()
    }
    
    @IBAction func onTapEditButton() {
        delegate?.tapEditButton()
    }
}
