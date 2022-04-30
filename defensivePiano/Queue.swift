//
//  Queue.swift
//  defensivePiano
//
//  Created by Maksim on 30.04.2022.
//

import Foundation
import UIKit

public struct Queue<T> {

  // 2
  fileprivate var list = LinkedList<T>()

  public var isEmpty: Bool {
    return list.isEmpty
  }
  
  // 3
  public mutating func enqueue(_ element: T) {
    list.append(element)
  }

  // 4
  public mutating func dequeue() -> T? {
    guard !list.isEmpty, let element = list.first else { return nil }

    list.remove(element)

    return element.value
  }

  // 5
  public func peek() -> T? {
    return list.first?.value
  }
}
