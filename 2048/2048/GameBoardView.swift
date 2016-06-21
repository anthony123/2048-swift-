//
//  GameBoardViewController.swift
//  2048
//
//  Created by liuwq on 16/5/4.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

protocol TileViewDataSource:class {
    func valueForTile(sender:GameBoardView, position p:(Int,Int))->Int?
}

//configure the game board view
class GameBoardView: UIView
{
    //tiles
    var tiles:Dictionary<NSIndexPath, TileView> = [:]
    weak var datasource:TileViewDataSource?
    
    
    //reset board
    func resetBoard()
    {
        for i in 0..<Constants.dimension{
            for j in 0..<Constants.dimension{
                let pos = NSIndexPath(forRow: j, inSection: i)
                tiles[pos]?.value = nil
            }
        }
        
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        self.backgroundColor = Constants.gameBoardColor
        self.layer.cornerRadius = CGFloat(Constants.boardCornerRadius)
        self.layer.masksToBounds = true
        
        //set up tiles
        for row in 0..<Constants.dimension{
            for column in 0..<Constants.dimension{
                //create a new tile view
                let x = Double(column+1)*Constants.tilePadding + Double(column)*Constants.tileWidth
                let y = Double(row + 1)*Constants.tilePadding + Double(row)*Constants.tileWidth
                let tile = TileView(frame: CGRect(x: x, y: y, width: Constants.tileWidth, height: Constants.tileWidth))
                tile.value = datasource?.valueForTile(self, position: (row, column))
                self.addSubview(tile)
                let position = NSIndexPath(forRow: column, inSection: row)
                tiles[position] = tile
                
            }
        }
        
    }
    
    func swapTilePositions(TileA A: (Int, Int), TileB B:(Int, Int))
    {
        let (x1,y1) = A
        let (x2,y2) = B
        assert(x1 == x2 || y1 == y2)
        
        let pos1 = NSIndexPath(forRow: y1, inSection: x1)
        let pos2 = NSIndexPath(forRow: y2, inSection: x2)
        let tile1 = tiles[pos1]
        let tile2 = tiles[pos2]
        
        UIView.animateWithDuration(Constants.duration, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            let f1 = tile1?.frame
            let label1 = tile1?.numberLabel
            let value1 = tile1?.value
            
            tile1?.frame = (tile2?.frame)!
            tile1?.numberLabel = tile2?.numberLabel
            tile1?.value = tile2?.value
            
            tile2?.frame = f1!
            tile2?.numberLabel = label1
            tile2?.value = value1
            }, completion: nil)
            
    }
    
    
    func resetTile(Position p:(Int, Int))
    {
        let (i,j) = p
        let pos = NSIndexPath(forRow: j, inSection: i)

        let tile = self.tiles[pos]

        tile?.value = self.datasource?.valueForTile(self, position: p)
        //animated
//        UIView.animateWithDuration(Constants.duration) { 
//            tile?.value = self.datasource?.valueForTile(self, position: p)
//        }
        
    }

}
