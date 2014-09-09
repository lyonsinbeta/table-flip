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

FLIP = {
	flipping:   "(╯°□°)╯︵ ┻━┻",
	patience:   "┬─┬ ノ( ゜-゜ノ)",
	pudgy:	    "(ノ ゜Д゜)ノ ︵ ┻━┻",
	battle:     "(╯°□°)╯︵ ┻━┻ ︵ ╯(°□° ╯)",
	me:         "┬─┬ ︵ /(.□. \)",
	aggravated: "(ﾉಥ益ಥ）ﾉ ┻━┻",
	putback:    "(ノ^_^)ノ┻━┻ ┬─┬ ノ( ^_^ノ)",
	dude:       "(╯°Д°）╯︵ /(.□ . \)",
	emotional:  "(╯'□')╯︵ ┻━┻",
	freakout:   "(ﾉಥДಥ)ﾉ︵┻━┻･/",
	hercules:   "(/ .□.)\ ︵╰(゜Д゜)╯︵ /(.□. \)",
	jedi:       "(._.) ~ ︵ ┻━┻",
	bear:       "ʕノ•ᴥ•ʔノ ︵ ┻━┻",
	magical:    "(/¯◡ ‿ ◡)/¯ ~ ┻━┻",
	robot:      "┗[© ♒ ©]┛ ︵ ┻━┻",
	russia:     "ノ┬─┬ノ ︵ ( \o°o)\ ",
	happy:      "┻━┻ ︵ ლ(⌒-⌒ლ)"
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
			username: "#{params["user_name"]} summons the Flipbot",
			icon_emoji: ":rage1:"
		})
	end

  get "/" do
    erb :index
  end

  get "/flipping" do
    FLIP[:flipping]
  end

	post "/flipping" do
		if cu_online_slack?(params)
			slack_client = make_client(params)
		  if params["text"].empty?
				slack_client.notify(FLIP[:flipping])
			elsif FLIP.include? "/#{params["text"].downcase.to_sym}"
				slack.client.notify(FLIP[params["text"].downcase.to_sym])
			else
				slack_client.notify("(╯°□°)╯︵ #{flip_word(params["text"])}")
			end
		else
			redirect "/"
		end
	end

  get "/patience" do
    FLIP[:patience]
  end

  get "/pudgy" do
    FLIP[:pudgy]
  end

  get "/battle" do
    FLIP[:battle]
  end

  get "/me" do
    FLIP[:me]
  end

  get "/aggravated" do
    FLIP[:aggravated]
  end

  get "/putback" do
    FLIP[:putback]
  end

  get "/dude" do
    FLIP[:dude]
  end

  get "/emotional" do
    FLIP[:emotional]
  end

  get "/freakout" do
    FLIP[:freakout]
  end

  get "/hercules" do
    FLIP[:hercules]
  end

  get "/jedi" do
    FLIP[:jedi]
  end

  get "/bear" do
    FLIP[:bear]
  end

  get "/magical" do
    FLIP[:magical]
  end

  get "/robot" do
    FLIP[:robot]
  end

  get "/russia" do
    FLIP[:russia]
  end

  get "/happy" do
    FLIP[:happy]
  end

  get "/flipping/:word" do
    @flipped_word = flip_word(params[:word])
    "(╯°□°)╯︵ #{@flipped_word}"
  end

  not_found do
    "Flipping not found."
  end
end
