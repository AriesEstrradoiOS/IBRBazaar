//
//  SliderBaseView.swift
//  IBR Bazaar
//
//  Created by Monish M S on 05/08/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

protocol sliderImageProtocol:class{
    func sliderTappedImage(row:Int)
}

import Foundation
import UIKit
@IBDesignable class SliderBaseView:UIView{
    
    @IBOutlet var collection: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var sliderBaseViewHeight: NSLayoutConstraint!
    
    var view:UIView!
    var logoImages: [UIImage] = []
    var IndexSelected = -1
    var begin:Bool = false
    var timer = Timer()
    var cellHeight:CGFloat = 0
    weak var delegate: sliderImageProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SliderBaseView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        //view.frame = bounds
        //view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let leftSideConstraint = NSLayoutConstraint(item: view!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: view!, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: view!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        self.addConstraints([leftSideConstraint, bottomConstraint, heightConstraint, widthConstraint])
        collection.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collection.collectionViewLayout = layout
        pageControl.hidesForSinglePage = true
    }
    
    override func didMoveToSuperview() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
    }
    
    public func invalidateLayoutAndReload(){
        collection.reloadData()
    }
    
    public func reloadSlidingView (){
        collection.reloadData()
    }
    
   
    
    
    func  scrollToPosition(position:Int)  {
        IndexSelected = position
        collection.scrollToItem(at: NSIndexPath(row: IndexSelected, section: 0) as IndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func scrollToNextCell(){
        
        //get Collection View Instance
        //let collectionView:UICollectionView;
        
        //get cell size
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height);
        
        //get current content Offset of the Collection view
        let contentOffset = collection.contentOffset;
        
        
        if collection.contentSize.width <= collection.contentOffset.x + cellSize.width
        {
            collection.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);

        } else {
            collection.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);

        }
    }
    
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
        
       timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(SliderBaseView.scrollToNextCell), userInfo: nil, repeats: true);
        
    }
    
    func endTimer(){
       timer.invalidate()
    }
}

extension SliderBaseView:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = logoImages.count
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        return count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath as IndexPath) as! SliderCell
        cell.slideImage.image = logoImages[indexPath.row]
        IndexSelected = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.section
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let cellWidth = UIScreen.main.bounds.size.width-16
        let cellWidth = UIScreen.main.bounds.size.width
       
        return CGSize(width: cellWidth, height: sliderBaseViewHeight.constant)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.sliderTappedImage(row: indexPath.row)
    }
}

extension SliderBaseView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
      //pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width-38)
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
          // pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.bounds.size.width-38)
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.bounds.size.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.bounds.size.width-38)
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.bounds.size.width)
    }
}
