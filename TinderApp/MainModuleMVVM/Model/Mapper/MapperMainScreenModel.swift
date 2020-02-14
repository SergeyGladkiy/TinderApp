//
//  MapperMainScreenModel.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class MapperMainScreenModel {
    private func createUserPhotos(from array: [TinderUserPhoto]) -> [UserPhoto] {
        array.map { tinderUserPhoto in
            UserPhoto(id: tinderUserPhoto.id, url: tinderUserPhoto.url, processedFiles: tinderUserPhoto.processedFiles.map {
                UserProcessedFiles(url: $0.url, width: $0.width, height: $0.height)
            })
        }
    }
    
    private func creatUserInfor(from data: TinderUserInfo) -> UserInfo {
        let userPhotos = createUserPhotos(from: data.photos)
        let noInfor = "no information"
        let userJobInfo = "Company: \(data.jobs.first?.company?.name ?? noInfor)"
        let userSchoolInfo = "School: \(data.schools.first?.name ?? noInfor)"
        let userCityInfo = "City: \(data.city?.name ?? noInfor)"
        
        return UserInfo(id: data._id, bio: data.bio, birthDate: data.birthDate, name: data.name, photos: userPhotos, gender: data.gender, jobs: userJobInfo, schools: userSchoolInfo, city: userCityInfo)
    }
}

extension MapperMainScreenModel: InterfaceMapperMainScreenModel {
    func getDataSource(from data: DataTinder) -> [MainScreenDataSource] {
        let resultsDataTinder = data.results
        
        return resultsDataTinder.map { tinderUserResult in
            let userInfo = creatUserInfor(from: tinderUserResult.user)
            
            return MainScreenDataSource(userInfo: userInfo, distance: tinderUserResult.distanceMi, sNumber: tinderUserResult.sNumber)
        }
    }
    
}
