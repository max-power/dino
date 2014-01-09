module Dino
  module Components
    class RgbLed < BaseComponent
      # options = {board: my_board, pins: {red: red_pin, green: green_pin, blue: blue_pin}
      def after_initialize(options={})
        raise 'missing pins[:red] pin' unless self.pins[:red]
        raise 'missing pins[:green] pin' unless self.pins[:green]
        raise 'missing pins[:blue] pin' unless self.pins[:blue]

        pins.each do |color, pin|
          set_pin_mode(pin, :out)
          analog_write(pin, Board::LOW)
        end

        @xor = options[:inverse] ? Board::HIGH : Board::LOW
      end

      def color(r,g,b)
        analog_write(pins[:red],   r ^ @xor)
        analog_write(pins[:green], g ^ @xor)
        analog_write(pins[:blue],  b ^ @xor)
      end

      # Format: [R, G, B]
      COLORS = {
        red:     [255, 000, 000],
        green:   [000, 255, 000],
        blue:    [000, 000, 255],
        cyan:    [000, 255, 255],
        yellow:  [255, 255, 000],
        magenta: [255, 000, 255],
        white:   [255, 255, 255],
        black:   [000, 000, 000]
      }

      COLORS.each_key do |color_name|
        define_method(color_name) { color *COLORS[color_name] }
      end
      alias_method :on,  :white
      alias_method :off, :black

      def blinky
        [:red, :yellow, :green, :cyan, :blue, :magenta].cycle do |color|
          self.send(color)
          sleep(0.1)
        end
      end
    end
  end
end
