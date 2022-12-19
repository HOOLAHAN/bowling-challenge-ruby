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
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 9").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 4, bonus - 0, total - 9").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 9").ordered
      game = Bowling.new(io, 1)
      game.run_game
    end

    it 'runs the game and keeps record of the total score for a two round game' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 9").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Running total: 14").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 4, bonus - 0, total - 9").ordered
      expect(io).to receive(:puts).with("Round 2: first - 3, second - 2, bonus - 0, total - 5").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 14").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

  context 'when the user scores a spare' do
    it 'FAILING the score of the first roll in the next frame is added as a bonus to the previous frame' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 10").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Running total: 18").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 5, bonus - 3, total - 13").ordered
      expect(io).to receive(:puts).with("Round 2: first - 3, second - 2, bonus - 0, total - 5").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 18").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

  context 'when the user scores a strike' do
    it 'the score of the first and second roll in the next frame is added as a bonus to the previous frame' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 10").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Running total: 24").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 10, second - 0, bonus - 7, total - 17").ordered
      expect(io).to receive(:puts).with("Round 2: first - 4, second - 3, bonus - 0, total - 7").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 24").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

  context 'when the user bowls a gutter game' do
    it 'the final score will be zero' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("0").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("0").ordered
      expect(io).to receive(:puts).with("Running total: 0").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("0").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("0").ordered
      expect(io).to receive(:puts).with("Running total: 0").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 0, second - 0, bonus - 0, total - 0").ordered
      expect(io).to receive(:puts).with("Round 2: first - 0, second - 0, bonus - 0, total - 0").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 0").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

  context 'when the user bowls a strike in the final frame' do
    it 'gives the user two extra rolls with bonus points' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 7").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter third roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Running total: 24").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 3, second - 4, bonus - 0, total - 7").ordered
      expect(io).to receive(:puts).with("Round 2: first - 10, second - 5, bonus - 2, total - 17").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 24").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

  context 'when the user bowls a spare in the final frame' do
    it 'gives the user one extra roll with bonus points' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 7").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("6").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Please enter third roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Running total: 22").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 3, second - 4, bonus - 0, total - 7").ordered
      expect(io).to receive(:puts).with("Round 2: first - 6, second - 4, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 22").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

  context 'when the user bowls a perfect game' do
    it 'the total of a 10 frame game should be 300' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 10").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 40").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 3\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 70").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 4\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 100").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 5\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 130").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 6\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 160").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 7\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 190").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 8\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 220").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 9\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 250").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 10\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Please enter third roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("Running total: 300").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 2: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 3: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 4: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 5: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 6: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 7: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 8: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 9: first - 10, second - 0, bonus - 20, total - 30").ordered
      expect(io).to receive(:puts).with("Round 10: first - 10, second - 10, bonus - 10, total - 30").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 300").ordered
      game = Bowling.new(io, 10)
      game.run_game
    end
  end

  context 'example game' do
    it 'test for correct scores' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 5").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Running total: 14").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 3\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("6").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 24").ordered # bonus of 5 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nRound 4\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 39").ordered # bonus of 10 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nRound 5\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 59").ordered # bonus of 1 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nRound 6\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("0").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("Running total: 61").ordered 
      expect(io).to receive(:puts).with("----------------------------------------\nRound 7\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("7").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 71").ordered # bonus of 6 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nRound 8\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("6").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 87").ordered # bonus of 10 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nRound 9\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 107").ordered # bonus of 10 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nRound 10\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("8").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Please enter third roll score:").ordered
      expect(io).to receive(:gets).and_return("6").ordered
      expect(io).to receive(:puts).with("Running total: 133").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 1, second - 4, bonus - 0, total - 5").ordered
      expect(io).to receive(:puts).with("Round 2: first - 4, second - 5, bonus - 0, total - 9").ordered
      expect(io).to receive(:puts).with("Round 3: first - 6, second - 4, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("Round 4: first - 5, second - 5, bonus - 10, total - 20").ordered
      expect(io).to receive(:puts).with("Round 5: first - 10, second - 0, bonus - 1, total - 11").ordered
      expect(io).to receive(:puts).with("Round 6: first - 0, second - 1, bonus - 0, total - 1").ordered
      expect(io).to receive(:puts).with("Round 7: first - 7, second - 3, bonus - 6, total - 16").ordered
      expect(io).to receive(:puts).with("Round 8: first - 6, second - 4, bonus - 10, total - 20").ordered
      expect(io).to receive(:puts).with("Round 9: first - 10, second - 0, bonus - 10, total - 20").ordered
      expect(io).to receive(:puts).with("Round 10: first - 2, second - 8, bonus - 6, total - 16").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 133").ordered
      game = Bowling.new(io, 10)
      game.run_game
    end
  end

  context 'when a strike is followed by a spare' do
    it 'the bonus on the strike is 10' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Running total: 5").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("10").ordered
      expect(io).to receive(:puts).with("STRIKE!").ordered
      expect(io).to receive(:puts).with("Running total: 15").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 3\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 35").ordered # bonus of 5 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nRound 4\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Running total: 47").ordered # bonus of 10 to be added
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 2, second - 3, bonus - 0, total - 5").ordered
      expect(io).to receive(:puts).with("Round 2: first - 10, second - 0, bonus - 10, total - 20").ordered
      expect(io).to receive(:puts).with("Round 3: first - 5, second - 5, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("Round 4: first - 5, second - 2, bonus - 0, total - 7").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 47").ordered
      game = Bowling.new(io, 4)
      game.run_game
    end
  end

  context 'when the user bowls a game of spares' do
    it 'the total of a 10 frame game should be 300' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 10").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 25").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 3\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 40").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 4\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Running total: 55").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 5\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Please enter third roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Running total: 75").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 5, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("Round 2: first - 5, second - 5, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("Round 3: first - 5, second - 5, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("Round 4: first - 5, second - 5, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("Round 5: first - 5, second - 5, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 75").ordered
      game = Bowling.new(io, 5)
      game.run_game
    end
  end

  context 'when the user enters invalid inputs' do
    it 'prints a message to the console' do
      io = double :io
      expect(io).to receive(:puts).with("\nWelcome to your bowling scorecard").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 1\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered 
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("7").ordered
      expect(io).to receive(:puts).with("Invalid score: maximum 5 on second roll").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Running total: 9").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nRound 2\n--------").ordered
      expect(io).to receive(:puts).with("Please enter first roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Please enter second roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("SPARE!").ordered
      expect(io).to receive(:puts).with("Please enter third roll score:").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("Running total: 24").ordered
      expect(io).to receive(:puts).with("----------------------------------------\nHere is your scorecard:").ordered
      expect(io).to receive(:puts).with("Round 1: first - 5, second - 4, bonus - 0, total - 9").ordered
      expect(io).to receive(:puts).with("Round 2: first - 5, second - 5, bonus - 5, total - 15").ordered
      expect(io).to receive(:puts).with("FINAL SCORE: 24").ordered
      game = Bowling.new(io, 2)
      game.run_game
    end
  end

end
