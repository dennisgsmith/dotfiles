{ pkgs, ... }: {
  home.username = "dennissmith";
  home.homeDirectory = "/Users/dennissmith";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
