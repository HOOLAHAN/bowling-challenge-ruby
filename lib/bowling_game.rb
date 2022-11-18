# file: lib/bowling_game.rb

class Bowling

  def initialize(io, number_of_rounds)
    @score_card = []
    @io = io
    @number_of_rounds = number_of_rounds
  end

  def run_game
    counter = 0
    @io.puts "Welcome to your bowling scorecard"
    while counter < @number_of_rounds do
      counter = counter + 1
      @io.puts "Round #{counter}"
      user_input_scores
      array = @score_card
      running_total = multi_array_sum(array)
      @io.puts "Running total: #{running_total}"
    end
    @io.puts "Here is your scorecard:"
    round = 0
    @score_card.each do |element|
      round = round + 1
      first_roll = element[0]
      second_roll = element[1]
      @io.puts "Round #{round}: first - #{first_roll}, second - #{second_roll}"
    end
    @io.puts "FINAL SCORE: #{running_total}"
  end

  def multi_array_sum(arr)
    sum = 0
    arr.each do |row|
      row.each do |column|
        sum += column
      end
    end
    return sum
  end

  def user_input_scores
    frame_score = []
    # first roll
    while true do
      @io.puts "Please enter first roll score:"
      first_roll = @io.gets.chomp.to_i
      if first_roll == 10
        @io.puts "STRIKE!"
        frame_score << first_roll
        break
      elsif
        first_roll < 11 && first_roll >=0
        frame_score << first_roll
        break
      elsif first_roll > 10
        @io.puts "Invalid score: maximum 10 on first roll"
      end
    end
    binding.irb
    # second roll
    while true do
      if first_roll == 10
        second_roll = 0
        break
      else
        @io.puts "Please enter second roll score:"
        second_roll = @io.gets.chomp.to_i
        if first_roll + second_roll == 10
          @io.puts "SPARE!"
          frame_score << second_roll
          break
        elsif (first_roll + second_roll) < 11 && second_roll >=0
          frame_score << second_roll
          break
        elsif (first_roll + second_roll) > 10
          @io.puts "Invalid score: maximum #{10 - first_roll} on second roll"
        end
      end
    end
    # binding.irb
    @io.puts "Frame score: #{frame_score.sum}"
    @score_card << frame_score
  end


end

# Bowling.new(Kernel, 3).run_game