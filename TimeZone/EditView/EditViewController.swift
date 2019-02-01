//
//  EditViewController.swift
//  TimeZone
//
//  Created by arosenblatt on 11/18/18.
//  Copyright © 2018 Inspiredclick. All rights reserved.
//

import UIKit

protocol EditViewType: class {
    var viewModel: EditViewModel? { get set }
    var delegate: EditViewInteractionType? { get set }
    var tableView: UITableView? { get set }
    var searchBar: UISearchBar? { get set }
}

class EditViewController: UIViewController, EditViewType {
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    var viewModel: EditViewModel? {
        didSet {
            bindViewModel()
        }
    }
    var delegate: EditViewInteractionType?
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
        delegate = EditViewInteraction(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = EditViewModel()

        styleNavBar()
        
        tableView?.register(EditViewCell.self)
        
        view.layer.insertSublayer(bgGradient, at: 0)
        
        updateGradientFrame(bgGradient)
        
        _ = delegate?.loadTimeZones().done({ (viewModels) in
            self.viewModel?.savedTimeZones = viewModels
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateGradientFrame(bgGradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        tableView?.reloadData()
        tableView?.setEditing(viewModel.editMode, animated: true)
    }
    
}
