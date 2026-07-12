{ config, pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    configPath = ".mozilla/firefox";

    policies = {
      DisableTelemetry = true;

      /* ---- EXTENSIONS ---- */
      ExtensionSettings = {
        "*".installation_mode = "blocked"; 
        "uBlock0@raymondhill.net" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      /* ---- PREFERENCES ---- */
      Preferences = { 
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
      };
    };

    /* ---- PROFILES ---- */
    profiles = {
      trevbawt = {           
        id = 0;               
        name = "trevbawt";   
        isDefault = true;     
        
        extensions.force = true;

        settings = {          
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
	  "extensions.autoDisableScopes" = 0;
	  "extensions.enabledScopes" = 15;
        };
      };
    };
  };
}
