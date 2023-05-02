//
//  LibraryAPI.swift
//  BookPlayerTests
//
//  Created by gianni.carlo on 24/4/22.
//  Copyright © 2022 Tortuga Power. All rights reserved.
//

import Foundation

public enum LibraryAPI {
  case contents(path: String)
  case upload(params: [String: Any])
  case update(params: [String: Any])
  case move(origin: String, destination: String)
  case remoteFileURL(path: String)
  case remoteContentsURL(path: String)
  case delete(path: String)
  case shallowDelete(path: String)
  case bookmarks(path: String)
  case setBookmark(path: String, note: String?, time: Double, isActive: Bool)
}

extension LibraryAPI: Endpoint {
  public var path: String {
    switch self {
    case .contents:
      return "/v1/library"
    case .upload:
      return "/v1/library"
    case .update:
      return "/v1/library"
    case .move:
      return "/v1/library/move"
    case .remoteFileURL:
      return "/v1/library"
    case .remoteContentsURL:
      return "/v1/library"
    case .delete:
      return "/v1/library"
    case .shallowDelete:
      return "/v1/library/folder_in_out"
    case .bookmarks:
      return "/v1/library/bookmarks"
    case .setBookmark:
      return "/v1/library/bookmark"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .contents:
      return .get
    case .upload:
      return .put
    case .update:
      return .post
    case .move:
      return .post
    case .remoteFileURL:
      return .get
    case .remoteContentsURL:
      return .get
    case .delete:
      return .delete
    case .shallowDelete:
      return .delete
    case .bookmarks:
      return .post
    case .setBookmark:
      return .put
    }
  }

  public var parameters: [String: Any]? {
    switch self {
    case .contents(let path):
      return ["relativePath": path]
    case .upload( let params):
      return params
    case .update(let params):
      return params
    case .move(let origin, let destination):
      return [
        "origin": origin,
        "destination": destination
      ]
    case .remoteFileURL(let path):
      return [
        "relativePath": path,
        "sign": true
      ]
    case .remoteContentsURL(let path):
      return [
        "relativePath": "\(path)/",
        "sign": true
      ]
    case .delete(let path):
      return ["relativePath": path]
    case .shallowDelete(let path):
      return ["relativePath": path]
    case .bookmarks(let path):
      return ["relativePath": path]
    case .setBookmark(let path, let note, let time, let isActive):
      var params: [String: Any] = [
        "key": path,
        "time": time,
        "active": isActive
      ]

      if let note {
        params["note"] = note
      }

      return params
    }
  }
}