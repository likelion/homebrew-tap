class Swipl < Formula
  desc "ISO/Edinburgh-style Prolog interpreter (devel version)"
  homepage "http://www.swi-prolog.org/"
  url "http://www.swi-prolog.org/download/devel/src/swipl-8.3.11.tar.gz"
  sha256 "ad4be3cab73d56dc6b76692d4ef113707c24663fdfc626c7282ff12644699fce"

  bottle do
    root_url "https://raw.githubusercontent.com/likelion/homebrew-tap/master/bottles"
    sha256 "60aba7fe5a06b90cc01756474f69082421684cbad43dc1aa755c0e0643808864" => :mojave
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
