class Bohselecta < Formula
  desc "Local model advice and a terminal chooser inside Claude Code"
  homepage "https://irvdotdev.github.io/bohselecta/"
  url "https://github.com/irvdotdev/bohselecta/releases/download/v0.3.0-alpha.6/bohselecta-0.3.0-alpha.6.tar.gz"
  version "0.3.0-alpha.6"
  sha256 "fdd9e8033e6ca4ac971e906e047647f7cfbd7d88bb18320b3a6e90fe61bbadda"
  license "MIT"

  depends_on "node"
  depends_on "tmux"

  on_macos do
    depends_on macos: :sequoia
    on_arm do
      resource "popup" do
        url "https://github.com/irvdotdev/bohselecta/releases/download/v0.3.0-alpha.6/boh-popup-darwin-arm64", using: :nounzip
        sha256 "73d6e6020b6d9591212d8c4e4fa44da4e26e63524e6b0c890aca275835c17ad1"
      end
    end
    on_intel do
      resource "popup" do
        url "https://github.com/irvdotdev/bohselecta/releases/download/v0.3.0-alpha.6/boh-popup-darwin-x64", using: :nounzip
        sha256 "7aa63f410c28cb458032046570cc5a6dd76b2d40dfdeb142a36b3dca928f3447"
      end
    end
  end
  on_linux do
    on_arm do
      resource "popup" do
        url "https://github.com/irvdotdev/bohselecta/releases/download/v0.3.0-alpha.6/boh-popup-linux-arm64", using: :nounzip
        sha256 "3ecaca67e801802499f752b033d2e43bc0509a7ffebb4a956778445807c77281"
      end
    end
    on_intel do
      resource "popup" do
        url "https://github.com/irvdotdev/bohselecta/releases/download/v0.3.0-alpha.6/boh-popup-linux-x64", using: :nounzip
        sha256 "e90a6c924cb4b79581dc5777916b7415d7f41a3472837f66307a77f5f519f757"
      end
    end
  end

  def install
    # Keep the locked dependency tree private to this formula.
    libexec.install Dir["*", ".[^.]*"]
    cd libexec do
      system "npm", "ci", "--omit=dev", "--ignore-scripts", "--no-audit", "--no-fund"
    end
    resource("popup").stage do
      (libexec/"prototypes/popup/prebuilt").install Dir["boh-popup-*"][0] => "boh-popup"
    end
    chmod 0755, libexec/"prototypes/popup/prebuilt/boh-popup"
    (bin/"bohselecta").write_env_script libexec/"bin/bohselecta", PATH: "#{Formula["node"].opt_bin}:#{Formula["tmux"].opt_bin}:$PATH"
  end

  def caveats
    <<~EOS
      Sign in to Claude Code first, then run from your project folder:
        bohselecta native refresh claude
        bohselecta popup claude
    EOS
  end

  test do
    ENV["BOHSELECTA_HOME"] = testpath/"data"
    assert_match version.to_s, shell_output("#{bin}/bohselecta --version")
    result = JSON.parse(shell_output("#{bin}/bohselecta recommend claude 'Fix a typo' --offline --json"))
    assert_equal "recommended", result.fetch("status")
    system libexec/"prototypes/popup/prebuilt/boh-popup", "--self-test"
  end
end
