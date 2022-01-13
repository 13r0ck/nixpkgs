{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, hidapi
, glib
, cairo
, atk
, pango
, gdk-pixbuf
, gtk3
}:

rustPlatform.buildRustPackage rec {
  pname = "system76-keyboard-configurator";
  version = "v1.1.0";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "keyboard-configurator";
    rev = version;
    sha256 = "1dfhpaqkzsc8h2gms4pd5a542qw2r8pf5c5pv3206nrl1xvvapdr";
  };

  cargoSha256 = "1cdkrryaivaf05p2yym1m1whjkyysinab1wjxvbgipdp54l83flw";

  nativeBuildInputs = [ gtk3 pkg-config ];

  buildInputs = [
    hidapi
    glib
    cairo
    atk
    pango
    gdk-pixbuf
    gtk3
  ];

  postInstall = ''
    # Install icon, etc...
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor
    mkdir $out/share/metainfo

    mv linux/com.system76.keyboardconfigurator.desktop $out/share/applications/com.system76.keyboardconfigurator.desktop
    mv data/icons/* $out/share/icons/hicolor
    mv linux/com.system76.keyboardconfigurator.appdata.xml $out/share/metainfo/com.system76.keyboardconfigurator.appdata.xml
  '';
  
  meta = with lib; {
    description = "Keyboard configuration UI";
    homepage = "https://github.com/pop-os/keyboard-configurator";
    maintainers = with maintainers; [ _13r0ck ];
    license = licenses.gpl3Only;
    platforms = [ "aarch64-linux" "x86_64-linux" ];
  };
}