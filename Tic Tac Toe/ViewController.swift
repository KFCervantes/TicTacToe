//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Kaleb Cervantes on 7/16/17.
//  Copyright © 2017 Kaleb Cervantes. All rights reserved.
//

import UIKit

extension String {
	//allows access to characters in a string
	func at(_ i: Int) -> Character {return self[index(startIndex, offsetBy: i)]}
	
	//allows characters to be replaced
	mutating func replace_at(_ i: Int, with: Character){
		self.remove(at: index(startIndex, offsetBy: i))
		self.insert(with, at: index(startIndex, offsetBy: i))
	}
}

class ViewController: UIViewController {
	
	//empty board
	var board = "         "
	
	//player is 'X' by default
	var player: Character = "X"
	var cpu: Character = "O"
	
	//places on boards
	@IBOutlet weak var button_0: UIButton!
	@IBOutlet weak var button_1: UIButton!
	@IBOutlet weak var button_2: UIButton!
	@IBOutlet weak var button_3: UIButton!
	@IBOutlet weak var button_4: UIButton!
	@IBOutlet weak var button_5: UIButton!
	@IBOutlet weak var button_6: UIButton!
	@IBOutlet weak var button_7: UIButton!
	@IBOutlet weak var button_8: UIButton!
	
	//tells player if they lose or draw, impossible for player to win
	func display_game_over_message() {
		//if the game is over and it's not a draw someone won
		if board.contains(" ") {game_over_message.image = UIImage(named: "lose")}
		else {game_over_message.image = UIImage(named: "draw")}
	}
	
	//resets board to blank state
	func reset_board() {
		game_over_message.image = nil
		
		if board != "         " {
			let buttons: [UIButton] = [
				button_0,
				button_1,
				button_2,
				button_3,
				button_4,
				button_5,
				button_6,
				button_7,
				button_8
			]
			
			for button in buttons {button.setImage(nil, for: .normal)}
			
			board = "         "
		}
	}
	
	//lets cpu make move
	func cpu_move() {
		let cpu_char_file = String(cpu)
		
		//makes sure that it is the cpu's turn
		if (wrapper.whose_turn(board) == cpu_char_file){
			//allows access to buttons with an index
			var buttons: [UIButton] = [
				button_0,
				button_1,
				button_2,
				button_3,
				button_4,
				button_5,
				button_6,
				button_7,
				button_8
			]
			let cpu_move_index = Int(wrapper.next_hard_move_index(board))
			buttons[cpu_move_index].setImage(UIImage(named: cpu_char_file), for: .normal)
			board.replace_at(cpu_move_index, with: cpu)
			
			if wrapper.game_over(board) {display_game_over_message()}
		}
	}
	
	//where game over messages are displayed
	@IBOutlet weak var game_over_message: UIImageView!
	
	//reset/player select buttons
	@IBOutlet weak var select_x: UIButton!
	@IBOutlet weak var select_o: UIButton!
	
	//allows player to move
	@IBAction func player_move(_ sender: UIButton) {
		let player_char_file = String(player)
		
		//makes sure player is allowed to go
		if (!wrapper.game_over(board) && (wrapper.whose_turn(board) == player_char_file)){
			let player_move_index = sender.tag
			
			//makes sure move is valid
			if (board.at(player_move_index) == " ") {
				sender.setImage(UIImage(named: player_char_file), for: .normal)
				board.replace_at(player_move_index, with: player)
			}
			
			//has cpu go right after player if they can
			if !wrapper.game_over(board) {cpu_move()}
			else {display_game_over_message()}
		}
	}
	
	//resets board and allows player to select character
	@IBAction func x_reset(_ sender: UIButton) {
		//highlights selected character
		sender.setBackgroundImage(UIImage(named: "highlight"), for: .normal)
		select_o.setBackgroundImage(nil, for: .normal)
		
		player = "X"
		cpu = "O"
		
		reset_board()
	}
	@IBAction func o_reset(_ sender: UIButton) {
		sender.setBackgroundImage(UIImage(named: "highlight"), for: .normal)
		select_x.setBackgroundImage(nil, for: .normal)
		
		player = "O"
		cpu = "X"

		reset_board()
		
		//has cpu move first
		cpu_move()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}
