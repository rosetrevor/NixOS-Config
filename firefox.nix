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
	  "extensions.autoDisableScopes" = 0;
	  "extensions.enabledScopes" = 15;

	  "extensions.pocket.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          
          # Disable other new tab clutter (Sponsored shortcuts/stories)
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          
          # Clean up the layout
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.section.order" = "topsites";
        };
      };
    };
  };
}
