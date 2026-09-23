cask "hamstretch" do
  version "0.1.0"
  sha256 "2bbf946c8ae94301878aa4b59cf97ebc74f38a54cc6a3614631d74470e42234b"

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
