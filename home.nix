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
          set -g @catppuccin_flavor "mocha"
	  # Has a bug in V2.1.3 (check tmux.conf for version)
	  # Does not round the corners for current session
          set -g @catppuccin_window_status_style "rounded"
	  set -g @catppuccin_window_text "#W"
	  set -g status-right "#{E:@catppuccin_status_session} #S"
	  set -ag status-right "#{E:@catppuccin_status_application}"
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
	  # set -g status-right "#[fg=#{@thm_teal}]#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S #[fg=#{@thm_teal}, bg=#{@thm_bg}]"
	'';
      }
    ];
    terminal = "tmux-256color";
    extraConfig = ''
      unbind r
      bind-key 0 if-shell "tmux select-window -t :0" "" "new-window -t :0"
      bind-key 1 if-shell "tmux select-window -t :1" "" "new-window -t :1"
      bind-key 2 if-shell "tmux select-window -t :2" "" "new-window -t :2"
      bind-key 3 if-shell "tmux select-window -t :3" "" "new-window -t :3"
      bind-key 4 if-shell "tmux select-window -t :4" "" "new-window -t :4"
      bind-key 5 if-shell "tmux select-window -t :5" "" "new-window -t :5"
      bind-key 6 if-shell "tmux select-window -t :6" "" "new-window -t :6"
      bind-key 7 if-shell "tmux select-window -t :7" "" "new-window -t :7"
      bind-key 8 if-shell "tmux select-window -t :8" "" "new-window -t :8"
      bind-key 9 if-shell "tmux select-window -t :9" "" "new-window -t :9"
      set-option -g status-position top 
      set -g prefix C-Space 
      set -g mouse on
      set -g base-index 1
      set -g window-status-current-format "#[bg=#{@thm_crust},fg=#{@thm_mauve}]#[bg=#{@thm_mauve},fg=#{@thm_crust}]#I#[bg=#{@thm_crust},fg=#{@thm_mauve}]█#[fg=#{@thm_fg},bg=#{@thm_surface_1}]#W#[fg=#{@thm_surface_1},bg=#{@thm_bg}]"
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
