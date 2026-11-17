# The Homebrew cask for the desktop app, published to the skint007/wikistow
# tap (github.com/skint007/homebrew-wikistow) by .github/workflows/homebrew.yml,
# which fills in the release's version and checksums:
#
#   brew install --cask skint007/wikistow/wikistow
cask "wikistow" do
  arch arm: "arm64", intel: "x64"

  version "0.26.0"
  sha256 arm:   "3d57e9607a393a429a0c7a963f7765dc70651ba5304b8cdb3e641da3698af831",
         intel: "dd86cd6c3d19d4fa14d9438fcdc34815b9c5cdf886defc3f7533208ca8bf3b2d"

  url "https://github.com/skint007/wikistow/releases/download/v#{version}/wikistow-desktop-#{version}-macos-#{arch}.zip"
  name "WikiStow"
  desc "Encrypted wiki for family and friends"
  homepage "https://github.com/skint007/wikistow"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "WikiStow.app"

  # The web clipper's host manifests, which the app writes at each launch
  # for the browsers it finds (docs/desktop.md). They name the app's helper,
  # so they go with it; they aren't the person's data. Removed by a step, as
  # the person: `uninstall delete:` always runs `sudo rm`, which asks for an
  # admin password even for files in the home folder, and fails without a
  # terminal. Homebrew 6.0.16 deprecated the Ruby `uninstall_postflight`.
  # The steps run in a sandbox whose HOME is a temporary folder, so they
  # name the real one with `base: :home` rather than `~`.
  uninstall_postflight_steps do
    remove [
      "Library/Application Support/BraveSoftware/Brave-Browser/NativeMessagingHosts/io.github.skint007.wikistow.json",
      "Library/Application Support/Chromium/NativeMessagingHosts/io.github.skint007.wikistow.json",
      "Library/Application Support/Google/Chrome/NativeMessagingHosts/io.github.skint007.wikistow.json",
      "Library/Application Support/Microsoft Edge/NativeMessagingHosts/io.github.skint007.wikistow.json",
      "Library/Application Support/Mozilla/NativeMessagingHosts/io.github.skint007.wikistow.json",
    ], base: :home
  end

  zap trash: [
    "Library/Application Support/WikiStow",
    "~/Library/Preferences/io.github.skint007.wikistow.plist",
    "~/Library/Saved Application State/io.github.skint007.wikistow.savedState",
  ]
end
