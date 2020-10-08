# frozen_string_literal: true

# https://stackoverflow.com/questions/1489183/colorized-ruby-output-to-the-terminal
class String
  def colorize(color_code)
    "\e[1;#{color_code}m#{self}\e[0m"
  end

  def black
    colorize(30)
  end

  def white
    colorize(37)
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def cyan
    colorize(36)
  end
end
