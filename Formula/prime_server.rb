class PrimeServer < Formula
  desc "non-blocking (web)server API for distributed computing and SOA based on zeromq"
  homepage "https://github.com/kevinkreiser/prime_server/"
  license "BSD-2-Clause"
  url "https://github.com/kevinkreiser/prime_server/archive/refs/tags/0.7.0.tar.gz"
  version "0.7.0"
  sha256 "4c540c351cec29c19229b26fb0db1ba5dfba719dd0b4e029198da6a936950107"

  head do
    url "https://github.com/kevinkreiser/prime_server.git", branch: "master"
  end

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "zeromq" => :build
  depends_on "libsodium" => :build
  depends_on "czmq" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/prime_serverd 100"
  end
end
