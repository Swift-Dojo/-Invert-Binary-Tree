//
//  TDDChallengeInvertBinaryTreeTests.swift
//  TDDChallengeInvertBinaryTreeTests
//
//  Created by Mario Alberto Barragán Espinosa on 30/05/21.
//

import XCTest
@testable import TDDChallengeInvertBinaryTree

/*
//MARK: Recursive
class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        
        let head = TreeNode(root.val, root.right, root.left)
        head.left = invertTree(head.left)
        head.right = invertTree(head.right)
        
        return head
    }
}
*/

//MARK: Iterative
class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        
        guard let root = root else { return nil }
        
        var queue = [TreeNode]()
        
        queue.append(root)
        
        while !queue.isEmpty {
            let element = queue.removeFirst()
            
            if let left = element.left {
                queue.append(left)
            }
            
            if let right = element.right {
                queue.append(right)
            }
            
            (element.left, element.right) = (element.right, element.left)
        }
        
        return root         
    }
}

class Invert_Binary_TreeTests: XCTestCase {
    func test_invertTree_withRootNil_returnsNil() {
        let sut = Solution()
        
        let result = sut.invertTree(nil)
        
        XCTAssertNil(result)
    }
    
    func test_invertTree_withChildlessRoot_returnsRoot() {
        let sut = Solution()
        let root = TreeNode(0)
        
        let invertedRoot = sut.invertTree(root)
        
        XCTAssertEqual(root.val, 0)
        XCTAssertNil(invertedRoot?.left)
        XCTAssertNil(invertedRoot?.right)
    }
    
    func test_invertTree_invertsChildrenWithDepth2() {
        let sut = Solution()
        let root = TreeNode(2, TreeNode(1), TreeNode(3))
        
        let invertedRoot = sut.invertTree(root)
        XCTAssertEqual(root.val, 2)
        XCTAssertEqual(invertedRoot?.left?.val, 3)
        XCTAssertEqual(invertedRoot?.right?.val, 1)
    }
    
    func test_invertTree_invertsChildrenWithDepthBiggerThan2() {
        let sut = Solution()
        let leftSubTree = TreeNode(1, TreeNode(4), nil)
        let rightSubTree = TreeNode(3)
        let root = TreeNode(2, leftSubTree, rightSubTree)
        
        let invertedRoot = sut.invertTree(root)
        
        XCTAssertEqual(invertedRoot?.val, 2)
        XCTAssertEqual(invertedRoot?.left?.val, 3)
        XCTAssertEqual(invertedRoot?.right?.val, 1)
        XCTAssertEqual(invertedRoot?.right?.right?.val, 4)
        XCTAssertEqual(invertedRoot?.right?.left?.val, nil)
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
