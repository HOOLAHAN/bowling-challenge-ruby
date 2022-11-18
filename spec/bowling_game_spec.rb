# file: spec/bowling_game_spec.rb

require 'bowling_game'

describe Bowling do

  context 'user_input_scores method' do
    it 'prints messages to the user to collect scores and stores the inputs in an array' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Frame score: 8").ordered
      game = Bowling.new(io)
      game.user_input_scores
    end
    it 'prints a strike message if the user scores a 10 on the first go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Frame score: 10").ordered
      game = Bowling.new(io)
      game.user_input_scores
    end
    it 'prints a message if the user inputs an invalid score on the first go' do
      io = double :io
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("11").ordered
      expect(io).to receive(:puts).with("Invalid score: maximum 10 on first roll").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Frame score: 10").ordered
      game = Bowling.new(io)
      game.user_input_scores
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
      expect(io).to receive(:puts).with("Frame score: 7").ordered
      game = Bowling.new(io)
      game.user_input_scores
    end
  end


end
