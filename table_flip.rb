require 'sinatra/base'
require 'slack-notify'

SLACK_TOKEN  = ENV["SLACK_TOKEN"]

class TableFlip < Sinatra::Base

# Thanks to ttscoff for the flippy text bit
# https://gist.github.com/ttscoff/4773500
FLIPPED_LETTERS = {
	" " => " ",
	"a" => "ɐ",
	"b" => "q",
	"c" => "ɔ",
	"d" => "p",
	"e" => "ǝ",
	"f" => "ɟ",
	"g" => "ƃ",
	"h" => "ɥ",
	"i" => "ı",
	"j" => "ɾ",
	"k" => "ʞ",
	"l" => "l",
	"m" => "ɯ",
	"n" => "u",
	"o" => "o",
	"p" => "d",
	"q" => "b",
	"r" => "ɹ",
	"s" => "s",
	"t" => "ʇ",
	"u" => "n",
	"v" => "ʌ",
	"w" => "ʍ",
	"x" => "x",
	"y" => "ʎ",
	"z" => "z",
	"A" => "∀",
	"B" => "q",
	"C" => "Ɔ",
	"D" => "p",
	"E" => "Ǝ",
	"F" => "Ⅎ",
	"G" => "פ",
	"H" => "H",
	"I" => "I",
	"J" => "ſ",
	"K" => "ʞ",
	"L" => "˥",
	"M" => "W",
	"N" => "N",
	"O" => "O",
	"P" => "Ԁ",
	"Q" => "Q",
	"R" => "ɹ",
	"S" => "S",
	"T" => "┴",
	"U" => "∩",
	"V" => "Λ",
	"W" => "M",
	"X" => "X",
	"Y" => "⅄",
	"Z" => "Z",
	"," => "'",
	"!" => "¡",
	"?" => "¿",
	"(" => ")",
	")" => "(",
	"[" => "]",
	"]" => "[",
	"." => "˙",
	'"' => ",,",
	"'" => ","
}

  def flip_word(word)
     word.split(//).reverse.map do |l|
	    FLIPPED_LETTERS[l].nil? ? l : FLIPPED_LETTERS[l]
    end.join("")
  end

	def cu_online_slack?(params)
		true
	end

	def make_client(params)
		SlackNotify::Client.new("cuonline", SLACK_TOKEN, {
			channel: params["channel_name"],
			group: params["group_name"],
			username: "Flipbot",
			icon_emoji: ":rage1:"
		})
	end

  get "/" do
    erb :index
  end

  get "/flipping" do
    "(╯°□°)╯︵ ┻━┻"
  end

	post "/flipping" do
		if cu_online_slack?(params)
			slack_client = make_client(params)
		  if params["text"].empty?
				slack_client.notify("(╯°□°)╯︵ ┻━┻")
			else
				slack_client.notify("(╯°□°)╯︵ #{flip_word(params["text"])}")
			end
		else
			redirect "/"
		end
	end

  get "/patience" do
    "┬─┬ ノ( ゜-゜ノ)"
  end

  get "/pudgy" do
    "(ノ ゜Д゜)ノ ︵ ┻━┻"
  end

  get "/battle" do
    "(╯°□°)╯︵ ┻━┻ ︵ ╯(°□° ╯)"
  end

  get "/me" do
    "┬─┬ ︵ /(.□. \)"
  end

  get "/aggravated" do
    "(ﾉಥ益ಥ）ﾉ ┻━┻"
  end

  get "/putback" do
    "(ノ^_^)ノ┻━┻ ┬─┬ ノ( ^_^ノ)"
  end

  get "/dude" do
    "(╯°Д°）╯︵ /(.□ . \)"
  end

  get "/emotional" do
    "(╯'□')╯︵ ┻━┻"
  end

  get "/freakout" do
    "(ﾉಥДಥ)ﾉ︵┻━┻･/"
  end

  get "/hercules" do
    "(/ .□.)\ ︵╰(゜Д゜)╯︵ /(.□. \)"
  end

  get "/jedi" do
    "(._.) ~ ︵ ┻━┻"
  end

  get "/bear" do
    "ʕノ•ᴥ•ʔノ ︵ ┻━┻"
  end

  get "/magical" do
    "(/¯◡ ‿ ◡)/¯ ~ ┻━┻"
  end

  get "/robot" do
    "┗[© ♒ ©]┛ ︵ ┻━┻"
  end

  get "/russia" do
    "ノ┬─┬ノ ︵ ( \o°o)\ "
  end

  get "/happy" do
    "┻━┻ ︵ ლ(⌒-⌒ლ)"
  end

  get "/flipping/:word" do
    @flipped_word = flip_word(params[:word])
    "(╯°□°)╯︵ #{@flipped_word}"
  end

  not_found do
    "Flipping not found."
  end
end
