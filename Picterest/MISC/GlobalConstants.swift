//
//  GlobalConstants.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/29.
//
import UIKit

enum GlobalConstants {
    enum Text {
        
        enum ViewController {
            static var imageListVC: String = "Picterest"
            static var imageRepositoryVC: String = "Repository"
        }
        
        enum CoreData {
            static var modelName = "PictureModel"
        }
        
        enum TabbarItem {
            static var imageListVC: String = "Images"
            static var repositoryVC: String = "Saved"
        }
        
        enum CollectionViewCell {
            static var identifier = "cell"
        }
        
        enum Alert {
            static var saveTitle = "메모를 함께 남겨주세요"
            static var save = "저장"
            static var deleteTitle = "삭제 되었습니다"
            static var confirm = "확인"
            static var askDeleteTitle = "삭제 하시겠습니까?"
            static var no = "아니오"
            static var delete = "삭제"
        }
    }
    
    enum Image {
        
        enum Tabbar {
            case photo
            case star
            
            var image: UIImage {
                switch self {
                case .photo:
                    return UIImage(systemName: "photo.fill.on.rectangle.fill") ?? UIImage()
                case .star:
                    return UIImage(systemName: "star.bubble") ?? UIImage()
                }
            }
        }
        
        enum PictureCell {
            case saved
            case nomal
            case photo
            
            var image: UIImage {
                switch self {
                case .saved:
                    return UIImage(systemName: "star.fill") ?? UIImage()
                case .nomal:
                    return UIImage(systemName: "star") ?? UIImage()
                case .photo:
                    return UIImage(systemName: "photo") ?? UIImage()
                }
            }
        }
    }
    
}
