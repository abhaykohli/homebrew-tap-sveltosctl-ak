class Sveltosctl < Formula
  desc "Sveltos command-line interface"
  homepage "https://projectsveltos.github.io/sveltos/latest/getting_started/sveltosctl/sveltosctl/"
  # url "https://github.com/projectsveltos/sveltosctl.git",
  url "https://github.com/abhaykohli/sveltosctl-homebrew.git"
      tag:      "v1.3.3-homebrew-test",
      revision: "aa87951f5e4f38b3b29903041fe69f71b139e86d"
  license "Apache-2.0"
  head "https://github.com/projectsveltos/sveltosctl.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "bash" => :build
  depends_on "go" => :build

  uses_from_macos "rsync" => :build

  on_macos do
    depends_on "coreutils" => :build
  end

  def install
    ENV.prepend_path "PATH", Formula["coreutils"].libexec/"gnubin" if OS.mac?
    ENV["FORCE_HOST_GO"] = "1"

    system "make", "build"
    bin.install "bin/sveltosctl"
  end

  test do
    version_output = shell_output("#{bin}/sveltosctl version 2>&1")
    assert_match "v#{version}", version_output
  end
end
