cask "hamstretch" do
  version "0.1.0"
  sha256 "522395be8aae6865cc17a80b7016bb93d39b491f1f46c02819253e764431dc19"

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
