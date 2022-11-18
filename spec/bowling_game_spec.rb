# file: spec/bowling_game_spec.rb

require 'bowling_game'

describe Bowling do

  context 'user_input_scores method' do
    xit 'prints messages to the user to collect scores and stores the inputs in an array' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Frame score: 8").ordered
      game = Bowling.new(io, 1)
      game.user_input_scores
    end
    xit 'prints a strike message if the user scores a 10 on the first go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Frame score: 10").ordered
      game = Bowling.new(io, 1)
      game.user_input_scores
    end
    xit 'prints a message if the user inputs an invalid score on the first go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("11").ordered
      expect(io).to receive(:puts).with("Invalid score: maximum 10 on first roll").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Frame score: 10").ordered
      game = Bowling.new(io, 1)
      game.user_input_scores
    end
    xit 'prints a message if the user inputs an invalid score on the second go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("6").ordered
      expect(io).to receive(:puts).with("Invalid score: maximum 5 on second roll").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Frame score: 7").ordered
      game = Bowling.new(io, 1)
      game.user_input_scores
    end
    # WRITE FAILING TEST FOR NON INTEGER INPUT
  end

  context 'run_game method' do
    xit 'runs the user_input_scores keeps record of the total score' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("Round 1").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Frame score: 9").ordered
      expect(io).to receive(:puts).with("Running total: 9").ordered
      expect(io).to receive(:puts).with("Here is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 4").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 9").ordered
      game = Bowling.new(io, 1)
      game.run_game
    end

    it 'runs the user_input_scores keeps record of the total score' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("Round 1").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Frame score: 9").ordered
      expect(io).to receive(:puts).with("Running total: 9").ordered
      expect(io).to receive(:puts).with("Round 2").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Frame score: 9").ordered
      expect(io).to receive(:puts).with("Running total: 14").ordered
      expect(io).to receive(:puts).with("Here is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 4").ordered
      expect(io).to receive(:puts).with("Round 2: first - 3, second - 2").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 14").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end




  end

  # context 'when the user scores a spare' do
  #   it 'adds the score of the first roll of the next frame to the previous frame score'
end
