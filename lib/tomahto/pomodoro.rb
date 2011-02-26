module Tomahto
#   class Set
#     def initialize
#     end
# 
#     def start
#       Pomodoro.run
#     end
#   end

  class Pomodoro
    def initialize(activity_length=25, break_length=5, iterations=4)
      @activity_length = activity_length
      @break_length = break_length
      @iterations = iterations
    end

    def run
      @iterations.times do 
        progress "Activity", @activity_length
        notify "Tomahto: Iteration Complete!", "Take a short break and remember to add a mark to your activity."
        progress "Break", @break_length
        notify "Tomahto: Break's over!", "On to the next pomodoro."
      end
    end

    protected

    def progress(label, minutes)
      1.upto(minutes * 60) do |second|
        display_progress(label, minutes, second)
        Kernel.sleep 0.01
      end
      puts "\n"
    end

    def display_progress(label, minutes, second)
      total_seconds_left = minutes * 60 - second
      progress_past      = second / 60
      progress_left      = minutes - progress_past
      minutes_left       = total_seconds_left / 60
      seconds_left       = total_seconds_left % 60

      printf "\r%20s - %s%s - %.2d:%.2d", label, "#" * progress_past, "." * progress_left, minutes_left, seconds_left
    end

    def notify(summary, message)
      puts message
      Kernel.system("notify-send -t 500 \"#{summary}\" \"#{message}\"")
    end
  end

  class Activity
  end
end
