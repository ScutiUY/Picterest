//
//  ImageListViewModel.swift
//  Picterest
//
//  Created by 신의연 on 2022/07/25.
//

import UIKit

final class ImageListViewModel {
    
    private var repository = Repository()
    private var imageList: [SavablePictureData] = [SavablePictureData]()
    private var imageSizeList = [CGFloat]()
    private var currentPage = 1
    
    private var loading = false
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var imageListUpdate: () -> Void = { }
    
    var imageCount: Int {
        return imageList.count
    }
    
    func image(at index: Int) -> SavablePictureData {
        if CoreDataManager.shared.searchPicture(id: imageList[index].imageData.id) == nil {
            imageList[index].isSaved = false
            return imageList[index]
        }
        return imageList[index]
    }
    
    func imageSize(at index: Int) -> CGFloat {
        return imageSizeList[index]
    }
    
    func savePicuture(image: UIImage, memo: String, at index: Int) {
        imageList[index].isSaved = true
        let item = imageList[index]
        let fileUrl = PicterestFileManager.shared.savePicture(fileName: item.imageData.id, image: image)
        CoreDataManager.shared.createPictureData(id: item.imageData.id, memo: memo, originUrl: item.imageData.imageUrl.rawUrl, localUrl: fileUrl.path, imageSize: imageSize(at: index))
    }
    
    func deletePicture(indexPath: IndexPath) {
        imageList[indexPath.item].isSaved = false
        let item = imageList[indexPath.item]
        guard let entity = CoreDataManager.shared.searchPicture(id: item.imageData.id) else { return }
        CoreDataManager.shared.delete(entity: entity)
        PicterestFileManager.shared.deletePicture(fileName: item.imageData.id)
    }
    
    func listUpdate() {
        self.imageListUpdate()
    }
    
    func list() {
        loading = true
        loadingStarted()
        resizingImage(page: currentPage) {
            self.imageListUpdate()
            self.loadingEnded()
            self.loading = false
        }
    }
    
    func next() {
        if loading { return }
        loading = true
        loadingStarted()
        currentPage+=1
        resizingImage(page: currentPage) {
            self.imageListUpdate()
            self.loadingEnded()
            self.loading = false
        }
    }
    
    private func resizingImage(page: Int, completion: @escaping () -> Void) -> Void {
        
        let endPoint = ImageEndPoint.getImage(page: page)
        repository.fetchImageData(endPoint) { [self] result in
            switch result {
            case .success(let imageList):
                imageList.forEach {
                    if (CoreDataManager.shared.searchPicture(id: $0.id) != nil) {
                        self.imageList.append(SavablePictureData(imageData: $0, isSaved: true))
                    } else {
                        self.imageList.append(SavablePictureData(imageData: $0))
                    }
                }
                imageList.forEach {
                    let height = getImageHeight(height: CGFloat($0.height), width: CGFloat($0.width))
                    imageSizeList.append(height)
                }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImageHeight(height: CGFloat, width: CGFloat) -> CGFloat {
        let scale = 150 / width
        return height * scale
    }
    
}
