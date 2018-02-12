WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def valid_move?(board, index)
  if (index >= 0 && index < 9 && position_taken?(board, index) == false)
    true
  else
    false
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == '' || !board[index]
    false
  else
    true
  end
end

def move(board, input, char)
  char = current_player(board)
  board[input] = char
  return board
end

def turn(board)
  puts 'Please enter 1-9:'
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  moveCount = 0
  while moveCount < 9
    turn(board)
    moveCount += 1
  end
end

def turn_count(board)
  spacesUsed = 0
  board.each { |space| 
    if space != ' ' && space != ''
      spacesUsed += 1
    end
  }
  spacesUsed
end

def current_player(board)
  if turn_count(board) % 2 == 0
    'X'
  else
    'O'
  end
end

def won?(board)
  xWon = false
  oWon = false
  WIN_COMBINATIONS.each { |winCombo|
    xWon = winCombo.all? do |index|
      board[index] == 'X'
    end
    if xWon == true
      return winCombo
    end
    oWon = winCombo.all? do |index|
      board[index] == 'O'
    end
    if oWon == true
      return winCombo
    end
  }
  return false
end

def full?(board)
  board.none? { |index| index == ' ' || index == ''}
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    true
  else
    false
  end
end

def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  else
    nil
  end
end