{
  description = "Sekhmet nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, mac-app-util, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.stow
	  pkgs.tmux
	  pkgs.neovim
	  pkgs.gnupg
	  pkgs.pinentry-tty
	  pkgs.htop
	  pkgs.ripgrep
	  pkgs.jq
	  pkgs.go
	  pkgs.fnm
	  pkgs.postgresql
	  pkgs.yt-dlp
	  pkgs.git
	  pkgs.gh
	  pkgs.bruno
	  pkgs.obsidian
	  pkgs.cloudflared
	  pkgs.iina
	  pkgs.transmission_4
	  pkgs.net-news-wire
	  pkgs.bun
	  pkgs.hugo
	  pkgs.fastfetch
	  pkgs.ffmpeg
	  pkgs.doctl
	  pkgs.colima
	  pkgs.docker
	  pkgs.dive
	  pkgs.kubectl
	  pkgs.kubernetes-helm
        ];

      environment.variables = {
	  EDITOR = "nvim";
      };

      system.primaryUser = "sekhmet";

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        dock.show-recents = false;
      	finder.FXPreferredViewStyle = "clmv";
      };

      system.keyboard = {
	enableKeyMapping = true;
        remapCapsLockToControl = true;
        nonUS = {
          remapTilde = true;
        };
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        mac-app-util.darwinModules.default
	configuration
      ];
    };
  };
}
