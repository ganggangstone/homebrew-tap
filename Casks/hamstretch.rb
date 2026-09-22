cask "hamstretch" do
  version "0.1.1"
  sha256 "a649b901406e418b7bbec9bb31e925a357dd5a6a16c2eb85b944fd33f3ed320a"

  url "https://github.com/ganggangstone/hamstretch/releases/download/v#{version}/Hamstretch_#{version}_universal.dmg"
  name "Hamstretch"
  desc "Menu bar app that reminds you to rest your eyes and stretch"
  homepage "https://ganggangstone.github.io/hamstretch/"

  depends_on macos: :big_sur

  app "Hamstretch.app"

  zap trash: [
    "~/Library/Application Support/com.isol.hamster",
  ]
end
