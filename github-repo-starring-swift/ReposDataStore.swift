//
//  ReposDataStore.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    fileprivate init() {}
    
    var repositories:[GithubRepository] = []
    
    func getRepositories(with completion: @escaping () -> ()) {
        GithubAPIClient.getRepositories { (reposArray) in
            self.repositories.removeAll()
            for dictionary in reposArray {
                guard let repoDictionary = dictionary as? [String : Any] else { fatalError("Object in reposArray is of non-dictionary type") }
                let repository = GithubRepository(dictionary: repoDictionary)
                self.repositories.append(repository)
                
            }
            completion()
        }
    }
    
    func toggleStarStatus(for repo: GithubRepository, starred: @escaping (Bool) -> () ) {
        GithubAPIClient.checkIfRepositoryIsStarred(repo.fullName) { (isStarred) in
            if isStarred == true {
                GithubAPIClient.unstarRepository(named: repo.fullName, completion:  {
                    starred(false)
                    print("repo was unstarred")
                })
            }
            else {
                GithubAPIClient.starRepository(named: repo.fullName, completion: {
                    starred(true)
                    print("repo was starred")
                })
            }
        }
    }
}

        
        
      
            
            

