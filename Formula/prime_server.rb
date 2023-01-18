# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class PrimeServer < Formula
  desc "non-blocking (web)server API for distributed computing and SOA based on zeromq"
  homepage "https://github.com/kevinkreiser/prime_server/"
  license "BSD-2-Clause"
  url "https://github.com/kevinkreiser/prime_server.git", branch: "master"
  version "0.7.0"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "zeromq" => :build
  depends_on "czmq" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "./autogen.sh"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
    bin.install "prime_serverd"
    bin.install "prime_httpd"
    bin.install "prime_proxyd"
    bin.install "prime_workerd"
    bin.install "prime_echod"
    bin.install "prime_filed"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test prime_server`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/prime_serverd 100"
  end
end
