{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevbawt";
  home.homeDirectory = "/home/trevbawt";
  
  imports = [
    ./firefox.nix
  ]; 

  programs.git = {
    enable = true;
    userName = "Trevor";
    userEmail = "trevor.ros3@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  fonts.fontconfig.enable = true;
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "JetBrains Mono" ]; })
    pkgs.nerd-fonts.jetbrains-mono

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # pkgs.cmatrix  # This was for matrix theme
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/trevbawt/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.bash = { 
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };
    bashrcExtra = "stty -ixon";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.catppuccin
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.catppuccin;
	extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"
          
          set -g @catppuccin_status_modules_right "directory session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          
          set -g @catppuccin_directory_text "#{pane_current_path}"
	'';
      }
    ];
    terminal = "tmux-256color";
    extraConfig = ''
      unbind C-s
      unbind r
      bind r source-file ~/.dotfiles/tmux/tmux.conf
      set-option -g status-position top 
    '';
  };

  programs.lazydocker.enable = true;


  xdg.configFile.nvim.source = ./nvim;
  xdg.configFile.nvim.recursive = true;
  xdg.configFile.kitty.source = ./kitty;
  xdg.configFile.waybar.source = ./waybar;
  xdg.configFile.wofi.source = ./wofi;
  xdg.configFile.hypr.source = ./hypr;
  xdg.configFile.backgrounds.source = ./backgrounds;
  xdg.configFile.btop.source = ./btop;
  xdg.configFile.yazi.source = ./yazi;
  # xdg.configFile.tmux.source = ./tmux;
}
