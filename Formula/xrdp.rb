class Xrdp < Formula
  desc "Open source RDP server"
  homepage "http://www.xrdp.org/"
  url "https://github.com/neutrinolabs/xrdp/releases/download/v0.9.23/xrdp-0.9.23.tar.gz"
  sha256 "418a2bc1523b762fb94d2f809573f6c97de7b284899f95ee9583aff770098ba3"
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
