//
//  HomeDashBoardVC.swift
//  IBR Bazaar
//
//  Created by Monish M S on 01/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class HomeDashBoardVC:UIViewController{
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet var restaurantsView: UIView!
    @IBOutlet var bakeryView: UIView!
    @IBOutlet var meatView: UIView!
    @IBOutlet var groceryView: UIView!
    @IBOutlet var fishView: UIView!
    @IBOutlet var vegetablesView: UIView!
    @IBOutlet var brandedItemsView: UIView!
    
   
    
    
    
    var logoImages: [UIImage] = []
    
    var categoryImageArrayOne:[UIImage] =   [UIImage(named: "ecom_category_4")!,
                                        UIImage(named: "ecom_category_8")!,
                                        UIImage(named: "ecom_category_9")!]
    
    var categoryOfferAndReferImageArray:[UIImage] = [UIImage(named: "ecom_category_4")!,
                                                     UIImage(named: "ecom_category_8")!]
    
    var categoryImageArrayTwo:[UIImage] =   [UIImage(named: "ecom_category_7")!,
                                             UIImage(named: "ecom_category_2")!,
                                             UIImage(named: "ecom_category_6")!,
                                             UIImage(named: "promo")!]
    var categoryTitleArrayOne = ["RESTAURANTS","BAKERY","MEAT"]
    var categoryTitleArrayTwo = ["GROCERY","FISH","VEGETABLES","BRANDED ITEMS"]
                                       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
        setupImage()
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if userDefaults.GET_USERDEFAULTSSTATUS(objectValue: "fromCartVC"){
            userDefaults.SET_USERDEFAULTS(user_language: false, objectValue: "fromCartVC")
             self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
        }
    }
   
    
    func setupUI(){
//        sliderMenu.delegate = self
//        sliderMenu.dataSource = self
//        sliderMenu.type = .linear
        userDefaults.SET_USERDEFAULTS(user_language: false, objectValue: "fromCartVC")
        header.backgroundColor = UIColor.clear
        
        view1.backgroundColor  = UIColor.clear
        view2.backgroundColor = UIColor.clear
      //  homeDashBoardCollectionView.isScrollEnabled = false
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "verification_bg")!)
        
        let resgesture = UITapGestureRecognizer(target: self, action: #selector(resButtonTapped(_:)))
        let bakerygesture = UITapGestureRecognizer(target: self, action: #selector(bakeryButtonTapped(_:)))
        let meatgesture = UITapGestureRecognizer(target: self, action: #selector(meatButtonTapped(_:)))
        let grocerygesture = UITapGestureRecognizer(target: self, action: #selector(groceryButtonTapped(_:)))
        let fishgesture = UITapGestureRecognizer(target: self, action: #selector(fishButtonTapped(_:)))
        let veggesture = UITapGestureRecognizer(target: self, action: #selector(vegButtonTapped(_:)))
        let brandedgesture = UITapGestureRecognizer(target: self, action: #selector(brandedButtonTapped(_:)))
        
        restaurantsView.addGestureRecognizer(resgesture)
        bakeryView.addGestureRecognizer(bakerygesture)
        meatView.addGestureRecognizer(meatgesture)
        groceryView.addGestureRecognizer(grocerygesture)
        fishView.addGestureRecognizer(fishgesture)
        vegetablesView.addGestureRecognizer(veggesture)
        brandedItemsView.addGestureRecognizer(brandedgesture)
        
//        logoImages += [UIImage(named: "avatar")!, UIImage(named: "avatar")!,UIImage(named: "avatar")!]
//
//        sliderCollection.logoImages = logoImages
//        sliderCollection.reloadSlidingView()
       // sliderCollection.startTimer()
        
//        homeDashBoardCollectionView.delegate = self
//        homeDashBoardCollectionView.dataSource = self
//        homeDashBoardCollectionView.register(UINib(nibName: "shopByCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shopByCategoryCollectionViewCell")
//        homeDashBoardCollectionView.register(UINib(nibName: "shopByCategoryImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shopByCategoryImageCollectionViewCell")
    }
    
    func setupImage(){
        slideshow.slideshowInterval = 3.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = .scaleAspectFit
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
       
        slideshow.setImageInputs([
            ImageSource(image: UIImage(named: "logo")!),
            ImageSource(image: UIImage(named: "ecom_category_2")!)
            ])
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }
    
}

extension HomeDashBoardVC{
    
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        fullScreenController.backgroundColor = UIColor.clear
    }
    
    @objc func resButtonTapped(_ recognizer:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
    }
    
    @objc func bakeryButtonTapped(_ recognizer:UITapGestureRecognizer){
//        self.performSegue(withIdentifier: "segueToHomeShopsVC", sender: nil)
        self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
        
    }
    
    @objc func meatButtonTapped(_ recognizer:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
    }
    
    @objc func groceryButtonTapped(_ recognizer:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
    }
    
    @objc func fishButtonTapped(_ recognizer:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
    }
    
    @objc func vegButtonTapped(_ recognizer:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
    }
    
    @objc func brandedButtonTapped(_ recognizer:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "segueToHomeShopsTempVC", sender: nil)
    }
    
}


//extension HomeDashBoardVC:iCarouselDelegate,iCarouselDataSource{
//    func numberOfItems(in carousel: iCarousel) -> Int {
//        return 10
//    }

//    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//        let imageView: UIImageView
//
//        if view != nil {
//            imageView = view as! UIImageView
//        } else {
//            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.sliderMenu.bounds.height - 10))
//        }
//
//        imageView.image = UIImage(named: "avatar")
//
//        return imageView
//    }
    
//    //  Converted to Swift 5 by Swiftify v5.0.7505 - https://objectivec2swift.com/
//    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//        var view = view
//        var label: UILabel? = nil
//
//        //create new view if no view is available for recycling
//        if view == nil {
//            //don't do anything specific to the index within
//            //this `if (view == nil) {...}` statement because the view will be
//            //recycled and used with other index values later
//            view = UIImageView(frame: CGRect(x: 0, y: 0, width: 200.0, height: 200.0))
//            (view as? UIImageView)?.image = UIImage(named: "avatar.png")
//            view?.contentMode = .center
//
//            label = UILabel(frame: view?.bounds ?? CGRect.zero)
//            label?.backgroundColor = UIColor.clear
//            label?.textAlignment = .center
//            label?.font = label?.font.withSize(50)
//            label?.tag = 1
//            if let label = label {
//                view?.addSubview(label)
//            }
//        } else {
//            //get a reference to the label in the recycled view
//            label = view?.viewWithTag(1) as? UILabel
//        }
//
//
//
//
//        return view!
//    }
//
//
//    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
//        if option == .spacing  {
//            return value * 1.1
//        }
//        return value
//    }
//}
