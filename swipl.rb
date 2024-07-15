class Swipl < Formula
  desc "ISO/Edinburgh-style Prolog interpreter (devel version)"
  homepage "http://www.swi-prolog.org/"
  url "http://www.swi-prolog.org/download/devel/src/swipl-9.3.8.tar.gz"
  sha256 "86274c28986629be733d1e5cc0adedc836ec76d2a012afd8355c8aafdcb4c316"
  license "BSD-2-Clause"
  head "https://github.com/SWI-Prolog/swipl-devel.git"

  livecheck do
    url "https://www.swi-prolog.org/download/devel/src"
    regex(/href=.*?swipl[._-]v?(\d+\.\d+\.\d+)\.t/i)
  end

  depends_on "cmake" => :build
  depends_on "ossp-uuid"
  depends_on "pkg-config" => :build
  depends_on "berkeley-db@4" => :optional
  depends_on "gmp"
  depends_on "jpeg"
  depends_on "libarchive"
  depends_on "libyaml"
  depends_on "openssl@3"
  depends_on "pcre2"
  depends_on "readline"
  depends_on "unixodbc" => :optional

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args,
                      "-DSWIPL_PACKAGES_JAVA=OFF",
                      "-DCMAKE_INSTALL_PREFIX=#{libexec}",
                      "-DCMAKE_C_COMPILER=/usr/bin/clang",
                      "-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
      system "make", "install"
    end

    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end
  
  test do
    (testpath/"test.pl").write <<~EOS
      test :-
          write('Homebrew').
    EOS
    assert_equal "Homebrew", shell_output("#{bin}/swipl -s #{testpath}/test.pl -g test -t halt")
  end
end
