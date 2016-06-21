//
//  ViewController.swift
//  2048
//
//  Created by liuwq on 16/5/4.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameModelProtocol,TileViewDataSource {

    @IBOutlet weak var scoreLable: UILabel!    
  
    @IBAction func menuTapped(sender: UIButton)
    {
        setupStartUI()
    }
    
    
    @IBOutlet weak var highestScoreLabel: UILabel!{
        didSet{
            highestScoreLabel.text = "历史最高分\n0"
        }
        
    }
    
    
    @IBOutlet weak var board: GameBoardView!{
        didSet{
            board.datasource = self
        }
    }
    
    var model:GameModel? 
    
    //record current score
    var currentScore = 0{
        didSet{
            self.scoreLable.text = "分数\n\(self.currentScore)"
            self.scoreLable.setNeedsDisplay()

            if currentScore > highestScore{
                highestScore = currentScore
            }
        }
    }
    
    var highestScore = 0{
        didSet{
            //saveHighestScore()
            highestScoreLabel.text = "历史最高分\n\(self.highestScore)"
            self.highestScoreLabel.setNeedsDisplay()
        }
    }
    
    let dimension:Int = Constants.dimension
    let threshold:Int = Constants.threshold
    
    func valueForTile(sender: GameBoardView, position p: (Int, Int)) -> Int? {
        let(x,y) = p
        return model?.gameboard[x][y]
    }
    
    
    
    func saveHighestScore(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        let highestScore = userDefault.integerForKey("highestScore")
        if highestScore < self.currentScore{
            userDefault.setInteger(self.currentScore, forKey: "highestScore")
            userDefault.synchronize()

        }
    }
    
    func readHighestScore()->Int{
        let userDefault = NSUserDefaults.standardUserDefaults()
        return userDefault.integerForKey("highestScore")
    }
    
    func setupStartUI()
    {
        //reset score
        //self.scoreLable?.text = "分数\n0"
        
        self.currentScore = 0
        
        
        //set up tiles
        //self.board?.resetBoard()
        self.model?.resetBoard()
        
        //insert two new tile
        self.model!.insertNewTile(2)
        self.model!.insertNewTile(2)
        
        //add gestures
        self.addGestures()
        self.highestScore = readHighestScore()
        print("in the GameViewController: setupStartUI score = \(currentScore)")
        print("in the GameViewController: setupStartUI highestScore = \(highestScore)")
        
    }
    
    
    //set up game board
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        model = GameModel(dimension:Constants.dimension, threshold:Constants.threshold, delegate: self)
        setupStartUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //#pragma - mark procotols
    func updateTileValue(position:(Int,Int))
    {
        //self.board?.resetTile(value, Position: p)
        self.board.resetTile(Position: position)
    }
    
    func userWin()
    {
        saveHighestScore()
        
        //pop up an alert to reminder the user that you have won the game
        let alert = UIAlertController(title: "赢", message: "恭喜你赢得比赛", preferredStyle: .Alert)
        let action = UIAlertAction(title: "确定", style: .Default,handler: nil)
        alert.addAction(action)
        //presentViewController(alert, animated: true, completion: nil)
        presentViewController(alert, animated: true, completion:nil)

        self.setupStartUI()
    }
    
    func userFail()
    {
        saveHighestScore()
        
        //pop up an alert to reminder the user that you have lose the game
        let alert = UIAlertController(title: "输", message: "再来玩一盘吧", preferredStyle: .Alert)
        let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)

        self.setupStartUI()
    }
    
    func swapTilePositions(tileA A: (Int, Int), tileB B:(Int, Int))
    {
        self.board.swapTilePositions(TileA: A, TileB:B)
    }
    
    
    //add gestures
    func addGestures()
    {
        let up = UISwipeGestureRecognizer(target: self, action: #selector(upCommand))
        up.numberOfTouchesRequired = 1
        up.direction = .Up
        self.view.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target: self, action: #selector(downCommand))
        self.view.addGestureRecognizer(down)
        down.numberOfTouchesRequired = 1
        down.direction = .Down
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(leftCommand))
        self.view.addGestureRecognizer(left)
        left.numberOfTouchesRequired = 1
        left.direction = .Left
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(rightCommand))
        self.view.addGestureRecognizer(right)
        right.numberOfTouchesRequired = 1
        right.direction = .Right
    }
    
    @objc func upCommand(){
        //
        let score = self.model?.performSwipe(MoveDirection.Up)
        self.currentScore += score!
        
        var state:(String,String?)
        
        state = self.model!.determineGameState()
        print(state)
        if state.0 == "end" && state.1 == "win"{
            self.userWin()
        }else if (state.0 == "end" && state.1 == "lose"){
            self.userFail()
        }
            
      
       
        
    }
    
    @objc func downCommand(){
        let score = self.model?.performSwipe(MoveDirection.Down)
        self.currentScore += score!
        var state:(String,String?)
        
        state = self.model!.determineGameState()
        print(state)
        if state.0 == "end" && state.1 == "win"{
            self.userWin()
        }else if (state.0 == "end" && state.1 == "lose"){
            self.userFail()
        }
        
        
        
    }
    
    @objc func leftCommand(){
        let score = self.model?.performSwipe(MoveDirection.Left)
        self.currentScore += score!

        var state:(String,String?)
        
        state = self.model!.determineGameState()
        print(state)
        if state.0 == "end" && state.1 == "win"{
            self.userWin()
        }else if (state.0 == "end" && state.1 == "lose"){
            self.userFail()
        }
        
        
    }
    
    @objc func rightCommand(){
        let score = self.model?.performSwipe(MoveDirection.Right)
        self.currentScore += score!

        var state:(String,String?)
      
        state = self.model!.determineGameState()
        print(state)
        if state.0 == "end" && state.1 == "win"{
            self.userWin()
        }else if (state.0 == "end" && state.1 == "lose"){
            self.userFail()
        }
        
        
        
    }
    
}

