//
//  CameraViewController.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON
import YPImagePicker

class CameraViewController: UIViewController {
    @IBOutlet weak var resultImageView: UIImageView!

    //UIImagePickerController1. 인스턴스 생성
    let picker = UIImagePickerController()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIImagePickerController2.
        picker.delegate = self

    }
    
    //OpenSource
    @IBAction func ypimagePickerButtonClicked(_ sender: UIButton) {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                self.resultImageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    //UIImagePickerController
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용 불가 + 사용자에게 토스트/얼럿")
            return
        }
        
        picker.sourceType = .camera
        picker.allowsEditing = true// 편집화면
        
        present(picker, animated: true)
    }
    
    //UIImagePickerController
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("사용 불가 + 사용자에게 토스트/얼럿")
            return
        }
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false // 편집화면
        
        
        present(picker, animated: true)
    
    }
    
    @IBAction func saveToPhotoLibrary(_ sender: UIButton) {
        
        if let image = resultImageView.image {
            UIImageWriteToSavedPhotosAlbum(image , nil, nil, nil)
        }
        
    }
    
    //이미지뷰 이미지 > 네이버 > 얼굴분석해줘 요청 > 응답
    //이미지는 문자열이 아니기 때문에 이미지, pdf, 파일 등은 그대로 전송하기 어려움 -> 텍스트 형태로 인코딩
    //어떤 파일의 종류가 서버에게 전달이 되는지 명시 = Content-Type
    @IBAction func clovaFaceButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : "v2HQhEAEZwIjq25AShab",
            "X-Naver-Client-Secret" : "x86ZoT5Zut",
            "Content-Type" : "multipart/form-data; boundary={boundary-text}"
        ]
        
        //UIImage를 텍스트 형태(바이너리 타입)로 변환해서 전달
        guard let imageData = resultImageView.image?.jpegData(compressionQuality: 0.3) else { return }
        
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(imageData), withName: "image")
        }, to: url, headers: header)
        .validate().responseData { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print(json)
            
  
            
        case .failure(let error):
            print(error)
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
}
//UIImagePickerController3.
//네비게이션 컨트롤러를 상속받고 있음
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //UIImagePickerController4. 사진을 선택하거나 카메라 촬영 직후
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        //원본, 편집, 메타 데이터 등 - infoKey
    
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.resultImageView.image = image
            dismiss(animated: true)
        }
    }
    
    //UIImagePickerController5. 취소 버튼 클릭시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
    
    
}
