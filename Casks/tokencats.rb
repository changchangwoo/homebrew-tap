# Homebrew cask for changchangwoo/homebrew-tap (Casks/tokencats.rb). scripts/package-release.sh fills in
# VERSION and SHA256; see docs/setup/release.md for why each part is here.
cask "tokencats" do
  version "0.1.4"
  sha256 "2c8e67240bf8060529172a36096943ebcfe838d2d46aad30907857f9d95deda9"

  url "https://github.com/changchangwoo/TokenCats/releases/download/v#{version}/TokenCats-#{version}.zip"
  name "TokenCats"
  desc "Cats in your notch that grow on your AI coding tokens"
  homepage "https://github.com/changchangwoo/TokenCats"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  # The app updates itself through Sparkle, so `brew upgrade` skips it unless run with --greedy.
  auto_updates true

  app "TokenCats.app"

  # Ad-hoc signed and not notarized: remove the quarantine brew adds, or Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/TokenCats.app"]
  end

  uninstall quit: "io.github.changchangwoo.tokencats"

  # Only paths TokenCats alone uses. Hooks and the status line in ~/.claude and ~/.codex are removed from the
  # app (Settings › Agents › disconnect), never by zap.
  zap trash: [
    "~/.tokencats",
    "~/Library/Application Support/TokenCats",
    "~/Library/Preferences/io.github.changchangwoo.tokencats.plist",
  ]
end
