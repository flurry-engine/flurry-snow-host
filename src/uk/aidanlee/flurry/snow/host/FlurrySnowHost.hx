package uk.aidanlee.flurry.snow.host;

import snow.types.Types.AppConfig;
import uk.aidanlee.flurry.Flurry;

typedef UserConfig = {};

class FlurrySnowHost extends snow.App
{
    public var flurry : Flurry;

    public function new()
    {
        flurry = Config.entry();
    }

    override function config(_config : AppConfig) : AppConfig
    {
        flurry.config();

        _config.window.fullscreen       = flurry.flurryConfig.window.fullscreen;
        _config.window.borderless       = flurry.flurryConfig.window.borderless;
        _config.window.resizable        = flurry.flurryConfig.window.resizable;
        _config.window.width            = flurry.flurryConfig.window.width;
        _config.window.height           = flurry.flurryConfig.window.height;
        _config.window.title            = flurry.flurryConfig.window.title;
        _config.window.background_sleep = 0;

        return _config;
    }

    override function ready()
    {
        // Setup snow timestep.
        // Fixed dt of 16.66
        fixed_timestep = true;
        update_rate    = 1 / 60;

        flurry.ready();
    }

    override function update(_dt : Float)
    {
        // HACK : Need a cleaner way to poll input events in the update event instead of the tick.
        // We don't want to be poking into a backend specific runtime or calling SDL from here.
        // (app.runtime : uk.aidanlee.flurry.utils.runtimes.FlurryRuntimeDesktop).pollEvents();

        flurry.update(_dt);
    }

    override function ondestroy()
    {
        flurry.shutdown();
    }
}
