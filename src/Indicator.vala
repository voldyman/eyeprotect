using Gtk;
using AppIndicator;

public class Indicator : Object {
	private const string ICON_NAME = "indicator-icon";
	private iProtectApplication app;

	private AppIndicator.Indicator ind;
	private CheckMenuItem activate_item;
	private CheckMenuItem start_on_boot;

	private bool active;

	// time to show the screen after
	private int time_to_screen;

	private uint timer_id;

	public Indicator (iProtectApplication app) {
		this.app = app;

		ind = new AppIndicator.Indicator.with_path (_("iProtect"), ICON_NAME,
													IndicatorCategory.APPLICATION_STATUS, Build.PKGDATADIR);
		ind.set_status (IndicatorStatus.ACTIVE);

		active = app.settings.activate_on_start;
		time_to_screen = app.settings.time_to_wait;
		timer_manager (active);
		setup_menu ();
	}

	private void setup_menu () {
		var ind_menu = new Gtk.Menu ();

		activate_item = new Gtk.CheckMenuItem.with_label (_("Activate"));
		var separator = new Gtk.SeparatorMenuItem ();
		start_on_boot = new Gtk.CheckMenuItem.with_label (_("Start on Boot"));

		activate_item.set_active (active);
		activate_item.toggled.connect (activate_handler);

		start_on_boot.set_active (app.settings.launch_on_boot);
		start_on_boot.toggled.connect (start_boot_handler);

		ind_menu.append (activate_item);
		ind_menu.append (separator);
		ind_menu.append (start_on_boot);

		ind.set_menu (ind_menu);
		ind_menu.show_all ();
	}

	private void start_boot_handler () {
		app.settings.launch_on_boot = !app.settings.launch_on_boot;
		start_on_boot.set_active (app.settings.launch_on_boot);
	}

	private void activate_handler () {
		active = !active;
		activate_item.set_active (active);
		timer_manager (active);
	}

	private void timer_manager (bool active) {
		if (active) {
			start_timer ();
		} else {
			stop_timer ();
		}
	}

	private void start_timer () {
		timer_id = Timeout.add_seconds (time_to_screen, show_screen);
	}

	private void stop_timer () {
		Source.remove (timer_id);
	}

	private bool show_screen () {
		var window = new WaitWindow ();
		window.set_application (this.app);

		window.destroy.connect ( () => {
				timer_manager (active);
			});
		window.show_all ();

		return false;
	}
}