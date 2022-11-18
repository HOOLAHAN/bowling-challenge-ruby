# file: lib/bowling_game.rb

class Bowling

  def initialize(io)
    @score_card = []
    @io = io
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
    @io.puts "Frame score: #{frame_score.sum}"
  end


end

# Bowling.new(Kernel).user_input_scores