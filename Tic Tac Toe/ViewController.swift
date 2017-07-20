//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Kaleb Cervantes on 7/16/17.
//  Copyright © 2017 Kaleb Cervantes. All rights reserved.
//

import UIKit

extension String {
	func at(_ i: Int) -> Character {return self[index(startIndex, offsetBy: i)]}
	
	mutating func replace_at(_ i: Int, with: Character){
		self.remove(at: index(startIndex, offsetBy: i))
		self.insert(with, at: index(startIndex, offsetBy: i))
	}
}

class ViewController: UIViewController {
	
	var board = "         "
	
	var player: Character = "X"
	var cpu: Character = "O"
	
	@IBOutlet weak var button_0: UIButton!
	@IBOutlet weak var button_1: UIButton!
	@IBOutlet weak var button_2: UIButton!
	@IBOutlet weak var button_3: UIButton!
	@IBOutlet weak var button_4: UIButton!
	@IBOutlet weak var button_5: UIButton!
	@IBOutlet weak var button_6: UIButton!
	@IBOutlet weak var button_7: UIButton!
	@IBOutlet weak var button_8: UIButton!
	
	func display_game_over_message() {
		if board.contains(" ") {game_over_message.image = UIImage(named: "lose")}
		else {game_over_message.image = UIImage(named: "draw")}
	}
	
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
	
	func cpu_move() {
		let cpu_char_file = String(cpu)
		
		if (wrapper.whose_turn(board) == cpu_char_file){
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
			let cpu_move_index = Int(wrapper.next_best_move_index(board))
			buttons[cpu_move_index].setImage(UIImage(named: cpu_char_file), for: .normal)
			board.replace_at(cpu_move_index, with: cpu)
			
			if wrapper.game_over(board) {display_game_over_message()}
		}
	}
	
	@IBOutlet weak var game_over_message: UIImageView!
	
	@IBOutlet weak var select_x: UIButton!
	@IBOutlet weak var select_o: UIButton!
	
	@IBAction func player_move(_ sender: UIButton) {
		if !wrapper.game_over(board) {
			let player_move_index = sender.tag
			
			let player_char_file = String(player)
			
			if (board.at(player_move_index) == " " && (wrapper.whose_turn(board) == player_char_file)) {
				sender.setImage(UIImage(named: player_char_file), for: .normal)
				board.replace_at(player_move_index, with: player)
			}
			
			if !wrapper.game_over(board) {cpu_move()}
			else {display_game_over_message()}
		}
	}
	
	@IBAction func x_reset(_ sender: UIButton) {
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
		
		button_8.setImage(UIImage(named: "X"), for: .normal)
		board = "        X"
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
