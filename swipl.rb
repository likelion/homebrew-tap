class Swipl < Formula
  desc "ISO/Edinburgh-style Prolog interpreter (devel version)"
  homepage "http://www.swi-prolog.org/"
  url "http://www.swi-prolog.org/download/devel/src/swipl-8.3.14.tar.gz"
  sha256 "eeffa3f209ddf7e784ba5d02cbb1c8078bfc027c8a6802a460086dad29d9d298"

  bottle do
    root_url "https://raw.githubusercontent.com/likelion/homebrew-tap/master/bottles"
    sha256 "bf1476d09141c8a148ba4a17fd50f8ab705608bfc49bc55796e012a54bcbbb8b" => :catalina
  end

  head do
    url "https://github.com/SWI-Prolog/swipl-devel.git"
    depends_on "cmake" => :build
  end

  depends_on "ossp-uuid"
  depends_on "readline"
  depends_on "gmp"
  depends_on "libarchive"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "berkeley-db"=> :optional
  depends_on "unixodbc" => :optional
  depends_on :x11
  depends_on "jpeg"
  depends_on "cmake" => :build
 
  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end
  
  test do
    (testpath/"test.pl").write <<~EOS
      test :-
          write('Homebrew').
    EOS
    assert_equal "Homebrew", shell_output("#{bin}/swipl -s #{testpath}/test.pl -g test -t halt")
  end
end
