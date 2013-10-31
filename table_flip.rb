require 'sinatra/base'

class TableFlip < Sinatra::Base

  get "/" do
    erb :index 
  end

  get "/flipping" do
    "(╯°□°)╯︵ ┻━┻"
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

  not_found do
    "Flipping not found."
  end
end

