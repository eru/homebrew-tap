class Xrdp < Formula
  desc "Open source RDP server"
  homepage "http://www.xrdp.org/"
  url "https://github.com/neutrinolabs/xrdp/releases/download/v0.9.17/xrdp-0.9.17.tar.gz"
  sha256 "56b913dd6d0f15b60f7a53963b30ad905f00669c91701db35bb4410be262a77e"
  license "Apache-2.0"
  head "https://github.com/neutrinolabs/xrdp.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "nasm" => :build
  depends_on "pkg-config" => :build
  depends_on "libxfixes"
  depends_on "libxrandr"
  depends_on "openssl@1.1"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@1.1"].opt_lib/"pkgconfig"

    system "./bootstrap"
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-strict-locations
    ]
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/xrdp", "--version"
  end
end
