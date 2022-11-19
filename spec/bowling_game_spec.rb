# file: spec/bowling_game_spec.rb

require 'bowling_game'

describe Bowling do

  context 'frame method' do
    it 'prints messages to the user to collect scores and stores the inputs in an array' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      game = Bowling.new(io, 1)
      game.frame
    end
    it 'prints a strike message if the user scores a 10 on the first go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      game = Bowling.new(io, 1)
      game.frame
    end
    it 'prints a message if the user inputs an invalid score on the first go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("11").ordered
      expect(io).to receive(:puts).with("Invalid score: maximum 10 on first roll").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      game = Bowling.new(io, 1)
      game.frame
    end
    it 'prints a message if the user inputs an invalid score on the second go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("6").ordered
      expect(io).to receive(:puts).with("Invalid score: maximum 5 on second roll").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      game = Bowling.new(io, 1)
      game.frame
    end
    # WRITE FAILING TEST FOR NON INTEGER INPUT
  end

  context 'run_game method' do
    it 'runs the game and keeps record of the total score for a single round game' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("Round 1").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 9").ordered
      expect(io).to receive(:puts).with("Here is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 4, bonus - 0, total - 9").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 9").ordered
      game = Bowling.new(io, 1)
      game.run_game
    end

    it 'runs the game and keeps record of the total score for a two round game' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("Round 1").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 9").ordered
      expect(io).to receive(:puts).with("Round 2").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Running total: 14").ordered
      expect(io).to receive(:puts).with("Here is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 4, bonus - 0, total - 9").ordered
      expect(io).to receive(:puts).with("Round 2: first - 3, second - 2, bonus - 0, total - 5").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 14").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

  context 'when the user scores a spare' do
    it 'adds the score of the first roll of the next frame to the previous frame score' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("Round 1").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 10").ordered
      expect(io).to receive(:puts).with("Round 2").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Running total: 18").ordered
      expect(io).to receive(:puts).with("Here is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 5, bonus - 0, total - 10").ordered
      expect(io).to receive(:puts).with("Round 2: first - 3, second - 2, bonus - 3, total - 8").ordered # add (spare bonus) highlighter
      expect(io).to receive(:puts).with("FINAL SCORE: 18").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

end
