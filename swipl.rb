class Swipl < Formula
  desc "ISO/Edinburgh-style Prolog interpreter (devel version)"
  homepage "http://www.swi-prolog.org/"
  url "http://www.swi-prolog.org/download/devel/src/swipl-8.3.15.tar.gz"
  sha256 "8fd601d8913565d9b38f45b1708e498c0bb833ecba6865383915bad3c2575c95"

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
