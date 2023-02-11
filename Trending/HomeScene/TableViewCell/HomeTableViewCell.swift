//
//  HomeTableViewCell.swift
//  Trending
//
//  Created by Natia's Mac on 09.02.23.
//

import UIKit
import SkeletonView

enum LanguageIconColors {
   static var colors = [ "🟢", "🟡", "🟠", "🔴", "🟤", "🔵"]
//   ""
     // UIColor.lightGray, UIColor.carrot, UIColor.red, UIColor.blue, UIColor.greenSea
}


final class HomeTableViewCell: UITableViewCell {
    
    //MARK: UI
    
    var avatarImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.setDimensions(height: 40, width: 40)
        image.layer.cornerRadius = 20
        image.isSkeletonable = true
        return image
    }()
    
    var fullName: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
       // lb.font = .systemFont(ofSize: 16)
        lb.numberOfLines = 0
        lb.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lb.clipsToBounds = true
        lb.isSkeletonable = true
        return lb
    }()

    let githubAddress: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 14, weight: .semibold)
        lb.numberOfLines = 0
        return lb
    }()
    
    var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 13, weight: .bold)
        lb.numberOfLines = 0
        lb.setContentHuggingPriority(.defaultLow, for: .vertical)
        lb.isSkeletonable = true
        return lb
    }()
    
    let language: UILabel = {
        let lb = UILabel()
//lb.textColor = .black
        lb.font = .systemFont(ofSize: 13, weight: .bold)
        return lb
    }()
    
    let stars: UILabel = {
        let lb = UILabel()
      //  lb.textColor = .black
        lb.font = .systemFont(ofSize: 13, weight: .bold)
        lb.tintColor = .yellow
        return lb
    }()
    
  
    //MARK: View lifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        setUpViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: Private Methods
    
    private func setUpViews() {
        
        contentView.addSubview(avatarImage)
        avatarImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 15, paddingLeft: 15)
        let horizontalStackview = UIStackView(arrangedSubviews: [language, stars])
        horizontalStackview.axis = .horizontal
        horizontalStackview.distribution = .fill
        horizontalStackview.spacing = 10
        
        let verticalStackview = UIStackView(arrangedSubviews: [fullName, descriptionLabel,githubAddress, horizontalStackview])
        verticalStackview.axis = .vertical
        verticalStackview.distribution = .fill
        verticalStackview.spacing = 5
        contentView.addSubview(verticalStackview)
        verticalStackview.anchor( top: contentView.topAnchor,
                                  left: avatarImage.rightAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor ,
                                  paddingTop: 5,
                                  paddingLeft: 15,
                                  paddingBottom: 5,
                                  paddingRight: 15)
        verticalStackview.isSkeletonable = true
        
//        contentView.addSubview(horizontalStackview)
//        horizontalStackview.anchor(top: verticalStackview.bottomAnchor, left: verticalStackview.leftAnchor, bottom: contentView.bottomAnchor, right: verticalStackview.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 20, paddingRight: 0)

    }
    
    //MARK: Configure Cell
    
    func configureCell(with item: Item) {
        self.fullName.text = item.fullName
        self.descriptionLabel.text = item.description
        self.stars.text = " ⭐️ \(item.stars)"
        guard let language = item.language , let circle = LanguageIconColors.colors.randomElement() else { return }
        self.language.text = "\( circle) \(language)"
       
       
        self.githubAddress.text = "Home page: \(item.githubAddress)"
        guard let defaultImageURL = URL(string: "https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg")  else { return }
        self.avatarImage.load(url: ((URL(string: item.owner.image) ?? defaultImageURL)))
    }
}
