class Splitr < Formula
  desc "Sshuttle tunnel manager for macOS with a pf-based kill switch"
  homepage "https://github.com/tasticolly/splitr"
  url "https://github.com/tasticolly/splitr/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "3dfb010deb4847bb5669e555334bc045b2803dd0981de691ad863fea674acc75"
  license "MIT"
  head "https://github.com/tasticolly/splitr.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos
  depends_on "sshuttle"

  def install
    ldflags = "-s -w -X github.com/tasticolly/splitr/internal/daemon.Version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/splitr"
    pkgshare.install "cmd/splitr/config.example.yaml"
  end

  def caveats
    <<~EOS
      The binary alone does nothing: the pf anchor, the config and the
      LaunchDaemon still have to be put in place, which needs root:

        sudo #{opt_bin}/splitr install

      That writes /usr/local/etc/splitr/config.yaml, adds an anchor call to
      /etc/pf.conf (keeping a dated copy of the original), and starts the
      daemon. Edit the config before bringing a tunnel up:

        splitr config edit

      Check the result with `splitr doctor`. To remove everything again:

        sudo #{opt_bin}/splitr uninstall

      The menu bar app is not in this tap yet; build it from a checkout with
      `make menubar`.
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/splitr version")
    assert_match "protection", shell_output("#{bin}/splitr --help 2>&1")
  end
end
