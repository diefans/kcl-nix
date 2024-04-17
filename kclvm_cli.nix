{
	rust_overlay ? import (fetchTarball https://github.com/oxalica/rust-overlay/archive/master.tar.gz),
	pkgs ? import (fetchTarball https://nixos.org/channels/nixos-23.11/nixexprs.tar.xz) { overlays = [ rust_overlay ]; },
}:
let
    libPath = with pkgs; lib.makeLibraryPath [
      # load external libraries that you need in your rust project here
    ];
	rustVersion = "latest";
	# rustVersion = "1.76.0";
	rust = pkgs.rust-bin.stable.${rustVersion}.default.override {
		extensions = [
			"rust-src" # for rust-analyzer
				"rust-analyzer"
		];
	};

	kclvm = pkgs.callPackage ./kclvm.nix { };

in pkgs.rustPlatform.buildRustPackage rec {
	pname = "kclvm";
	version = "0.8.4";

	src = pkgs.fetchFromGitHub {
		owner = "kcl-lang";
		repo = "kcl";
		rev = "v${version}";
		hash = "sha256-htPloaByivO1LikOtH91O6kvuHYFo9rVa5VQiVIf6ug=";
	};
	# https://discourse.nixos.org/t/difficulty-using-buildrustpackage-with-a-src-containing-multiple-cargo-workspaces/10202/5
	sourceRoot = "source/cli";

	cargoPatches = [
		./kclvm_cli/cargo_lock.patch
	];
	cargoLock.lockFile = ./kclvm_cli/Cargo.lock;

	nativeBuildInputs = [
		rust
	];
	buildInputs = [
		kclvm
	];
}
